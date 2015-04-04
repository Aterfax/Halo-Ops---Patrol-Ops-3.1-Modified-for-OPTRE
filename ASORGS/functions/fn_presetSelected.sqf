#include "macro.sqf"
disableSerialization;

private["_uniformchecked", "_vestchecked", "_backpackchecked", "_slot","_loadout","_primary","_launcher","_handgun","_magazines","_uniform","_vest","_backpack","_items","_primitems","_secitems","_handgunitems","_uitems","_vitems","_bitems","_handle", "_oldBackpack", "_oldUniform", "_oldVest", "_oldHeadgear", "_oldGoggles", "_oldNV", "_oldRadio", "_oldRadios"];
waitUntil{isNil {ASORGS_loading_preset} };
_combo = ASORGS_getControl(ASORGS_Main_Display, ASORGS_preset_combo);
_slot = _combo lbValue (lbCurSel _combo);
if(_slot == -1) exitWith {};
_loadout = +(profileNamespace getVariable format["%1_gear_new_%2",ASORGS_VAS_Prefix, _slot]);
if(!ASORGS_ShowBackpack) then {
	_oldBackpack = call ASORGS_fnc_GetBackpack;
};
if(!ASORGS_ShowUniform) then {
	_oldUniform = call ASORGS_fnc_GetUniform;
};
if(!ASORGS_ShowVest) then {
	_oldVest = call ASORGS_fnc_GetUniform;
};
if(!ASORGS_ShowHeadgear) then {
	_oldHeadgear = call ASORGS_fnc_GetHeadgear;
};
if(!ASORGS_ShowGoggles) then {
	_oldGoggles = call ASORGS_fnc_GetGoggles;
};
if(!ASORGS_ShowNightvision) then {
	_oldNV = call ASORGS_fnc_GetNightvision;
};
if(ASORGS_DisableLoadingUniqueRadios) then {
	_oldRadio = call ASORGS_fnc_GetRadio;
	_oldRadios = [];
	{ if([_x] call ASORGS_fnc_IsRadio) then { _oldRadios = _oldRadios + [_x]; }; } forEach (call ASORGS_fnc_GetInventoryItems);
};


//[_loadout] call ASORGS_fnc_applyGearArray;
ASORGS_CurrentInventory = (_loadout call ASORGS_fnc_ApplyBlacklist);
ASORGS_BackpackCapacityChanged = true;
ASORGS_VestCapacityChanged = true;
ASORGS_UniformCapacityChanged = true;
ASORGS_WeightChanged = true;

//put weapon items in the form ["", "" ,""] and not [""]
_oldPrimaryWeaponItems = +call ASORGS_fnc_GetPrimaryWeaponItems;
_oldSecondaryWeaponItems = +call ASORGS_fnc_GetLauncherItems;
_oldHandgunItems = +call ASORGS_fnc_GetHandgunItems;

ASORGS_CurrentInventory set [GSVI_PrimaryItems, ["", "", ""]];
ASORGS_CurrentInventory set [GSVI_LauncherItems, ["", "", ""]];
ASORGS_CurrentInventory set [GSVI_HandgunItems, ["", "", ""]];
{
	if((_x != "") && !(isNil '_x')) then {
		[_x] call ASORGS_fnc_AddPrimaryWeaponItem;
	};
} forEach _oldPrimaryWeaponItems;
{
	if((_x != "") && !(isNil '_x')) then {
		[_x] call ASORGS_fnc_AddLauncherItem;
	};
} forEach _oldSecondaryWeaponItems;
{
	if((_x != "") && !(isNil '_x')) then {
		[_x] call ASORGS_fnc_AddHandgunItem;
	};
} forEach _oldHandgunItems;
if(!ASORGS_ShowBackpack) then {
	[_oldBackpack] call ASORGS_fnc_AddBackpack;
};
if(!ASORGS_ShowUniform) then {
	[_oldUniform] call ASORGS_fnc_AddUniform;
};
if(!ASORGS_ShowVest) then {
	[_oldVest] call ASORGS_fnc_AddVest;
};
if(!ASORGS_ShowHeadgear) then {
	[_oldHeadgear] call ASORGS_fnc_AddHeadgear;
};
if(!ASORGS_ShowGoggles) then {
	[_oldGoggles] call ASORGS_fnc_AddGoggles;
};
if(!ASORGS_ShowNightvision) then {
	[_oldNV] call ASORGS_fnc_AddNightvision;
};

if(ASORGS_DisableLoadingUniqueRadios) then {
	//equipped radio
	_loadedradiobase = [call ASORGS_fnc_GetRadio, true] call ASORGS_fnc_GetRadioClass;
	_oldRadioBase = [_oldRadio, true] call ASORGS_fnc_GetRadioClass;
	call ASORGS_fnc_RemoveRadio;
	if(_loadedradiobase == _oldRadioBase) then {
		[[_oldRadio, false] call ASORGS_fnc_GetRadioClass] call ASORGS_fnc_AddRadio;
	} else {
		[_loadedradiobase] call ASORGS_fnc_AddRadio;
	};
	//inventory radios
	_loadedRadios = [];
	{ 
		if([_x] call ASORGS_fnc_IsRadio) then { 
			[_x] call ASORGS_fnc_RemoveInventoryItem;
			_loadedradiobase = [_x, true] call ASORGS_fnc_GetRadioClass;
			_matchingRadio = "";
			for [{_i = 0}, {(_i < (count _oldRadios)) && (_matchingRadio == "")}, {_i = _i + 1}] do {
				if (_loadedradiobase == [_oldRadios select _i, true] call ASORGS_fnc_GetRadioClass) then {
					_matchingRadio = _oldRadios select _i;
					_oldRadios set [_i, "DEL"];
				};
			};
			_oldRadios = _oldRadios - ["DEL"];
			if(_matchingRadio == "") then {
				[_x] call ASORGS_fnc_AddInventoryItem;
			} else {
				//can keep the old ID
				[_matchingRadio] call ASORGS_fnc_AddInventoryItem;
			};
		}; 
	} forEach (call ASORGS_fnc_GetInventoryItems);
};
[_slot] call ASORGS_fnc_ReloadMainDialog;
