#include "macro.sqf";
private ["_weaponCombo", "_scopeCombo", "_railCombo", "_itemCombo", "_itemType", "_count", "_itemCount", "_remove", "_i", "_t", "_r", "_matchingRadio", "_oldRadios", "_x"];
_oldRadios = [];
{ 
	//don't remove TFR radios because they won't be readded
	_name = toArray _x;
	_name resize 3;
	_details = [_x,DB_Misc] call ASORGS_fnc_GetDetails;
	_remove = true;

	//it's a radio that's not in the list, so don't touch it.
	if([_x] call ASORGS_fnc_IsRadio) then {
		_oldRadios = _oldRadios + [_x];
	};
	if(isClass (configFile >> "cfgMagazines" >> _x)) then {
		_remove = false;
	};
	if(_remove) then {
		[_x] call ASORGS_fnc_RemoveInventoryItem;
	};
} forEach (call ASORGS_fnc_GetInventoryItems);

_addMags = {
	_itemComboIDC = _this select 0;
	_comboCount = _this select 1;
	for[{_i = 0},{_i < _comboCount},{_i = _i + 1}] do {
		_itemCombo = ASORGS_getControl(ASORGS_Main_Display,_itemComboIDC);
		_itemType = _itemCombo lbData ( lbCurSel _itemCombo);
		_count = ASORGS_getControl(ASORGS_Main_Display,_itemComboIDC + 2);
		_itemCount = parseNumber ctrlText _count;
		if(_itemType != "") then {
			if([_itemType] call ASORGS_fnc_IsRadio) then {
				for[{_t = 0},{_t < _itemCount},{_t = _t + 1}] do {
					_newRadioBase = [_itemType, true] call ASORGS_fnc_GetRadioClass;
					_matchingRadio = "";
					for[{_r = 0}, {(_r < count _oldRadios) && (_matchingRadio == "")}, {_r = _r + 1}] do {
						if (_newRadioBase == [_oldRadios select _r, true] call ASORGS_fnc_GetRadioClass) then {
							_matchingRadio = _oldRadios select _r;
							_oldRadios set [_r, "DEL"];
						};
					};
					_oldRadios = _oldRadios - ["DEL"];
					if(_matchingRadio == "") then {
						[_itemType] call ASORGS_fnc_AddInventoryItem;
					} else {
						//can keep the old ID
						[_matchingRadio] call ASORGS_fnc_AddInventoryItem;
					};
				};
			} else {
				[_itemType, _itemCount] call ASORGS_fnc_AddInventoryItems;
			};
		};
		//_count ctrlSetText format["%1", {(_x select 0) == _itemType} count (MagazinesAmmoFull ASORGS_Player)];
		_itemComboIDC = _itemComboIDC + 10;
	};
};

[ ASORGS_medical_label + 1, 20] call _addMags;
[ ASORGS_misc_label + 1, 10] call _addMags;

_itemComboIDC = ASORGS_extraattach_label + 1;
_comboCount = 5;
for[{_i = 0},{_i < _comboCount},{_i = _i + 1}] do {
	_itemCombo = ASORGS_getControl(ASORGS_Main_Display,_itemComboIDC);
	_itemType = _itemCombo lbData ( lbCurSel _itemCombo);
	_itemCount = 1;
	if(_itemType != "") then {
		[_itemType] call ASORGS_fnc_AddInventoryItem;
	};
	//_count ctrlSetText format["%1", {(_x select 0) == _itemType} count (MagazinesAmmoFull ASORGS_Player)];
	_itemComboIDC = _itemComboIDC + 10;
};

//sleep 0.05;
//ASORGS_NeedsUpdating = ASORGS_NeedsUpdating - [ASORGS_medical1_combo, ASORGS_medical2_combo, ASORGS_medical3_combo, ASORGS_medical4_combo, ASORGS_medical5_combo,ASORGS_medical6_combo, ASORGS_medical7_combo, ASORGS_medical8_combo, ASORGS_medical9_combo, ASORGS_medical10_combo ,ASORGS_misc1_combo, ASORGS_misc2_combo, ASORGS_misc3_combo, ASORGS_misc4_combo, ASORGS_misc5_combo];