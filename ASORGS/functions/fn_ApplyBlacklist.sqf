#include "macro.sqf"
private["_array", "_this", "_x", "_i", "_inventory", "_arrayindex", "_realclass", "_testclass"];
_inventory = _this;

if(!([(_inventory select GSVI_Primary), true] call ASORGS_fnc_IsAllowed)) then { _inventory set [GSVI_Primary, ""]; };
if(!([(_inventory select GSVI_Launcher), true] call ASORGS_fnc_IsAllowed)) then { _inventory set [GSVI_Launcher, ""]; };
if(!([(_inventory select GSVI_Handgun), true] call ASORGS_fnc_IsAllowed)) then { _inventory set [GSVI_Handgun, ""]; };
if(!([(_inventory select GSVI_Uniform), true] call ASORGS_fnc_IsAllowed)) then { _inventory set [GSVI_Uniform, ""]; };
if(!([(_inventory select GSVI_Vest), true] call ASORGS_fnc_IsAllowed)) then { _inventory set [GSVI_Vest, ""]; };
if(!([(_inventory select GSVI_Backpack), true] call ASORGS_fnc_IsAllowed)) then { _inventory set [GSVI_Backpack, ""]; };
if(!([(_inventory select GSVI_Insignia), true] call ASORGS_fnc_IsAllowed)) then { _inventory set [GSVI_Insignia, ""]; };
//arrays that could be radios
{
	_arrayindex = _x;
	_array = _inventory select _arrayindex;
	{
		_realclass = _x;
		_testclass = if([_realclass] call ASORGS_fnc_IsRadio) then { [_realclass, true] call ASORGS_fnc_GetRadioClass } else {_realclass};
		if(!([_testclass, true] call ASORGS_fnc_IsAllowed)) then {_array set [_forEachIndex, objNull];};
	} foreach _array;
	_array = _array - [objNull];
	_inventory set [_arrayindex, _array]; 
} foreach [GSVI_UniformItems, GSVI_VestItems, GSVI_BackpackItems, GSVI_Items];
//other arrays
{
	_arrayindex = _x;
	_array = _inventory select _arrayindex;
	{
		_realclass = _x;
		if(!([_realclass, true] call ASORGS_fnc_IsAllowed)) then {_array set [_forEachIndex, objNull];};
	} foreach _array;
	_array = _array - [objNull];
	_inventory set [_arrayindex, _array]; 
} foreach [GSVI_PrimaryItems, GSVI_LauncherItems, GSVI_HandgunItems, GSVI_Magazines];

_inventory 