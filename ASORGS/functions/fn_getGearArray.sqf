#include "macro.sqf"
private["_title","_slot","_primary,_launcher","_handgun","_magazines","_uniform","_vest","_backpack","_items","_primitems","_secitems","_handgunitems","_uitems","_vitems","_bitems","_curWep"];
_primary = primaryWeapon ASORGS_Player;
_launcher = secondaryWeapon ASORGS_Player;
_handgun = handGunWeapon ASORGS_Player;
_magazines = [];
_uniform = uniform ASORGS_Player;
_vest = vest ASORGS_Player;
_backpack = backpack ASORGS_Player;
_items = assignedItems ASORGS_Player;
_primitems = primaryWeaponItems ASORGS_Player;
_secitems = secondaryWeaponItems ASORGS_Player;
_handgunitems = handGunItems ASORGS_Player;
_uitems = [];
_vitems = [];
_bitems = [];
if(_uniform != "") then {{_uitems set[count _uitems,_x];} foreach (uniformItems ASORGS_Player);};
if(_vest != "") then {{_vitems set[count _vitems,_x];} foreach (vestItems ASORGS_Player);};
if(_backpack != "") then {{_bitems set[count _bitems,_x];} foreach (backPackItems ASORGS_Player);};
if(goggles ASORGS_Player != "") then { _items set[count _items, goggles ASORGS_Player]; };
if(headgear ASORGS_Player != "") then { _items set[count _items, headgear ASORGS_Player]; };
if(count (primaryWeaponMagazine ASORGS_Player) > 0) then
{
	{
		_magazines set[count _magazines,_x];
	} foreach (primaryWeaponMagazine ASORGS_Player);
};

if(count (secondaryWeaponMagazine ASORGS_Player) > 0) then
{
	{
		_magazines set[count _magazines,_x];
	} foreach (secondaryWeaponMagazine ASORGS_Player);
};

if(count (handgunMagazine ASORGS_Player) > 0) then
{
	{
		_magazines set[count _magazines,_x];
	} foreach (handgunMagazine ASORGS_Player);
};

//vas does this for designator batteries
_curWep = currentWeapon ASORGS_Player;
if("Laserdesignator" in assignedItems ASORGS_Player) then
{
	ASORGS_Player selectWeapon "Laserdesignator";
	if(currentMagazine ASORGS_Player != "") then {_magazines set[count _magazines,(currentMagazine ASORGS_Player)];};
};

ASORGS_Player selectWeapon _curWep;
_insignia = ASORGS_Player call BIS_fnc_getUnitInsignia;
["",_primary,_launcher,_handgun,_magazines,_uniform,_vest,_backpack,_items,_primitems,_secitems,_handgunitems,_uitems,_vitems,_bitems, _insignia] call ASORGS_fnc_ApplyBlacklist


