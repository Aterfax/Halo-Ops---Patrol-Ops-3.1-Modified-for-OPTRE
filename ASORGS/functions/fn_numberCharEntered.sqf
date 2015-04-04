#include "macro.sqf"
//hint format["%1", _this select 1];
_validchars = [48,49,50,51,52,53,54,55,56,57];
if(!((_this select 1) in _validchars)) then {
	_control = (_this select 0);
	_str = toArray ctrlText _control;
	{ if(!(_x in _validchars)) then { _str = _str - [_x];  };  } forEach _str;
	_control ctrlSetText toString _str;
};

true;