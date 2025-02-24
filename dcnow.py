#!/usr/bin/env python

import threading
import os
import json
import time
import logging
import logging.handlers
import sh
import requests
from hashlib import sha256

from uuid import getnode as get_mac

logger = logging.getLogger("dcnow")

API_ROOT = "https://dcnow-2016.appspot.com"
UPDATE_END_POINT = "/api/update/{mac_address}/"

UPDATE_INTERVAL = 15

CONFIGURATION_FILE = os.path.expanduser("~/.dreampi.json")


def hash_mac_address():
    mac = get_mac()
    return sha256(
        ":".join(("%012X" % mac)[i : i + 2] for i in range(0, 12, 2)).encode()
    ).hexdigest()


class DreamcastNowThread(threading.Thread):
    def __init__(self, service):
        self._service = service
        self._running = True
        super(DreamcastNowThread, self).__init__()

    def run(self):
        def post_update():
            if not self._service.enabled:
                return

            lines = [ x for x in sh.tail("/var/log/syslog", "-n", "10", _iter=True) ]
            dns_query = None
            for line in lines[::-1]:
                if "CONNECT" in line and "dreampi" in line:
                    # Don't seek back past connection
                    break

                if "query[A]" in line:
                    # We did a DNS lookup, what was it?
                    remainder = line[line.find("query[A]") + len("query[A]") :].strip()
                    domain = remainder.split(" ", 1)[0].strip()
                    dns_query = sha256(domain.encode()).hexdigest()
                    break

            user_agent = "Mozilla/4.0 (compatible; MSIE 5.5; Windows NT), Dreamcast Now"
            header = {"User-Agent": user_agent}
            mac_address = self._service.mac_address_hash
            data = {}
            if dns_query:
                data["dns_query"] = dns_query

            url = API_ROOT + UPDATE_END_POINT.format(mac_address=mac_address)
            requests.post(url,data=data,headers=header)

        while self._running:
            try:
                post_update()
            except:
                logger.exception("Couldn't update Dreamcast Now!")
            # time.sleep(UPDATE_INTERVAL)
            dcnow_stop.wait(UPDATE_INTERVAL)

    def stop(self):
        self._running = False
        self.join()


class DreamcastNowService(object):
    def __init__(self):
        self._thread = None
        self._mac_address_hash = None
        self._enabled = True
        self.reload_settings()

        logger.setLevel(logging.INFO)
        syslog_handler = logging.handlers.SysLogHandler(address="/dev/log")
        syslog_handler.setFormatter(
            logging.Formatter("%(name)s[%(process)d]: %(levelname)s %(message)s")
        )
        logger.addHandler(syslog_handler)

    def update_mac_address(self):
        self._mac_address_hash = hash_mac_address()
        logger.info("MAC address: {}".format(self._mac_address_hash))

    def reload_settings(self):
        settings_file = CONFIGURATION_FILE

        if os.path.exists(settings_file):
            with open(settings_file, "r") as settings:
                content = json.loads(settings.read())
                self._enabled = content["enabled"]

    def go_online(self, dreamcast_ip):
        logger.info("starting dcnow")
        if not self._enabled:
            return
        global dcnow_stop
        dcnow_stop = threading.Event()
        self.update_mac_address()
        self._thread = DreamcastNowThread(self)
        self._thread.start()
        logger.info("dcnow started")

    def go_offline(self):
        if self._thread is not None:
            logger.info("stopping dcnow")
            global dcnow_stop
            dcnow_stop.set()
            self._thread.stop()
            self._thread = None

    @property
    def enabled(self):
        return self._enabled

    @property
    def mac_address_hash(self):
        return self._mac_address_hash
