#!/bin/bash

removedCount=0

if [ "$EUID" -ne 0 ]
then
  echo "Please run as root: 'sudo ./dreampi-add.sh'"
  exit
fi

while getopts ":r:p:s:h:" opt; do
  case $opt in
    r) remove="$OPTARG"
    ;;
    p) path="$OPTARG"
    ;;
    s) server="$OPTARG"
    ;;
    h) help="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

if [ ! -z "$help" ]
then
  echo "This utility adds CubePi to an existing"
  echo "DreamPi installation."
  echo ""
  echo "Usage:"
  echo " -s '192.168.1.100'"
  echo " Sets the IP of the server to connect to"
  echo " for PSO. Defaults to Sylverant."
  echo ""
  echo " -remove"
  echo " Removes CubePi from a DreamPi installation,"
  echo " if present."
  echo ""
  echo " -p '/home/username'"
  echo " Sets the path of the DreamPi install."
  echo " Defaults to /home/pi."
  echo ""
  echo " -help"
  echo " Shows this help message."
  exit
fi

if [ ! -z "$path" ]
then
  echo "Path is set to" $path
  defaultDirectory=$path
else
  defaultDirectory="/home/pi"
fi

if [[ ! -f $defaultDirectory/dreampi/dcnow.py || ! -f $defaultDirectory/dreampi/etc/dnsmasq.conf ]]
then
  echo "DreamPi does not appear to be installed in" $defaultDirectory/dreampi
  exit
fi

if [ "$remove" == "emove" ]
then
  echo "Removing CubePi additions from DreamPi..."
  if grep -q "# START CUBEPI ADDITIONS" "$defaultDirectory/dreampi/dcnow.py"
  then
    echo "Removing CubePi additions from dcnow.py"
    sed -i '/\# START CUBEPI ADDITIONS/,/\# END CUBEPI ADDITIONS/d' $defaultDirectory/dreampi/dcnow.py
    ((removedCount++))
  fi

  if grep -q "# START CUBEPI ADDITIONS" "$defaultDirectory/dreampi/etc/dnsmasq.conf"
  then
    echo "Removing CubePi additions from dnsmasq.conf"
    sed -i '/\# START CUBEPI ADDITIONS/,/\# END CUBEPI ADDITIONS/d' $defaultDirectory/dreampi/etc/dnsmasq.conf
    ((removedCount++))
  fi

  if [ $removedCount == 0 ]
  then
    echo "CubePi additions have already been removed."
    exit
  else
    echo "Removed CubePi additions from DreamPi."
  fi

  echo "Restarting DreamPi"
  service dreampi restart
  exit
fi

if [ ! -z "$server" ]
then
  echo "PSO server IP is set to" $server
  psoServer=$server
else
  echo "PSO server is set to Sylverant."
  psoServer="138.197.20.130"
fi


if grep -q "# START CUBEPI ADDITIONS" "$defaultDirectory/dreampi/dcnow.py"
then
  echo "CubePi additions already added to dcnow.py"
else
  echo "Adding CubePi additions to dcnow.py..."
  sed -i '/dns_query = None/a \
\            # START CUBEPI ADDITIONS\
\            cubePiDomains = [ "pso-gct01.sonic.isao.net", "pso-gc01.sonic.isao.net", "gc01.st-pso.games.sega.net", "pso-gc1.pso.playsega.com", "pso-ep3t.sonic.isao.net" ]\
\            # END CUBEPI ADDITIONS' $defaultDirectory/dreampi/dcnow.py
  sed -i '/domain = remainder.split(\" \", 1)\[0\].strip()/a \
\                    # START CUBEPI ADDITIONS\
\                    if domain in cubePiDomains:\
\                        domain = "game01.st-pso.games.sega.net"\
\                    # END CUBEPI ADDITIONS' $defaultDirectory/dreampi/dcnow.py
fi

if grep -q "# START CUBEPI ADDITIONS" "$defaultDirectory/dreampi/etc/dnsmasq.conf"
then
  echo "CubePi additions already added to dnsmasq.conf"
  echo "Removing previous CubePi dnsmasq.conf entries..."
  sed -i '/\# START CUBEPI ADDITIONS/,/\# END CUBEPI ADDITIONS/d' $defaultDirectory/dreampi/etc/dnsmasq.conf
fi

echo "Adding CubePi additions to dnsmasq.conf..."
sed -i -e '$a \# START CUBEPI ADDITIONS\
\# NTSC-J PSO Episode I&II Trial\
address=/pso-gct01.sonic.isao.net/'"$psoServer"'\
\# NTSC-J PSO Episode I&II/III\
address=/pso-gc01.sonic.isao.net/'"$psoServer"'\
\# NTSC-U PSO Episode I&II/III\
address=/gc01.st-pso.games.sega.net/'"$psoServer"'\
\# PAL PSO Episode I&II/III\
address=/pso-gc1.pso.playsega.com/'"$psoServer"'\
\# NTSC-J PSO Episode III Trial\
address=/pso-ep3t.sonic.isao.net/'"$psoServer"'\
\# END CUBEPI ADDITIONS' $defaultDirectory/dreampi/etc/dnsmasq.conf

echo "Restarting DreamPi"
service dreampi restart
exit
