#include "macro.sqf";
private ["_weaponCombo", "_scopeCombo", "_railCombo", "_ammoCombo", "_ammoType", "_count", "_ammoCount", "_i", "_ammoComboIDC", "_addMags"];
_removedAny = false;
{ if(_x in ASORGS_throwable) then { [_x] call ASORGS_fnc_RemoveInventoryItem; _removedAny = true; }; } forEach (call ASORGS_fnc_GetInventoryItems);
_ammoTypeCounts = [];

_ammoComboIDC = ASORGS_grenade_label + 1;
for[{_i = 0},{_i < 5},{_i = _i + 1}] do {
	_ammoCombo = ASORGS_getControl(ASORGS_Main_Display,_ammoComboIDC);
	_ammoType = _ammoCombo lbData ( lbCurSel _ammoCombo);
	_count = ASORGS_getControl(ASORGS_Main_Display,_ammoComboIDC + 2);
	_ammoCount = parseNumber ctrlText _count;
	if(_ammoType != "") then {
		[_ammoType, _ammoCount] call ASORGS_fnc_AddInventoryItems;
	};;
	_ammoComboIDC = _ammoComboIDC + 10;
};





