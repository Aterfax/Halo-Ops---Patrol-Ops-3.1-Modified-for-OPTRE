
private ["_name", "_length", "_check"];

_name = toLower (_this select 0);
_check = toLower (_this select 1);
_length = count _check;
if(_length > count _name) exitWith { false; };
(_name select [0,_length]) == (_check)