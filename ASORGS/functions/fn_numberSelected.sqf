#include "macro.sqf"
if(ASORGS_Loading) exitWith{};

disableSerialization;
_control = _this select 0;
_index = _this select 1;

//work out the IDC
_idc = ctrlIDC _control;

_textboxBG = ASORGS_getControl(ASORGS_Main_Display, _idc+2);
_textboxBG ctrlShow true;
_textboxBG ctrlEnable true;
_textbox = ASORGS_getControl(ASORGS_Main_Display, _idc+3);
_textbox ctrlshow true;
_textbox ctrlenable true;
_textbox ctrlSetText (ctrlText _control);
ctrlSetFocus _textbox;