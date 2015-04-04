#include "macro.sqf"
call ASORGS_fnc_RemoveBinoculars;
//just in case he has one in his inventory
{ [(_x select DBF_ClassName)] call ASORGS_fnc_RemoveAllInventoryItems; } forEach (ASORGS_DB select DB_Binoculars);

_control = ASORGS_getControl(ASORGS_Main_Display, ASORGS_binoculars_combo);
_selected = _control lbValue (lbCurSel _control);
if(_selected > -1) then {
	_selectedItem = (ASORGS_DB select DB_Binoculars select _selected);
	_className = _selectedItem select DBF_ClassName;
	_ammoIndexs = _selectedItem select DBF_Magazines;
	

	if(count _ammoIndexs > 0) then {
		//hint format["%1, %2, %3", _className, _ammoIndexs, (ASORGS_DB select DB_Magazines select (_ammoIndexs select 0) select DBF_ClassName)];
		{ [(ASORGS_DB select DB_Magazines select _x select DBF_ClassName)] call ASORGS_fnc_AddInventoryItem;  } forEach _ammoIndexs;
	};
	[_classname] call ASORGS_fnc_AddBinoculars;
};