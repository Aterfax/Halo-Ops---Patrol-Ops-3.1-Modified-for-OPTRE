ASORDOLL_FinishedLoading = false;
ASORGS_Loading = false;
if(isNil 'ASORGS_Whitelist') then {ASORGS_Whitelist = [];};
if(isNil 'ASORGS_Blacklist') then {ASORGS_Blacklist = [];};
#include "macro.sqf"

_endsWith = {
	//infinite loop without this! 
	private["_name", "_length", "_nameend", "_start", "_i", "_result"];
	_name = toArray format["%1", _this select 0];
	_length = count toArray (_this select 1);
	_nameend = [];
	if((count _name) >= _length) then {;
		_start = (count _name) - _length;
		for[{_i = 0}, {_i < _length}, {_i = _i + 1}] do {
			_nameend = _nameend + [(_name select (_start +_i)) ];
		};
	};
	_result = (toString _nameend) == (_this select 1);
	_result
};
_indexof = {
	private["_array", "_value", "_keycolumn", "_result", "_i"];
	_array = _this select 0;
	_value = _this select 1;
	_keycolumn = [_this, 2, 1, [0]] call BIS_fnc_Param;
	_result = -1;
	for[{_i = 0}, {(_i < (count _array)) && (_result == -1)}, {_i = _i + 1}] do {
		if((_array select _i select _keycolumn) == _value) then{
			_result = _i;
		};
	};
	_result
};

_cfgthrowable = ASORGS_throwable;

_cfgexplosives = ASORGS_explosives;


_allMagazineClasses = (configFile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses;

_explosives = [];
_throwable = [];
_magazines = [];
{
	_classname = _x;
	if([_classname, true] call ASORGS_fnc_IsAllowed) then {
		_cfg = configfile >> "CfgMagazines" >> _classname;
		_type = getNumber(_cfg >> "type");
		_displayName = getText(_cfg >> "displayName");
		_picture = getText(_cfg >> "picture");
		_mass = getNumber(_cfg >> "mass");
		_scope = getNumber(_cfg >> "scope");
		if(ASORGS_ShowWeights) then {
		_displayName = format["%1 (%2oz)",_displayName, _mass];
		};
		if(!(_picture == "") ) then {//&& (_scope > 1)
			if(_classname in _cfgexplosives) then {
				_explosives set [count _explosives, [DB_Explosives, _classname, _displayName, _picture, [], count _explosives, _mass]];
			} else {
				if(_classname in _cfgthrowable) then {
					_throwable set[count _throwable, [DB_Throwable, _classname, _displayName, _picture, [], count _throwable, _mass]];
				} else {
					_magazines set[count _magazines, [DB_Magazines,_classname, _displayName, _picture, [], count _magazines, _mass]];
				};
			};
		};
	};
} foreach (_allMagazineClasses);


_allWeaponClasses = (configFile >> "CfgWeapons") call BIS_fnc_getCfgSubClasses;
_weapons = [];
_rifles = [];
_binoculars = [];
_handguns = [];
_launchers = [];
_items = [];
_weaponnames = [];
_handgunnames = [];
_riflenames = [];
_launchernames = [];
_suppressors = [];
_scopes = [];
_rails = [];
_headgear = [];
_uniforms = [];
_vests = [];
_medical = [];
_nightvision = [];
_allattachments = [];
_watches = [];
_radios = [];
_gpss = [];
_maps = [];
_compass = [];
{	
	_classname  =  _x;
	if([_classname, true] call ASORGS_fnc_IsAllowed) then {
		_cfg = configfile >> "CfgWeapons" >> _classname;
		_displayName = getText(_cfg >> "displayName");
		_picture = getText(_cfg >> "picture");
		_desc = getText(_cfg >> "descriptionShort");
		_scope = getNumber(_cfg >> "scope");
		_type = getNumber(_cfg >> "type");
		
		
		_wpnmags = [];
		_muzzles = getArray(_cfg >> "muzzles");
		{
			_muzzcfg = 	if(_x == "this") then { _cfg } else { _cfg >> _x };
			_muzzmags = getArray( _muzzcfg >> "magazines");
			_wpnmags = _wpnmags + _muzzmags;
		} forEach (_muzzles);
		//get mags from each parent
		/*{
			_parent = _x;
			{
				_subclass = (_parent >> _x);
				if(isClass _subclass && (_x in _muzzles)) then {
					_parentmags = getArray( _subclass >> "magazines");
					_wpnmags = (_wpnmags - _parentmags) + _parentmags;
				};
			} forEach (_parent call BIS_fnc_getCfgSubClasses);
		} forEach (_cfg call BIS_fnc_returnParents);*/
		_magindexs = [];
		if((count _wpnmags) > 0) then {
			{ 
				_index = [_magazines, _x, DBF_ClassName] call _indexof;
				if(_index > -1) then {
					_magindexs set[count _magindexs, _index]; 
				};
			} forEach _wpnmags;
		};
		_infotype = -1;
		_wpnrail = [];
		_wpnscopes = [];
		_wpnsuppressors = [];
		_capacity = 0;
		_mass = 0;
		_side = -1;
		if(isClass (_cfg >> "ItemInfo")) then
		{
			_infotype = getNumber (_cfg >> "ItemInfo" >> "Type");
			_cargoVehicle = getText (_cfg >> "ItemInfo" >> "ContainerClass");
			if(_cargoVehicle != "") then {
				_cargoVehicleCfg = (configFile >> "CfgVehicles" >> _cargoVehicle);
				_capacity = getNumber (_cargoVehicleCfg >> "maximumLoad");
			};
			_uniformVehicle = getText (_cfg >> "ItemInfo" >> "uniformClass");
			if(_uniformVehicle != "") then {
				_uniformVehicleCfg = (configFile >> "CfgVehicles" >> _uniformVehicle);
				_side = getNumber (_uniformVehicleCfg >> "side");
			};
			_mass = getNumber (_cfg >> "ItemInfo" >> "mass");
			if([_className, "x39_"] call ASORGS_fnc_StartsWith) then {
				_mass = _mass + 1;
			};
			if(ASORGS_ShowWeights) then {
				_displayName = format["%1 (%2oz)",_displayName, _mass];
			};
		};
		//attachments
		if(isClass (_cfg >> "WeaponSlotsInfo")) then
		{
			//diag_log _classname;
			_wpnrail = getArray(_cfg >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
			_wpnscopes = getArray(_cfg >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
			_wpnsuppressors = getArray(_cfg >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
			_wpnexclude = [];
			_slotclasses = [];
			if(!(_classname in ASORGS_IgnoreJointRails)) then //hack for guns that have ASDG_JR but shouldn't
			{
				{	
					private ["_i" ];
					_slotsinfo = _x;
					for "_i" from 0 to (count(_slotsinfo) - 1) do {
						_slotcfg = _slotsinfo select _i;
						if (isClass _slotcfg) then {
							{
								_thisslotcfg = _x;
								if !((configName _thisslotcfg) in _slotclasses) then {
								//	diag_log (configName _thisslotcfg);
									_proxy = getText(_thisslotcfg >> "linkProxy");
									_slotconfigdetails = _thisslotcfg >> "compatibleItems";
									_slotitems = [];
									if(isClass(_slotconfigdetails)) then {
									//	diag_log ( (count _slotconfigdetails) - 1 );
									//	diag_log ( _slotconfigdetails );
										for "_t" from 0 to ( (count _slotconfigdetails) - 1 ) do {
											if(getNumber (_slotconfigdetails select _t) > 0) then {
												_slotitems = _slotitems + [configName (_slotconfigdetails select _t)];
											} else {
												_wpnexclude = (_wpnexclude - [configName (_slotconfigdetails select _t)]) + [configName (_slotconfigdetails select _t)];
											};
										};
									} else {
									//	diag_log("not a class?");
									//	_slotitems = getArray (_slotconfigdetails);
									};
									if([_proxy, "TOP"] call _endsWith) then {
									//	diag_log (_slotitems);
										_wpnscopes = (_wpnscopes - _slotitems) + _slotitems;
									} else {
										if([_proxy, "SIDE"] call _endsWith) then {
											_wpnrail = (_wpnrail - _slotitems) +  _slotitems;
										} else { //proxy ends with "MUZZLE"
											_wpnsuppressors = (_wpnsuppressors - _slotitems) + _slotitems;
										};
									};
								};
							} forEach (([_slotcfg] call bis_fnc_returnParents) + [_slotcfg]);
						};
					};
				} forEach (([_cfg>>"WeaponSlotsInfo"] call bis_fnc_returnParents) + [(_cfg>>"WeaponSlotsInfo")]);//vas also adds parents attachments
			};
			_wpnrail = _wpnrail - _wpnexclude;
			_wpnsuppressors = _wpnsuppressors - _wpnexclude;
			_wpnscopes = _wpnscopes - _wpnexclude;
		};

		//vas does some acre check here?
		if((_scope >= 2) && (_picture != "") && (_displayName != "")) then {
			_added = false;
			if(_classname in ASORGS_medical) then {
				_medical set [count _medical, [DB_Medical, _classname,_displayName, _picture, [], count _medical, _mass]]; 
				_added = true;
			};
			if(_classname in ASORGS_forceMisc) then {
				_items set [count _items, [DB_Misc, _classname,_displayName, _picture, [], count _items, _mass]]; 
				_added = true;
			};
			if(!_added) then {
				switch (_type) do {
					case IT_HANDGUN: {
						if(!(_displayName in _handgunnames)) then
						{
							_handgunnames set[count _handgunnames,_displayName];
							_handguns set[count _handguns,[DB_Handguns, _classname,_displayName, _picture, _magindexs, count _handguns, _wpnscopes, _wpnrail, _wpnsuppressors]];
						};
					};
					case IT_RIFLE: {
						if(!(_displayName in _riflenames)) then
						{
							_riflenames set[count _riflenames,_displayName];
							_rifles set[count _rifles,[DB_Rifles, _classname,_displayName, _picture, _magindexs, count _rifles, _wpnscopes, _wpnrail, _wpnsuppressors]];
						};
					};
					case IT_LAUNCHER: {
						if(!(_displayName in _launchernames)) then
						{
							_launchernames set[count _launchernames,_displayName];
							_launchers set[count _launchers,[DB_Launchers, _classname,_displayName, _picture, _magindexs, count _launchers, _wpnscopes, _wpnrail, _wpnsuppressors]];
						};
					};
					case IT_BINOCULAR: {
						//infotype 616 or it's a weapon according to vas?
						//magindexs just for laser designators
						if(_infotype == 616) then {
							_nightvision set[count _nightvision, [DB_Nightvision,_classname, _displayName, _picture, _magindexs, count _nightvision]];
						} else {
							_binoculars set[count _binoculars,[DB_Binoculars, _classname,_displayName, _picture, _magindexs, count _binoculars]];
						};
					};
					case IT_ITEM: {
						switch(_infotype) do {
							case IIT_SUPPRESSOR : {
								_suppressors set [count _suppressors, [DB_Suppressors, _classname,_displayName, _picture, [], count _suppressors]]; 
								_allattachments set [count _allattachments, [DB_Attachments, _classname, _displayName, _picture, [], count _allattachments, _mass]];
							};
							case IIT_SCOPE : {
								_scopes set [count _scopes, [DB_Scopes, _classname,_displayName, _picture, [], count _scopes]];
								_allattachments set [count _allattachments, [DB_Attachments, _classname, _displayName, _picture, [], count _allattachments, _mass]];
							};
							case IIT_RAIL : { _rails set [count _rails, [DB_Rail, _classname,_displayName, _picture, [], count _rails]]; 
									_allattachments set [count _allattachments, [DB_Attachments, _classname, _displayName, _picture, [], count _allattachments, _mass]];
							};
							case IIT_HEADGEAR : { _headgear set [count _headgear, [DB_Headgear, _classname,_displayName, _picture, [], count _headgear]]; };
							case IIT_UNIFORM : { 
							
									_uniforms set [count _uniforms, [DB_Uniforms, _classname, _displayName, _picture,_capacity, count _uniforms, _side]]; 

							};
							case IIT_VEST : { _vests set [count _vests,[DB_Vest, _classname,_displayName, _picture, _capacity, count _vests]]; };
							default { 
								_simulation = tolower getText (_cfg >> "simulation");
								switch(_simulation) do {
									case "itemmap": { _maps set [count _maps, [DB_Maps, _classname,_displayName, _picture, [], count _maps, _mass]]};
									case "itemgps": { _gpss set [count _gpss, [DB_GPS, _classname,_displayName, _picture, [], count _gpss, _mass]]};
									case "itemradio": { 
										_add = true;
										//acre 2 radio that doesn't have unique radios is one that shouldn't be shown?
										if(isNumber ( _cfg >> "acre_hasUnique" ) && (getNumber ( _cfg >> "acre_hasUnique") == 0)) then {
											_add = false;
										};
										if(_classname in ["ACRE_BaseRadio", "ACREItemBase"]) then {
											_add = false;
										};
										if(_add) then {
											_radios set [count _radios, [DB_Radios, _classname,_displayName, _picture, [], count _radios, _mass]];
											_items set [count _items, [DB_Misc, _classname,_displayName, _picture, [], count _items, _mass]];
										};
									};
									case "itemcompass": { _compass set [count _compass, [DB_Compass, _classname,_displayName, _picture, [], count _compass, _mass]]};
									case "itemwatch": { _watches set [count _watches, [DB_Watchs, _classname,_displayName, _picture, [], count _watches, _mass]]};
									default {_items set [count _items, [DB_Misc, _classname,_displayName, _picture, [], count _items, _mass]]; };
								};
							};
						};
					};
					default {
						if(!(_displayName in _weaponnames)) then
						{
							_weaponnames set[count _weaponnames,_displayName];
							_weapons set[count _weapons,[DB_Weapons, _classname,_displayName, _picture, [], count _items]];
						};
					};
				};
			};
		};
	};
} forEach (_allWeaponClasses);

_backpacks = [];
_allVehicleClasses = (configFile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses;
{
	_classname = _x;
	if([_classname, true] call ASORGS_fnc_IsAllowed) then {
		_cfg = configfile >> "CfgVehicles" >> _classname;
		_displayName = getText(_cfg >> "displayName");
		_picture = getText(_cfg >> "picture");
		_desc = getText(_cfg >> "descriptionshort");
		_scope = getNumber(_cfg >> "scope");
		_type = getNumber(_cfg >> "type");
		_isbackpack = getNumber(_cfg >> "isbackpack");
		if((_isbackpack==1) &&(_scope >= 2) && (_picture != "") && (_displayName != "")) then {
			_capacity = getNumber (_cfg >> "maximumLoad");
			_backpacks set [count _backpacks, [DB_Backpacks, _classname, _displayName, _picture, _capacity, count _backpacks]];
		};
	};
} forEach (_allVehicleClasses);

_goggles = [];
_allGoggleClasses = (configFile >> "CfgGlasses") call BIS_fnc_getCfgSubClasses;
{
	_classname = _x;
	if([_classname, true] call ASORGS_fnc_IsAllowed) then {
		_cfg = configfile >> "CfgGlasses" >> _classname;
		_displayName = getText(_cfg >> "displayName");
		_picture = getText(_cfg >> "picture");
		_desc = getText(_cfg >> "descriptionshort");
		_scope = getNumber(_cfg >> "scope");

		if((_scope >= 2) && (_picture != "") && (_displayName != "")) then {
			_goggles set [count _goggles, [DB_Goggles, _classname, _displayName, _picture, [], count _goggles]];
		};
	};
} forEach (_allGoggleClasses);

_insignia = [];
_allInsigniaClasses = (configFile >> "CfgUnitInsignia") call BIS_fnc_getCfgSubClasses;
{	_classname = _x;
	if([_classname, true] call ASORGS_fnc_IsAllowed) then {
		
		_cfg = configFile >> "CfgUnitInsignia" >> _classname;
		_picture = getText (_cfg >> "texture");
		_displayName = getText (_cfg >> "displayName");
		if((_picture != "") && (_displayName != "")) then {
			_insignia set [count _insignia, [DB_Insignia, _classname, _displayName, _picture, [], count _insignia]];
		};
	};
} forEach (_allInsigniaClasses);

ASORGS_DB = [_rifles, _launchers, _handguns, _weapons, _items, _binoculars, _suppressors, _scopes, _rails, _headgear, _uniforms, _vests,_magazines,_throwable,_explosives, _backpacks, _medical, _goggles, _nightvision, _allattachments, _insignia, _maps, _gpss, _radios, _compass, _watches];
[] spawn {
	waitUntil {player == player};
	waitUntil {alive player};
	if(ASORGS_BTCReviveWorkaround) then {
		BTC_get_gear = compileFinal "[]";
		BTC_set_gear = compileFinal "[]";
	};
	player addEventHandler["Respawn", "[] spawn ASORGS_fnc_onRespawn"];
};
/*
diag_log "--------------------------------RIFLES" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 0);
diag_log "--------------------------------LAUNCHERS" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 1);
diag_log "--------------------------------Handguns" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 2);
diag_log "--------------------------------unknown weapons" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 3);
diag_log "--------------------------------items" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 4);
diag_log "--------------------------------BINOCUlaRS" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 5);
diag_log "--------------------------------SUPPRESSORS" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 6);
diag_log "--------------------------------SCOPES" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 7);
diag_log "--------------------------------RAILS" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 8);
diag_log "--------------------------------HEADGEAR" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 9);
diag_log "--------------------------------UNIFORMS" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 10);
diag_log "--------------------------------VESTS" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 11);
diag_log "--------------------------------MAGAZINES" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 12);
diag_log "--------------------------------GRENADES" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 13);
diag_log "--------------------------------EXPLOSIVES" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 14);
diag_log "--------------------------------BACKPACKS" ;
{ diag_log format["%1",_x];
} foreach (ASORGS_DB select 15);
*/
ASORDOLL_FinishedLoading = false;