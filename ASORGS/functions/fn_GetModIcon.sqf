private ["_mod", "_modcpp", "_split", "_line"];
if(!ASORGS_ShowModIcons) exitWith {""};

_mod = [_this, 0, "", [""]] call BIS_fnc_Param;
if((_mod == "") || (_mod in ASORGS_NoModIcons)) exitWith {""};
_modcpp = loadFile(_mod + "\mod.cpp");
_split = [_modcpp, ";"] call ASORGS_fnc_Split;
picture = "";
{
	_line = [_x] call ASORGS_fnc_TrimLeft;
	if( [_line, "picture"] call ASORGS_fnc_StartsWith ) then { 	call compile (_line + ";");  };
} foreach _split;

_pic = if(isNil 'picture') then { "" } else { picture };
picture = nil;
if(((_pic find "\") == -1) && (_pic != "")) then //full folder structure
{
	_pic = _mod + "\" + _pic;
};
_pic