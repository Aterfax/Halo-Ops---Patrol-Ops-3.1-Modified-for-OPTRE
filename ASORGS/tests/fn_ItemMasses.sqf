hint 'testing item masses';
#include "macro.sqf"
_allClasses = [];
{
	_db = (ASORGS_DB select _x);
	_allClasses = _allClasses + _db;
} foreach [DB_Rifles, DB_Launchers, DB_Handguns, DB_Weapons, DB_Items, DB_Misc, DB_Binoculars, DB_Suppressors, DB_Scopes, DB_Rail, DB_Headgear, DB_Magazines, DB_Throwable, DB_Explosives, DB_Medical, DB_Goggles, DB_NightVision, DB_Attachments];
ASORGS_TEST_ALLCLASSES = _allClasses;
_capacity = getNumber(configFile >> "CfgVehicles" >> (backpack player) >> "maximumLoad");
removeVest player;
removeUniform player;
{
	_classname = (_x select DBF_Class);
	diag_log format["Testing %1:", _classname];
	clearAllItemsFromBackpack player;
	player addItemToBackpack _classname;
	_actualmass = (loadBackpack player) * _capacity;
	if(_actualmass == 0) then {
		diag_log format["Error, _actualmass == 0. Backpack contents after adding = %1", backpackItems player];
	};
	clearAllItemsFromBackpack player;
	
	_getItemMassMass = (_classname call ASORGS_fnc_GetItemMass);
	if(format["%1", _getItemMassMass] != format["%1", _actualMass]) then {
		diag_log format["Error, _actualmass == %1. ASORGS_fnc_GetItemMass = %2.", _actualmass, _getItemMassMass];
	};
	/* //test ASORGS_DB masses
	_DBMass = _x select DBF_Mass;
	if(!isNil '_DBMass') then {
		if((typename _DBMass) == "SCALAR") then {
		
			if(_DBMass != _actualMass) then {
				diag_log format["Error, _actualmass == %1. _item select DBF_Mass = %2.", _actualmass, _DBMass];
			};
		} else {diag_log format["Error, _actualmass == %1. _item select DBF_Mass = %2.", _actualmass, _DBMass];	};
	} else { 	diag_log "Nil DBF_Mass"; };
	*/
} foreach _allClasses;