# cubepi

Use your GameCube's dial-up modem adapter to connect _Phantasy Star Online Episode I&II_ and _Phantasy Star Online Episode III: C.A.R.D. Revolution_ to the internet -- all while keeping the original [dreampi](https://github.com/Kazade/dreampi)/Dreamcast functionality working.

Based off the incredible work of [Kazade](https://github.com/Kazade)'s [dreampi](https://github.com/Kazade/dreampi).

## Setting up PSO
This applies to any version of PSO available on the GameCube regardless of region. You can also [view this YouTube video showing which values should be set where](https://youtu.be/Z9dcrpzPRrg).

1. Boot up the game and get to the start menu.
2. Press Start, then put the cursor over the 'Website' option, the last item on the start screen list.
3. Depending on if you have a network settings file already on the memory card, the game will either ask you to create a new network settings file, or use an existing on on either Slot A or Slot B's memory card. Select 'Yes' or the first option to approve creating or using the file on Slot A or B. Keep hitting 'Yes' or 'Okay' until you get to the main website screen.
4. From here, press the 'Y' button and select 'Setup' by using either the D-Pad or analogue stick. This is the option immediately to the left of the 'X' in the bottom bar menu.
5. Using 'Provider 1', press 'A' on the 'Edit Menu' button, the right-most button at the top of the page.
6. Press the same button as before to skip this step unless you'd like to rename the ISP name.
7. On this page, make sure the first bullet is selected (tone) and that the bottom-most/last option, Line timout, is set to '99'. Hit 'Next', the right-most button at the top of the page.
8. On this page, set the following and then hit next:
    * User ID: `gc`
    * Password: `gc`
    * Phone Number: `2001` 
10. On this page, set your DNS to manual and point it at a server of your choice, then hit next.
    * [Sylverant](https://sylverant.net): 138.197.20.130
    * [Schthack](https://schtserv.com/forums/app.php/welcome): 3.18.217.27
    * ...or host your own local server using [newserv](https://github.com/fuzziqersoftware/newserv).
12. You can leave proxy server address as is and click 'next', the right-most button at the top of the page.
13. Hit 'Save' by pressing 'A' over the right-most button at the top of the page.
14. Now hit 'Exit', the furthest left button at the top of the page.
15. Return to the game by pressing 'Y' and clicking the farthest right option, the 'X' in the utility and by clicking 'Yes', the left option in the confirmation dialogue.
16. When back at the title screen, press 'Online Mode' or the top-most option and enjoy!

## Other Methods
If you are simply trying to get online to play _Phantasy Star Online Episode I&II_ or _Phantasy Star Online Episode III: C.A.R.D Revolution_, there are other methods that may be easier to accomplish:
- Using [Dolphin](https://dolphin-emu.org/).
- Using a Wii/Wii U and using either [Devolution](https://www.gamebrew.org/wiki/Devolution_Wii) or [Nintendont](https://github.com/FIX94/Nintendont).
