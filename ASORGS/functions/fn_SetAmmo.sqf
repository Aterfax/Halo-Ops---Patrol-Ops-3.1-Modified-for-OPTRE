#include "macro.sqf";
disableSerialization;
private ["_weaponCombo", "_scopeCombo", "_railCombo", "_ammoCombo", "_ammoType", "_count", "_ammoCount", "_i", "_weapon", "_alreadyAdded", "_x" ];
{ if(!(_x in ASORGS_explosives) && !(_x in ASORGS_throwable)) then { [_x] call ASORGS_fnc_RemoveInventoryItem; }; } forEach (call ASORGS_fnc_GetAllMagazines);
//this checks if the ammo type has already been added so it'll work properly with the 'extra ammo' slots.
_alreadyAdded = [];
_addMags = {
	_ammoComboIDC = _this select 0;
	_weapon = _this select 1;
	_weaponAdded = false;
	_ammos = [];
	for[{_i = 0},{_i < 5},{_i = _i + 1}] do {
		_ammoCombo = ASORGS_getControl(ASORGS_Main_Display,_ammoComboIDC);
		_ammoType = _ammoCombo lbData ( lbCurSel _ammoCombo);
		_count = ASORGS_getControl(ASORGS_Main_Display,_ammoComboIDC + 2);
		_ammoCount = parseNumber ctrlText _count;
		if(_ammoCount > 0 && !(_ammoType in _alreadyAdded)  && (_ammoType != "")) then {
			//just add 1 of each ammo type to start with. This way the weapon will be loaded as well as the 40mm grenade.
			[_ammoType, _ammoCount] call ASORGS_fnc_AddInventoryItems;
		};
		_ammoComboIDC = _ammoComboIDC + 10;
	};	
};

//launcher first so they're more likely to get a rocket in the clip.
_weaponCombo = ASORGS_getControl(ASORGS_Main_Display,ASORGS_launcher_combo);
_scopeCombo = ASORGS_getControl(ASORGS_Main_Display,ASORGS_launcherScope_combo);
_weapon = (_weaponCombo lbData lbCurSel _weaponCombo);
[ ASORGS_launcherAmmo_label + 1, _weapon] call _addMags;



//readd primary weapon ammo
_weaponCombo = ASORGS_getControl(ASORGS_Main_Display,ASORGS_primary_combo);
_scopeCombo = ASORGS_getControl(ASORGS_Main_Display,ASORGS_primaryScope_combo);
_railCombo = ASORGS_getControl(ASORGS_Main_Display,ASORGS_primaryRail_combo);
_suppressorCombo = ASORGS_getControl(ASORGS_Main_Display,ASORGS_primarySuppressor_combo);
_weapon = (_weaponCombo lbData lbCurSel _weaponCombo);

[ ASORGS_primaryAmmo_label + 1, _weapon] call _addMags;



_weaponCombo = ASORGS_getControl(ASORGS_Main_Display,ASORGS_handgun_combo);
_scopeCombo = ASORGS_getControl(ASORGS_Main_Display,ASORGS_handgunScope_combo);
_suppressorCombo = ASORGS_getControl(ASORGS_Main_Display,ASORGS_handgunSuppressor_combo);
_weapon = (_weaponCombo lbData lbCurSel _weaponCombo);
[ ASORGS_handgunAmmo_label + 1, _weapon] call _addMags;

//ASORGS_Player addHandgunItem (_scopeCombo lbData lbCurSel _scopeCombo) ;
//ASORGS_Player addHandgunItem (_suppressorCombo lbData lbCurSel _suppressorCombo);


[ ASORGS_extraammo_label + 1, ""] call _addMags;

