/* 
	Author Karel Moricky
	Modified by Lecks to support setting to none with ""
	Description
	Set unit inisgnia (e.g., should insignia on soldiers)

	Parameter(s)
		0 OBJECT
		1 STRING - CfgUnitInsignia class

	Returns
	BOOL - true if insignia was set
*/

private ["_unit","_class","_cfgTexture","_texture"];
_unit = [_this,0,objNull,[objNull]] call bis_fnc_param;
_class = [_this,1,"",[""]] call bis_fnc_param;


//--- Load texture from config.cpp or description.ext

if(_class == "") then {
	_texture = "";
} else {
	_cfgTexture = [["CfgUnitInsignia",_class],configFile] call bis_fnc_loadclass;
	if (_cfgTexture == configFile) exitWith {["'%1' not found in CfgUnitInsignia",_class] call bis_fnc_error; false};
	_texture = getText (_cfgTexture >> "texture");
};

private ["_index"];
_index = -1;
{
	if (_x == "insignia") exitWith {_index = _foreachindex;};
} forEach getArray (configFile >> "CfgVehicles" >>  getText (configFile >> "CfgWeapons" >> uniform _unit >> "ItemInfo" >> "uniformClass") >> "hiddenSelections");

if (_index < 0) then {
	_unit setVariable ["bis_fnc_setUnitInsignia_class",_class,true];
	//uniform doesn't have unit insignia
	false
} else {
	_unit setVariable ["bis_fnc_setUnitInsignia_class",_class,true];
	_unit setObjectTextureGlobal [_index,_texture];
	true
};