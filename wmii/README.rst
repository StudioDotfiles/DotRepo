Features
--------

- use zsh shell as wmiirc dialect
- alternate switch between previous and current view (*MODKEY-Tab*)
- zsh hook scripts for every Wmii event
- notification system that allow several messages at the same time: ``wmii_msg``
  let you have more than one message at a time
- use arrows keys besides defaut keybindings
- compatible with wmii 3.9
- window resizing

TODOLIST
--------

- no alternate switch between column mode (ala dwm)
- clean-up actions/ directory
- support of XF86 multimedia key

Events and hooks
----------------

All Wmii events can be hooked by zsh functions.

For example, the **FocusFloating** event runs the hook responsible of changing the color on the fly and the **Wmii** hook is in charged of managing the session.

See the `functions/events` directory for more examples.


System menu
-----------

*MODKEY-F1*  (or *MODKEY-MENU*) displays help about keybindings configuration.

*MODKEY-F12* opens up Wmii menu for following actions:

- access: go to actions menu
- term: run a terminal
- lock: run the $WMII_XLOCK program
- kill: kill a process
- fontsel: select a new font with xfontsel
- help: generate a dynamic help file which describe current key bindings
- keys: reload keys configuration
- autostart: launch programs found in *autostart/* directory
- rbar: relaunch right bar applications
- restart: reload Wmii instance and configuration
- destroy: destroy a window with the process inside
- quit: quit Wmii

*MODKEY-F2* (or *MODKEY-p*) is the standard run command helper (using zsh directly).

*MODKEY-F3* (or *MODKEY-Return*) run a new terminal.

*MODKEY-F4* list available actions. See it as a kind of shell scripts repository (*MODKEY-a*). I tried to pick some ideas from the `Ubiquity project <https://mozillalabs.com/ubiquity/>`__ and `simpled <http://www.logilab.org/project/simpled>`__:

- 118k
- browse
- conjugue
- debian
- download
- edit
- email
- en-dict
- fr-dict
- log
- map
- mplayer
- open
- popupdict
- progress
- scratchpad
- screen-ls
- ssh
- translate
- urls
- wikipedia

**Warning: to be honest, it's quite unstable and bloated...**

Zsh functions
-------------

Some zsh functions are provided as handy wrappers for well-known utilities:

- wmii_9menu
- wmii_dmenu
- wmii_dzen2
- wmii_key
- wmii_log
- wmii_osd
- wmii_msg
- wmii_volume

Mainly used to group command-line options of the subcalled programs. I'm not using theses ones much anymore since new versions of Wmii provide their own commands now.

Left status bar
---------------

List available tags or select one if clicked (standard behaviour).

Tips
~~~~

- type '-' as input to remove current tag for the current client
- preprend tags with '.' to have them left-aligned
- preprend tags with '#' if you want want to hide them from the tag bar
- preprend tags with '²' to have them on the right

Right status bar
----------------

I add some "widgets" (humm..) with possible mouse actions (see *RightBarClick* event):

- 00_hostname: host name
- 10_network_eth: bandwidth statistics
- 10_network_wlan: wireless information
- 15_battery: battery state
- 20_biff: a biff monitor for mutt
- 30_df: disk usage
- 40_loadavg: display load average with some colors or run htop if clicked
- 50_sound: display volume and set level with wheel mouse buttons. run aumix if clicked
- 60_date: display date or run calendar if clicked
- 70_time: print time or display Wmii menu in popup

The number determines the rank in the status bar.

Keybindings
-----------

All keybindings are defined in the `keys` file, which could let you change easily.
You can see current configuration thanks to the ``help`` action (*MODKEY-F1*)

Here is my configuration::

	 Major Keys Variables (read /usr/include/X11/keysymdef.h)
			MODKEY=Mod4
			UP=k
			DOWN=j
			LEFT=h
			RIGHT=l
			MENUKEY=Menu

	 Font
			WMII_FONT='-*-terminus-*-r-*-*-12-*-*-*-*-*-*-u'

	 Wmii environment
			WMII_TERM="xterm"
			WMII_XLOCK=slock
			WMII_LOGFILE=/tmp/wmii-$USER.log
			WMII_VIEWFILE=$TMPDIR/wmii.view


	 Theme
		 Background color
			WMII_BACKGROUND='	333333'
		 Colors
			WMII_NORMCOLORS='	888888 	111111 	333333'
			WMII_FOCUSCOLORS='	ffff00 	333333 	ffff00'
			WMII_NOTIFCOLORS='	AA11AA 	333333 	111111'
			WMII_STATUSCOLORS="	222222 	6FCF87 	2A7F3F"

	 Floating layer
		 Toggle selected client between floating and managed layers
			$MODKEY-Shift-space
		 Toggle between floating and managed layers
			$MODKEY-space $MODKEY-Control-space

	 Client actions
		 Toggle selected client's fullsceen state
			$MODKEY-f
		 Close client
			$MODKEY-BackSpace
		 Destroy client
			XF86ClearGrab $MODKEY-Shift-c

	 Changing column modes
		 Set column to default mode
			$MODKEY-d
		 Set column to stack mode
			$MODKEY-s
		 Set column to max mode
			$MODKEY-m

	 Wmii oddities
		 Wmii system menu
			$MODKEY-F12 $MODKEY-$MENUKEY
		 Wmii status bar
			$MODKEY-b
		 Wmii help
			$MODKEY-F1

	 Running programs
		 Open program menu
			XF86Start $MODKEY-F2 $MODKEY-p
		 Launch a terminal
			XF86Terminal $MODKEY-F3 $MODKEY-Return
		 Launch a terminal on right column
			$MODKEY-Shift-Return
		 Open wmii actions menu
			$MODKEY-F4 $MODKEY-a
		 Run file manager
			XF86HomePage
		 Open selected URL in browser
			XF86OpenURL $MODKEY-o
		 Run browser
			XF86WWW
		 Run mailer
			XF86Mail
		 Take a screenshot
			$MODKEY-Print
		 Edit file
			$MODKEY-e
		 Run messager
			XF86Messenger
		 Set away status
			XF86Away
		 Search
			XF86Search
		 Hot links
			XF86HotLinks

	 Tag actions
		 Change to another tag
			$MODKEY-t
		 Retag the selected client
			$MODKEY-Shift-t
		 Go to previous selected tag
			$MODKEY-Tab
		 Go to workspace on the left of the tags bar
			$MODKEY-Prior
		 Go to workspace on the right of the tags bar
			$MODKEY-Next

	 Moving around
		 Select the client to the left
			$MODKEY-$LEFT $MODKEY-Left
		 Select the client to the right
			$MODKEY-$RIGHT $MODKEY-Right
		 Select the client below
			$MODKEY-$DOWN $MODKEY-Down
		 Select the client above
			$MODKEY-$UP $MODKEY-Up

	 Moving clients around
		 Move selected client to the left
			$MODKEY-Shift-$LEFT $MODKEY-Shift-Left
		 Move selected client to the right
			$MODKEY-Shift-$RIGHT $MODKEY-Shift-Right
		 Move selected client down
			$MODKEY-Shift-$DOWN $MODKEY-Shift-Down
		 Move selected client up
			$MODKEY-Shift-$UP $MODKEY-Shift-Up

	 Moving through stacks
		 Swap selected client left
			$MODKEY-Control-$LEFT $MODKEY-Control-Left 
		 Swap selected client right
			$MODKEY-Control-$RIGHT $MODKEY-Control-Right
		 Select the stack below
			$MODKEY-Control-$DOWN $MODKEY-Control-Down
		 Select the stack above
			$MODKEY-Control-$UP $MODKEY-Control-Up
		 Move to the numbered tag
			$MODKEY-$i
		 Retag selected client with the numbered tag
			$MODKEY-Shift-$i

	 Resizing clients
		 Shrink horizontally
			$MODKEY-y
			$MODKEY-Shift-y
		 Grow horizontally
			$MODKEY-u
			$MODKEY-Shift-u
		 Shrink vertically
			$MODKEY-i
			$MODKEY-Shift-i
		 Grow vertically
			$MODKEY-g
			$MODKEY-Shift-g

	 Multimedia
		 Volume up
			$MODKEY-KP_Add
			XF86AudioRaiseVolume
		 Volume down
			$MODKEY-KP_Subtract
			XF86AudioLowerVolume
		 Toggle Volume
			XF86AudioMute
		 Audio Pause
			XF86AudioPause

	 System
		 Lock the session
			XF86ScreenSaver
		 Battery status
			XF86Battery
		 Network: Bluetooth status
			XF86Bluetooth
		 Network: Wireless status
			XF86WLAN
		 Log off
			XF86LogOff


Have fun.
