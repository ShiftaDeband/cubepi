(rewrite in progress as of Feb. 6, 2024, this project is incomplete!)

# cubepi

Use your GameCube's dial-up modem adapter to connect _Phantasy Star Online Episode I&II_ and _Phantasy Star Online Episode III: C.A.R.D. Revolution_ to the internet -- all while keeping the original [dreampi](https://github.com/Kazade/dreampi)/Dreamcast functionality working.

Based off the incredible work of [Kazade](https://github.com/Kazade)'s [dreampi](https://github.com/Kazade/dreampi).

## Setting up PSO
This applies to any version of PSO available on the GameCube regardless of region. You can also [view the YouTube video showing which values should be set where](https://youtu.be/lhcQLNbucWc?t=40).

1. Boot up the game and get to the start menu.
2. Press Start, then put the cursor over the 'Website' option, the last item on the start screen list.
3. Depending on if you have a network settings file already on the memory card, the game will either ask you to create a new network settings file, or use an existing on on either Slot A or Slot B's memory card. Select 'Yes' or the first option to approve creating or using the file on Slot A or B. Keep hitting 'Yes' or 'Okay' until you get to the main website screen.
4. From here, press the 'Y' button and select 'Setup' by using either the D-Pad or analogue stick. This is the option immediately to the left of the 'X' in the bottom bar menu.
5. Using 'Provider 1', press 'A' on the 'Edit Menu' button, the right-most button at the top of the page.
6. Press the same button as before to skip this step unless you'd like to rename the ISP name.
7. On this page, make sure the first bullet is selected (tone) and that the bottom-most/last option, Line timout, is set to '99'. Hit 'Next', the right-most button at the top of the page.
8. Set `gc` for your 'User ID', the first field, and `gc` for the 'Password', the second field. Finally, set the 'Phone number 1' field, the third field, to '2001'.  Hit 'Next', the right-most button at the top of the page.
9. Make sure 'DNS server address' is set to 'Automatic', then hit 'Next', the right-most button at the top of the page. (You can keep it to a custom DNS server here if you'd like, or you can also set this using the utility above with `sudo ./dreampi-add.sh -s '[customIP]'`, where [customIP] is the IP address of the server you'd like to connect to. The PSO server defaults to [Sylverant](https://sylverant.net/).)
10. You can leave proxy server address as is and click 'next', the right-most button at the top of the page.
11. Hit 'Save' by pressing 'A' over the right-most button at the top of the page.
12. Now hit 'Exit', the furthest left button at the top of the page.
13. Return to the game by pressing 'Y' and clicking the farthest right option, the 'X' in the utility and by clicking 'Yes', the left option in the confirmation dialogue.
14. When back at the title screen, press 'Online Mode' or the top-most option and enjoy!

## Other Methods
If you are simply trying to get online to play _Phantasy Star Online Episode I&II_ or _Phantasy Star Online Episode III: C.A.R.D Revolution_, there are other methods that may be easier to accomplish:
- Using [Dolphin](https://dolphin-emu.org/).
- Using a Wii/Wii U and using either [Devolution](https://www.gamebrew.org/wiki/Devolution_Wii) or [Nintendont](https://github.com/FIX94/Nintendont).
