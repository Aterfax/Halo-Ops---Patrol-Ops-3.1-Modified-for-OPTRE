#include "macro.sqf"
if(ASORGS_Loading) exitWith{};

disableSerialization;
_control = _this select 0;
_index = _this select 1;

//work out the IDC
_idc = ctrlIDC _control;
_countLabel = ASORGS_getControl(ASORGS_Main_Display, _idc-3);

_currentCount = parseNumber ctrlText _countLabel;
_newCount = parseNumber ctrlText _control;

if(_currentCount != _newCount) then {
	_countLabel ctrlSetText format["%1", _newCount];
	ASORGS_NeedsUpdating = ASORGS_NeedsUpdating + [_idc-5];	
};

_textboxBG = ASORGS_getControl(ASORGS_Main_Display, _idc-1);
_textboxBG ctrlShow false;
_textboxBG ctrlEnable false;
_control ctrlShow false;
_control ctrlEnable false;