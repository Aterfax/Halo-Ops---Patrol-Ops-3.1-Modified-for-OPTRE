
#include "macro.sqf"
private ["_control", "_idc", "_countidc", "_comboidc", "_item", "_added", "_countctrl", "_comboctrl"];
disableSerialization;
_control = _this select 0;

_idc = ctrlIDC _control;


_countidc = _idc + 1;
_comboidc = _idc - 1;

_comboctrl = ASORGS_getControl(ASORGS_Main_Display, _comboidc);
_item = _comboctrl lbData (lbCurSel _comboctrl);
_removed = [_item] call ASORGS_fnc_RemoveInventoryItem;
if(_removed) then {
	_countctrl = ASORGS_getControl(ASORGS_Main_Display, _countidc);
	_newcount = (parseNumber ctrlText _countctrl) - 1;
	_countctrl ctrlSetText format["%1", _newcount];
	[] call ASORGS_fnc_UpdateCapacity;
	if(_newcount == 0) then {
		_comboctrl lbSetCurSel 0;
	};

};



//ASORGS_NeedsUpdating = ASORGS_NeedsUpdating + [_comboidc];