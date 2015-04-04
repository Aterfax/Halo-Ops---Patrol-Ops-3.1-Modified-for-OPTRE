#include "macro.sqf"
call ASORGS_fnc_RemoveGoggles;


_control = ASORGS_getControl(ASORGS_Main_Display, ASORGS_goggles_combo);
_selected = _control lbValue (lbCurSel _control);
if(_selected > -1) then {
	_selectedItem = (ASORGS_DB select DB_Goggles select _selected);
	_className = _selectedItem select DBF_ClassName;
	[_classname] call ASORGS_fnc_AddGoggles;
};