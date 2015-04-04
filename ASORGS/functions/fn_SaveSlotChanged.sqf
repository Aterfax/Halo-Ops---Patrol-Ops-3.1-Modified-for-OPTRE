#include "macro.sqf"
disableSerialization;

_listbox = ASORGS_getControl(ASORGS_save_dialog, ASORGS_save_listbox);
_name = _listbox lbText (lbCurSel _listbox);
_slot = _listbox lbValue (lbCurSel _listbox);
_textbox = ASORGS_getControl(ASORGS_save_dialog, ASORGS_save_textbox);

if(_slot < 0) then {
	_name = "New Preset";
};



_textbox ctrlSetText _name;
