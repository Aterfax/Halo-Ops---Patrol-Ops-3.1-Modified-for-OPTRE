//infinite loop without this! 
private["_name", "_end"];

_name = _this select 0;
_end = _this select 1;
_name = _name select [(count _name)-(count _end), count _end ];
_name == _end