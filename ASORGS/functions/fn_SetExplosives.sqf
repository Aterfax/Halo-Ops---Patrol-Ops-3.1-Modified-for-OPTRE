#include "macro.sqf";
private ["_weaponCombo", "_scopeCombo", "_railCombo", "_ammoCombo", "_ammoType", "_count", "_ammoCount"];
{ if(_x in ASORGS_explosives) then { [_x] call ASORGS_fnc_RemoveInventoryItem; }; } forEach (call ASORGS_fnc_GetInventoryItems);

_addMags = {
	_ammoComboIDC = _this select 0;
	for[{_i = 0},{_i < 5},{_i = _i + 1}] do {
		_ammoCombo = ASORGS_getControl(ASORGS_Main_Display,_ammoComboIDC);
		_ammoType = _ammoCombo lbData ( lbCurSel _ammoCombo);
		_count = ASORGS_getControl(ASORGS_Main_Display,_ammoComboIDC + 2);
		_ammoCount = parseNumber ctrlText _count;
		if(_ammoType != "") then {
			[_ammoType, _ammoCount] call ASORGS_fnc_AddInventoryItems;
		};
		//_count ctrlSetText format["%1", {(_x select 0) == _ammoType} count (MagazinesAmmoFull ASORGS_Player)];
		_ammoComboIDC = _ammoComboIDC + 10;
	};
};

[ ASORGS_explosives_label + 1] call _addMags;
//sleep 0.05;
//ASORGS_NeedsUpdating = ASORGS_NeedsUpdating - [ASORGS_explosives1_combo, ASORGS_explosives2_combo, ASORGS_explosives3_combo, ASORGS_explosives4_combo, ASORGS_explosives5_combo];