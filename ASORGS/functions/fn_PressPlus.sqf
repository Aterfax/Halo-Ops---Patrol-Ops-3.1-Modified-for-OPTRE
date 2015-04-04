#include "macro.sqf"
private ["_control", "_idc", "_countidc", "_comboidc", "_item", "_added", "_countctrl", "_comboctrl"];
disableSerialization;
_control = _this select 0;

_idc = ctrlIDC _control;


_countidc = _idc - 1;
_comboidc = _idc - 3;

_comboctrl = ASORGS_getControl(ASORGS_Main_Display, _comboidc);
_item = _comboctrl lbData (lbCurSel _comboctrl);
_added = [_item] call ASORGS_fnc_AddInventoryItem;
if(_added) then {
	_countctrl = ASORGS_getControl(ASORGS_Main_Display, _countidc);
	_countctrl ctrlSetText format["%1", (parseNumber ctrlText _countctrl) + 1];

	[] call ASORGS_fnc_UpdateCapacity;

};



//ASORGS_NeedsUpdating = ASORGS_NeedsUpdating + [_comboidc];