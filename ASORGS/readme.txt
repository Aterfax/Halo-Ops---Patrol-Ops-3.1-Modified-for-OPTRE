ASOR Gear Selector v1.424

Installation instructions:
Include the following in your description.ext file:
#include "ASORGS\menu.hpp"
class CfgFunctions
{
	#include "ASORGS\cfgfunctions.hpp"
};

Add an action to any thing that you want the Gear Select option to appear on with the following in it's init:
this addAction["<t color='#111111'>Gear Select</t>", "execvm 'ASORGS\open.sqf'"];

Set up any settings you want (including blacklist) in ASORGS\config.sqf.

Usage instructions:
Select your preset and/or gear from the drop down menus.
Zoom in and out with the mouse wheel, rotate with left click/drag and move up/down (when zoomed) with right click/drag.
Push ESC to close.

Features:
Safety - Realtime preview of your character. Your actual character doesn't move. A clone is created on a stage. This means you'll still hear people talking nearby with TFAR. It also means things like triggers won't be fired when using it due to leaving the area.
Compatibility - Forward and backward compatible with VAS 2.5 (and possibly other versions) saves. Extensively tested in Multiplayer (with dedicated server) and Singleplayer.
Speed - A database of all required information is built at load time so not many lookups into the Arma config files are required while playing.
Customizable - Setting to use a custom logo as the background. Settings to allow it to work with multiple medical systems and mods (and class names can be added to the config.sqf to allow it to work with hopefully any mod). 
Usability - Everything you have on your character is laid out in front of you in an organized fashion and can easily be changed.

Blacklist/Whitelist note:
There are 2 ways that the blacklist/whitelist works in this script. The overall ASORGS_Blacklist/ASORGS_Whitelist is applied when building the database during mission init. At this point ammo from weapons that aren't allowed is automatically removed/not put in the database. When the Gear Selector is opened, at runtime Blacklist/Whitelist is generated using any matching Unit Class/Side/Faction specific blacklists/whitelists as defined in the config.sqf. Both the runtime and global blacklists are checked when loading presets.

Forums:
http://forums.bistudio.com/showthread.php?183293-ASOR-Gear-Selector

Change Log:
v1.52 9/4/2015
- Fixes insignias.
- Fixes various attachments not working (BIS doesn't use matching case, so the change below broke some attachments).
- Fixes whitelist (hopefully).
- Adds class specific blacklist/whitelist.
- Fixes some ammo issues from Marksmen DLC.
- Fixes Bipods.

v1.5 25/1/2015
- Uses new configProperties command for faster loading.
- Option to exclude all ammo that's not in any allowed guns. Makes for shorter blacklists and more performance because it's not loading unneeded magazines.
- Fixed save screen for lower resolutions.
- Side/faction specific whitelists should now work properly.
- Made indexs of items to search with the 'find' command instead of manually searching. Note that this makes compatible items case sensitive! If this causes problems with a lot of mods I'll work around it, but that will decrease performance.

v1.424 8/11/2014
- Fixed TFAR 0.97.
- Some fixed for RHS (shows ammo with scope=1 now).

v1.423 27/10/2014
- Fixed a bug where removing a weapon would effectively remove all weapons.
- Fixed the same bug as below but with the pistol/launcher.
- Performance improvement with large black lists.

Change Log:
v1.42 2/10/2014
- Fixed a bug with attachments that was causing the Gear Selector to stop working until the mission restarted, and causing weapon items to not always show when loading kits.

v1.41 16/9/2014
- Adds close button.
- Adds weight bar.

v1.4 8/9/2014
- Adds a delay for loading inventory items to ensure radios can be added even when inventory is full.
- Overhaul of some UI elements to make it look better.
- Adds settings to hide certain slots such as uniform and vest.
- Adds whitelist.

v1.3 1/9/2014
- New backend for managing inventory without constantly adding/removing items from characters. Much smoother feeling result and less risk of server lag.
- Adds support for ACRE2. Will automatically switch between TFAR radios and ACRE radios in loaded presets.
- New workarounds for TFAR radios.. should now always work as expected. Unique radio IDs will be kept unless radios are changed.
- Adds slots for Radio/GPS/Map/Compass/Watch.

v1.21 - 8/8/2014
- Change to the workaround for TFAR to make it assign your radios immediately after closing the gear selector.
- Fixes load on respawn only working when you open the gear selector.
- Fixes open.sqf not always working.

v1.2 - 31/7/2014
- Fixes some problems with TFAR. Radios that have been assigned an ID will not show in the gear selector. Radios will not be assigned an ID until 10 seconds after you close the gear selector.
- Adds delete button to preset save dialog.
- Adds the ability to use the gear selector on units other than the player ( [unit] execvm "asorgs\open.sqf" ).
- No longer loads blacklisted items.
- Adds optional workaround to make load on respawn sort of work with BTC revive (but players will get fully re-equipped when they die).
- Fixes IGUIBack compatibility issue with some scripts.

v1.1 - 16/7/2014
- Fixes compatibility with ASDG_JointRails. Setting in config for guns that don't support it properly.
- Adds option to use unit insignia as background (if the unit has one).
- Presets are now updated when saving (without closing/opening the menu).
- Adds option in config for players to automatically get their kits back when respawning. The last gear they had when they close the menu will be loaded if this option is turned on.
- Lets players choose/save/load their unit insignia (with an option to turn off this feature).
- Uses forceAddUniform to properly allow enemy/other teams' uniforms.
- Adds an extra 10 medical slots (now 20) to properly support XMedSys2 and any others with a lot of medical items.
- Changes the way helmets are loaded so they should always work.
- Fixes scrollbar on save screen.
- Adds side and faction specific blacklists.

Known Issues:
- Need to wait for TFAR to give you a squad backpack for it to show accurately.
- You get a random face in multiplayer thanks to the following Arma bug: http://feedback.arma3.com/view.php?id=15786 .

Supported Languages:
- English 

Credits/Thanks:
Lecks - Author
Tonic / VAS for insight in distinguishing between different item types.
ASOR for helping to iron out most of the bugs and problems.

Legal disclaimer:
You are free to:
Share — to copy, distribute and transmit the work.
Modify — to adapt the work.

Under the following conditions:
Notification - If you improve this work, you must give Lecks a copy of the improvements and the option of including it in a new version of this work if he sees fit.