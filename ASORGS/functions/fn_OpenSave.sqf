#include "macro.sqf"
disableSerialization;
waitUntil {!isNull (findDisplay ASORGS_save_dialog)};
_control = ASORGS_getControl(ASORGS_save_dialog,ASORGS_save_listbox);
lbClear _control;
_control lbAdd "<< New Preset Slot >>";
_control lbSetValue [(lbSize _control)-1,-1];
for "_i" from 0 to ASORGS_SaveSlots do
{
	_slotName = format["%1_gear_new_%2",ASORGS_VAS_Prefix,_i];
	if(!isNil {profileNamespace getVariable _slotName}) then
	{
		_control lbAdd format["%1",(profileNamespace getVariable _slotName) select 0];
		_control lbSetValue [(lbSize _control)-1,_i];
	};
};