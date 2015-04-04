#include "macro.sqf"
disableSerialization;
private["_title","_slot","_primary,_launcher","_handgun","_magazines","_uniform","_vest","_backpack","_items","_primitems","_secitems","_handgunitems","_uitems","_vitems","_bitems","_curWep"];
_listbox = ASORGS_getControl(ASORGS_save_dialog, ASORGS_save_listbox);
_textbox = ASORGS_getControl(ASORGS_save_dialog, ASORGS_save_textbox);
_title = ctrlText _textbox;
_slot = _listbox lbValue (lbCurSel _listbox);
//if nothing selected
if((lbCurSel _listbox) == -1) then {
	_slot = -1;
};
for[{_i = 0}, {(_i <= ASORGS_SaveSlots) && (_slot == -1)}, {_i = _i + 1}] do {
	_loadout = profileNamespace getVariable format["%1_gear_new_%2",ASORGS_VAS_Prefix, _i];
	if(isNil {_loadout}) then {
		_slot = _i;
	};
};

if( _slot == -1) exitWith {};

_loadout = ASORGS_CurrentInventory;
_loadout set [0, _title];
profileNameSpace setVariable[format["%1_gear_new_%2",ASORGS_VAS_Prefix, _slot],_loadout];
saveProfileNamespace;

(findDisplay ASORGS_save_dialog ) closeDisplay 1;

[_slot] call ASORGS_fnc_UpdatePresets;
