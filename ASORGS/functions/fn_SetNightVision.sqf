#include "macro.sqf"
call ASORGS_fnc_RemoveNightvision;
//just in case he has one in his inventory
{ [(_x select DBF_ClassName)] call ASORGS_fnc_RemoveAllInventoryItems; } forEach (ASORGS_DB select DB_NightVision);

_control = ASORGS_getControl(ASORGS_Main_Display, ASORGS_nightvision_combo);
_selected = _control lbValue (lbCurSel _control);
if(_selected > -1) then {
	_selectedItem = (ASORGS_DB select DB_NightVision select _selected);
	_className = _selectedItem select DBF_ClassName;
	_ammoIndexs = _selectedItem select DBF_Magazines;
	[_className] call ASORGS_fnc_AddNightVision;
	if(count _ammoIndexs > 0) then {
		{ [(ASORGS_DB select DB_Magazines select _x select DBF_ClassName)] call ASORGS_fnc_AddInventoryItem;  } forEach _ammoIndexs;
	};
};