#include "macro.sqf";
_control = ASORGS_getControl(ASORGS_Main_Display,ASORGS_preset_combo);
_selectedPreset = [_this, 0, -1, [1]] call BIS_fnc_Param;

lbClear _control;
_control lbAdd "None";
_control lbSetValue [(lbSize _control)-1,-1];
//if(_selectedPreset == -1) then {  //set it anyway incase preset doesn't exist
_control lbSetCurSel ((lbSize _control)-1);
// };
for "_i" from 0 to ASORGS_SaveSlots do
{
	_slotName = format["%1_gear_new_%2",ASORGS_VAS_Prefix,_i];
	if(!isNil {profileNamespace getVariable _slotName}) then
	{
		_control lbAdd format["%1",(profileNamespace getVariable _slotName) select 0];
		_control lbSetValue [(lbSize _control)-1,_i];
		if(_selectedPreset == _i) then { _control lbSetCurSel ((lbSize _control)-1); };
	};
};
ASORGS_NeedsUpdating = ASORGS_NeedsUpdating - [ASORGS_preset_combo];