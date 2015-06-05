#include "macro.sqf"
if(isNil 'ASORGS_Clone') exitWith {};
private ["_desiredUniform", "_currentUniform", "_desiredPrimaryWeapon", "_currentPrimaryWeapon", "_desiredPrimaryWeaponItems", "_currentPrimaryWeaponItems", "_desiredLauncher", "_currentLauncher", "_desiredLauncherItems", "_currentLauncherItems", "_desiredHandgun", "_currentHandgun", "_desiredHandgunItems", "_currentHandgunItems", "_desiredVest", "_currentVest", "_desiredHeadgear", "_currentHeadgear", "_desiredGoggles", "_currentGoggles", "_desiredBackpack", "_currentBackpack", "_desiredNightvision", "_currentNightvision", "_desiredInsignia", "_currentInsignia", "_desiredBinoculars", "_currentBinoculars", "_changed", "_i", "_x"];
_desiredUniform = (call ASORGS_fnc_GetUniform); 
_desiredPrimaryWeapon = (call ASORGS_fnc_GetPrimaryWeapon);
_desiredPrimaryWeaponItems = (call ASORGS_fnc_GetPrimaryWeaponItems);
_desiredLauncher = (call ASORGS_fnc_GetLauncher);
_desiredLauncherItems = (call ASORGS_fnc_GetLauncherItems);
_desiredHandgun = (call ASORGS_fnc_GetHandgun);
_desiredHandgunItems = (call ASORGS_fnc_GetHandgunItems);
_desiredVest = (call ASORGS_fnc_GetVest);
_desiredHeadgear = (call ASORGS_fnc_GetHeadgear);
_desiredGoggles = (call ASORGS_fnc_GetGoggles);
_desiredBackpack = (call ASORGS_fnc_GetBackpack);
_desiredNightvision = (call ASORGS_fnc_GetNightVision);
_desiredInsignia = (call ASORGS_fnc_GetInsignia);
_desiredBinoculars = (call ASORGS_fnc_GetBinoculars);
if(!ASORGS_UnitInsigniaOption) then {
	_desiredInsignia = [ASORGS_Player] call BIS_fnc_GetUnitInsignia;
};
_changed = false;
if(isNil 'ASORGS_Clone') exitWith {};
_currentUniform = (uniform ASORGS_Clone);
if(_currentUniform != _desiredUniform) then {
	if(_currentUniform != "") then {
		removeUniform ASORGS_Clone;
	};
	if(_desiredUniform != "") then {
		ASORGS_Clone addUniform _desiredUniform;
	};
	_changed = true;
};
if(isNil 'ASORGS_Clone') exitWith {};
_currentVest = (vest ASORGS_Clone);
if(_currentVest != _desiredVest) then {
	if(_currentVest != "") then {
		removeVest ASORGS_Clone;
	};
	if(_desiredVest != "") then {
		ASORGS_Clone addVest _desiredVest;
	};
	_changed = true;
};
if(isNil 'ASORGS_Clone') exitWith {};
_currentBackpack = (backpack ASORGS_Clone);
if(_currentBackpack != _desiredBackpack) then {
	if(_currentBackpack != "") then {
		removeBackpack ASORGS_Clone;
	};
	if(_desiredBackpack != "") then {
		ASORGS_Clone addBackpack _desiredBackpack;
	};
	_changed = true;
};
if(isNil 'ASORGS_Clone') exitWith {};
_currentGoggles = (goggles ASORGS_Clone);
if(_currentGoggles != _desiredGoggles) then {
	if(_currentGoggles != "") then {
		removeGoggles ASORGS_Clone;
	};
	if(_desiredGoggles != "") then {
		ASORGS_Clone addGoggles _desiredGoggles;
	};
};
if(isNil 'ASORGS_Clone') exitWith {};
_currentHeadgear = (headgear ASORGS_Clone);
if(_currentHeadgear != _desiredHeadgear) then {
	if(_currentHeadgear != "") then {
		removeHeadgear ASORGS_Clone;
	};
	if(_desiredHeadgear != "") then {
		ASORGS_Clone addHeadgear _desiredHeadgear;
	};
};
if(isNil 'ASORGS_Clone') exitWith {};
_currentPrimaryWeapon = (primaryWeapon ASORGS_Clone);
_currentLauncher = (secondaryWeapon ASORGS_Clone);
_currentHandgun = (handgunWeapon ASORGS_Clone);
if((_currentPrimaryWeapon != _desiredPrimaryWeapon) || (_currentLauncher != _desiredLauncher) || (_currentHandgun != _desiredHandgun) ) then {
	{ASORGS_Clone removeMagazine _x;} forEach magazines ASORGS_Clone;
	{ASORGS_Clone removeItem _x;} forEach backpackItems ASORGS_Clone;
	{ASORGS_Clone removeItem _x;} forEach vestItems ASORGS_Clone;
	{ASORGS_Clone removeItem _x;} forEach uniformItems ASORGS_Clone;
	{ ASORGS_Clone addMagazine _x; } forEach (call ASORGS_fnc_GetMagazines);

	if (_currentPrimaryWeapon != _desiredPrimaryWeapon) then {
		if(_currentPrimaryWeapon != "") then {
			ASORGS_Clone removeWeapon _currentPrimaryWeapon;
		};
		if(_desiredPrimaryWeapon != "") then {
			ASORGS_Clone addWeapon _desiredPrimaryWeapon;
			ASORGS_Clone selectWeapon _desiredPrimaryWeapon;
		};
		_changed = true;
	};
	
	if (_currentLauncher != _desiredLauncher) then {
		if(_currentLauncher != "") then {
			ASORGS_Clone removeWeapon _currentLauncher;
		};
		if(_desiredLauncher != "") then {
			ASORGS_Clone addWeapon _desiredLauncher;
			_desiredLauncher spawn {
				waitUntil {_this in weapons ASORGS_Clone};
			//	ASORGS_Clone selectWeapon _this;
			//	ASORGS_Clone switchMove "amovpercmstpsraswlnrdnon";
				ASORGS_Clone switchAction "SecondaryWeapon";
			};
		};
		_changed = true;
	};
	
	if (_currentHandgun != _desiredHandgun) then {
		if(_currentHandgun != "") then {
			ASORGS_Clone removeWeapon _currentHandgun;
		};
		if(_desiredHandgun != "") then {
			ASORGS_Clone addWeapon _desiredHandgun;
			ASORGS_Clone selectWeapon _desiredHandgun;
		};
		_changed = true;
	};
};
if(isNil 'ASORGS_Clone') exitWith {};
_currentHandgunItems = handgunItems ASORGS_Clone;

_itemsToAdd = _desiredHandgunItems - _currentHandgunItems;
_itemsToRemove = _currentHandgunItems - _desiredHandgunItems;
{ ASORGS_Clone removeHandgunItem _x; _changed = true} forEach _itemsToRemove;
{ ASORGS_Clone addHandgunItem _x; ASORGS_Clone selectWeapon _desiredHandgun;  _changed = true } forEach _itemsToAdd;


_currentLauncherItems = secondaryWeaponItems ASORGS_Clone;
_itemsToAdd = _desiredLauncherItems - _currentLauncherItems;
_itemsToRemove = _currentLauncherItems - _desiredLauncherItems;
{ ASORGS_Clone removeSecondaryWeaponItem _x; _changed = true } forEach _itemsToRemove;
{ ASORGS_Clone addSecondaryWeaponItem _x; ASORGS_Clone selectWeapon _desiredLauncher;  _changed = true } forEach _itemsToAdd;


_currentPrimaryWeaponItems = primaryWeaponItems ASORGS_Clone;
_itemsToAdd = _desiredPrimaryWeaponItems - _currentPrimaryWeaponItems;
_itemsToRemove = _currentPrimaryWeaponItems - _desiredPrimaryWeaponItems;
{ ASORGS_Clone removePrimaryWeaponItem _x; _changed = true } forEach _itemsToRemove;
{ ASORGS_Clone addPrimaryWeaponItem _x; ASORGS_Clone selectWeapon _desiredPrimaryWeapon; _changed = true; } forEach _itemsToAdd;


if(isNil 'ASORGS_Clone') exitWith {};
_currentNV = if((count assignedItems ASORGS_Clone) > 0) then {(assignedItems ASORGS_Clone) select 0;} else {""};
if(_currentNV != _desiredNightvision) then {
	removeAllAssignedItems ASORGS_Clone;
	if(_desiredNightVision != "") then {
		ASORGS_Clone addItem _desiredNightVision;
		ASORGS_Clone assignItem _desiredNightvision;
	};
};
	
_currentInsignia = [ASORGS_Clone] call BIS_fnc_GetUnitInsignia;
if(_currentInsignia != _desiredInsignia) then {
	[ASORGS_Clone, _desiredInsignia] call ASORGS_fnc_SetUnitInsignia;
};
/*
if(!(_desiredBinoculars in weapons ASORGS_Clone)) then {
	{ ASORGS_Clone removeWeapon (_x select DBF_Class);    } forEach (ASORGS_DB select DB_Binoculars);
	if(_desiredBinoculars != "") then {
		ASORGS_Clone addWeapon _desiredBinoculars;
		_desiredBinoculars spawn {
			waitUntil {_this in weapons ASORGS_Clone};
			hint _this;
			ASORGS_Clone selectWeapon _this;
		};
	};
};
*/

if(_changed) then {
	[] spawn {
	//	sleep 0.3;
	//	ASORGS_Clone switchMove "AmovPercMstpSlowWrfIDnon";  
	};
};