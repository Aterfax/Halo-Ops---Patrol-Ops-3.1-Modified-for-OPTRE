#include "macro.sqf"
disableSerialization;

_listbox = ASORGS_getControl(ASORGS_save_dialog, ASORGS_save_listbox);
_name = _listbox lbText (lbCurSel _listbox);
_slot = _listbox lbValue (lbCurSel _listbox);
_textbox = ASORGS_getControl(ASORGS_deleteconfirm_dialog, ASORGS_deleteconfirm_text);

if(_slot < 0) then {
	(findDisplay ASORGS_deleteconfirm_dialog) closeDisplay 0;
} else {
	_textbox ctrlSetText format["Are you sure you want to delete '%1'?", _name];
};
