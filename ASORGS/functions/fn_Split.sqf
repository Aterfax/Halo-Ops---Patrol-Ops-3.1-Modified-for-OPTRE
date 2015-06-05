
private ["_string", "_separator", "_finished", "_split", "_splitpos"];

_string = if((typename (_this select 0)) == "STRING") then {_this select 0} else { "" };
_separator = if((typename (_this select 1)) == "STRING") then {_this select 1} else { "" };
//_string = [_this, 0, "", [""]] call BIS_fnc_Param;
//_separator = [_this, 1, ";", [""]] call BIS_fnc_Param;


_finished = false;
_split = [];
while{!_finished} do {
	_splitpos = _string find _separator;
	if(_splitpos == -1) then {
		_split pushBack _string;
		_finished = true;
	} else {
		_split pushBack (_string select [0, _splitpos]);
		_string = _string select [_splitpos+1, count _string - _splitpos - 1];
	};
};
_split