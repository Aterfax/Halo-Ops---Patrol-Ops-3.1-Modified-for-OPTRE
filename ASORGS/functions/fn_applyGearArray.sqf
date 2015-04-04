#include "macro.sqf"
disableSerialization;

private["_this", "_slot","_loadout","_primary","_launcher","_handgun","_magazines","_uniform","_vest","_backpack","_items","_primitems","_secitems","_handgunitems","_uitems","_vitems","_bitems","_handle"];
_blacklistedVehicles = [];
_blacklistedItems = [];
_blacklistedMags = [];
_loadout = _this select 0;
if(isNil {_loadout}) exitWith {}; //Slot data doesn't exist
ASORGS_loading_preset = true;
_primary = _loadout select 1;
_launcher = _loadout select 2;
_handgun = _loadout select 3;
_magazines = _loadout select 4;
_uniform = if(!ASORGS_ShowUniform) then { uniform ASORGS_Player } else { _loadout select 5 };
_vest = if(!ASORGS_ShowVest) then {vest ASORGS_Player} else {_loadout select 6}; 
_backpack = if(!ASORGS_ShowBackpack) then {backpack ASORGS_Player} else { _loadout select 7};
_items = _loadout select 8;
_primitems = _loadout select 9;
_secitems = _loadout select 10;
_handgunitems = _loadout select 11;
_uitems = _loadout select 12;
_vitems = _loadout select 13;
_bitems = _loadout select 14;
_insignia = [_loadout, 15, "", [""]] call BIS_fnc_Param;
//Strip the unit down
{ ASORGS_Player removeWeapon _x; }forEach weapons ASORGS_Player; 
{ASORGS_Player removeMagazine _x;} forEach (magazines ASORGS_Player);
removeUniform ASORGS_Player;
removeVest ASORGS_Player;
removeBackpack ASORGS_Player;
removeGoggles ASORGS_Player;
removeHeadGear ASORGS_Player;
{	_removeItem=  true;
	_name = toArray format["%1", _x];
   _name resize 3;
/*	if (ASORGS_DisableLoadingUniqueRadios && (toString _name == "tf_")) then {
		//it's a task force radio so don't remove it.
		_removeItem = false;
	};*/
	if (_removeItem) then {
		ASORGS_Player unassignItem _x;
		ASORGS_Player removeItem _x;
	};
} foreach (assignedItems ASORGS_Player);

//Add the gear
if(!ASORGS_ShowUniform || [_uniform, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addUniform _uniform; };
if(!ASORGS_ShowVest || [_vest, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addVest _vest; };
if(!ASORGS_ShowBackpack || [_backpack, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addBackpack _backpack; };
clearMagazineCargoGlobal (unitBackpack ASORGS_Player);
clearItemCargoGlobal (unitBackpack ASORGS_Player);
clearWeaponCargoGlobal (unitBackpack ASORGS_Player);

{
	if([_x, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addMagazine _x};
} forEach _magazines;
if([_primary, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addWeapon _primary;};
if([_launcher, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addWeapon _launcher;};
if([_handgun, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addWeapon _handgun;};

{   _class = _x;
	_addItem=  [_class, true] call ASORGS_fnc_isAllowed;
	
	_isradio = (tolower getText (configFile >> "cfgWeapons" >> _class >> "Simulation")) == "itemradio";
	_isradio = _isradio || ([_class, "tf_"] call ASORGS_fnc_StartsWith) || ([_class, "acre_"] call ASORGS_fnc_StartsWith);
	if(_isradio) then {
		_class = [_class, false] call ASORGS_fnc_GetRadioClass;
	};
	if (_class == "") then { _addItem = false; };
	if (_addItem) then {
		_binocdetails = [_class,DB_Binoculars] call ASORGS_fnc_GetDetails;
		if(count (_binocdetails) < 1) then {	//not binoculars
			if(count ([_class, DB_Headgear] call ASORGS_fnc_GetDetails) < 1) then { //not headgear
				ASORGS_Player addItem _class;
				ASORGS_Player assignItem _class;
			} else { //headgear
				ASORGS_Player addHeadGear _class;
			};
		} else { //binoculars
			{ 
				_magClass = ASORGS_DB select DB_Magazines select _x select DBF_Class;
				{ if(_magClass == _x) then { ASORGS_Player removeMagazine _x; } } foreach (magazines ASORGS_Player);
				ASORGS_Player addMagazine _magClass; 
			} forEach (_binocdetails select DBF_Magazines);
			ASORGS_Player addWeapon (_binocdetails select DBF_Class);
		};
	};
} forEach _items;
{ if([_x, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addPrimaryWeaponItem _x;}} foreach (_primitems);
{ if([_x, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addSecondaryWeaponItem _x;}} foreach (_secitems);
{ if([_x, true] call ASORGS_fnc_isAllowed) then {ASORGS_Player addHandgunItem _x;}} foreach (_handgunitems);  
if(ASORGS_UnitInsigniaOption) then {
	[ASORGS_Player, _insignia] call ASORGS_fnc_SetUnitInsignia;
} else {
	[ASORGS_Player, [ASORGS_Player] call BIS_fnc_GetUnitInsignia] call ASORGS_fnc_SetUnitInsignia;
};
[_uitems, _vitems, _bitems] spawn {
	
	_addItems = {
		_loadRadios = _this select 0;
		_loadItems = _this select 1;
		_uitems = _this select 2 select 0;
		_vitems = _this select 2 select 1;
		_bitems = _this select 2 select 2;
		{ 	
			_class = _x;
			_isradio = (tolower getText (configFile >> "cfgWeapons" >> _class >> "Simulation")) == "itemradio";
			_isradio = _isradio || ([_class, "tf_"] call ASORGS_fnc_StartsWith) || ([_class, "acre_"] call ASORGS_fnc_StartsWith);
			if(_isradio) then {
				_class = [_class, false] call ASORGS_fnc_GetRadioClass;
			};
			if(([_class, true] call ASORGS_fnc_isAllowed) && ((_isradio && _loadRadios) || ((!_isradio) && _loadItems ))) then {
				ASORGS_Player addItemToUniform _class;
			};
		} forEach (_uitems);
		{ 	_class = _x;
			_isradio = (tolower getText (configFile >> "cfgWeapons" >> _class >> "Simulation")) == "itemradio";
			_isradio = _isradio || ([_class, "tf_"] call ASORGS_fnc_StartsWith) || ([_class, "acre_"] call ASORGS_fnc_StartsWith);
			if(_isradio) then {
				_class = [_class, false] call ASORGS_fnc_GetRadioClass; 
			};
			if(([_class, true] call ASORGS_fnc_isAllowed) && ((_isradio && _loadRadios) || ((!_isradio) && _loadItems ))) then {
				ASORGS_Player addItemToVest _class;
			};
		} forEach (_vitems);
		{ 	_class = _x;
			_isradio = (tolower getText (configFile >> "cfgWeapons" >> _class >> "Simulation")) == "itemradio";
			_isradio = _isradio || ([_class, "tf_"] call ASORGS_fnc_StartsWith) || ([_class, "acre_"] call ASORGS_fnc_StartsWith);
			if(_isradio) then {
				_class = [_class, false] call ASORGS_fnc_GetRadioClass;
			};
			if(([_class, true] call ASORGS_fnc_isAllowed) && ((_isradio && _loadRadios) || ((!_isradio) && _loadItems ))) then {
				ASORGS_Player addItemToBackpack _class;
			};
		} forEach (_bitems);
	};
	[true, false, _this] call _addItems;
	//this could be any TFAR var?
	if(!isNil 'TF_radio_request_mutex') then {
		false spawn TFAR_fnc_requestRadios;
		sleep ASORGS_UniqueRadioWaitTime;
	};
	[false, true, _this] call _addItems;
	ASORGS_loading_preset = nil;	
};

if(primaryWeapon ASORGS_Player != "") then
{
	ASORGS_Player selectWeapon (primaryWeapon ASORGS_Player);
};
