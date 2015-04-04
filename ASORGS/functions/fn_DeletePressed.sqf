#include "macro.sqf"
disableSerialization;

_listbox = ASORGS_getControl(ASORGS_save_dialog, ASORGS_save_listbox);
_name = _listbox lbText (lbCurSel _listbox);
_slot = _listbox lbValue (lbCurSel _listbox);
_textbox = ASORGS_getControl(ASORGS_deleteconfirm_dialog, ASORGS_deleteconfirm_text);

if(_slot > -1) then {
	profileNameSpace setVariable[format["%1_gear_new_%2",ASORGS_VAS_Prefix, _slot],nil];
	saveProfileNamespace;
	_control = ASORGS_getControl(ASORGS_Main_Display,ASORGS_preset_combo);
	_selectedSlot = _control lbValue (lbCurSel _control);
	[_selectedSlot] spawn ASORGS_fnc_UpdatePresets;
};
(findDisplay ASORGS_deleteconfirm_dialog) closeDisplay 0;
[] call ASORGS_fnc_OpenSave;