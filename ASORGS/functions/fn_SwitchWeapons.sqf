#include "macro.sqf"
_newWeapon = _this select 0;
//if(_oldWeapon == _newWeapon) exitWith {};
//hint format["switching weapon from %1 to %2", _oldWeapon, _newWeapon];
_type = _this select 1;
_oldWeapon = "";
_db = 0;
switch (_type) do {
	case "primary": {
		_oldWeapon = call ASORGS_fnc_GetPrimaryWeapon;
	};
	case "secondary": {
		_oldWeapon = call ASORGS_fnc_GetLauncher;
	};
	case "handgun": {
		_oldWeapon = call ASORGS_fnc_GetHandgun;
	};
};
if(_oldWeapon != "") then {
	[_oldWeapon] call ASORGS_fnc_RemoveWeapon;
	_muzzles = _oldWeapon call ASORGS_fnc_GetWeaponMuzzleMagazines;
	//remove all old magazines
	{
		_muzzle = _x;
		{
			_mag = _x;
			[_mag] call ASORGS_fnc_RemoveAllInventoryItems;
		} foreach _muzzle;
	} foreach _muzzles;
};
if(_newWeapon != "") then {
	[_newWeapon] call ASORGS_fnc_AddWeapon;
	//first mag in all muzzles
	_newmuzzles = _newWeapon call ASORGS_fnc_GetWeaponMuzzleMagazines;
	_firstmuzzle = true;
	{
		_magsToAdd = if(_firstmuzzle) then { 10 } else { 2 };
		[_x select 0, _magsToAdd] call ASORGS_fnc_AddInventoryItems;
		_firstmuzzle = false;
	} foreach _newmuzzles;
};
[_type] call ASORGS_fnc_UpdateAttachments;
call ASORGS_fnc_UpdateAmmo;
[] call ASORGS_fnc_UpdateUI;
ASORGS_NeedsUpdating = [];