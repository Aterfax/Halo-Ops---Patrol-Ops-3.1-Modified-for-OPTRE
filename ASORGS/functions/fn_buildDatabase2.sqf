if(!hasInterface) exitWith {};
ASORDOLL_FinishedLoading = false;
ASORGS_Loading = false;
if(isNil 'ASORGS_Whitelist') then {ASORGS_Whitelist = [];};
if(isNil 'ASORGS_Blacklist') then {ASORGS_Blacklist = [];};
#include "macro.sqf"
/*
_endsWith = {
	//infinite loop without this! 
	private["_name", "_length", "_nameend", "_start", "_i", "_result"];
	
	_name = _this select 0;
	_length = count ( _this select 1);
	
	_name find (_this select 1) ==
	_nameend = "";
	_start = (count _name) - _length;
	if((count _name) >= _length) then {
		for[{_i = 0}, {_i < _length}, {_i = _i + 1}] do {
			_nameend = _nameend + (_name select (_start +_i));
		};
	};
	_result = (toString _nameend) == (_this select 1);
	_result
};*/
_modnames = [];
_modicons = [];
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


_allMagazineClasses = configProperties[(configFile >> "CfgMagazines"), "isClass(_x) && {(getText(_x >> 'picture') != '') && {[configName(_x), true] call ASORGS_fnc_IsAllowed}}", true];

_explosives = [];
_throwable = [];
_magazines = [];
{
	_cfg = _x;
	_classname = configName(_x);
	_type = getNumber(_cfg >> "type");
	_displayName = getText(_cfg >> "displayName");
	_picture = getText(_cfg >> "picture");
	_mass = getNumber(_cfg >> "mass");
	_modindex = 0;
	if(ASORGS_ShowModIcons) then {
		_mod = configSourceMod _cfg;
		_modindex = _modnames find _mod;
		if (_modindex == -1) then {
			_modicon = [_mod] call ASORGS_fnc_GetModIcon;
			_modnames pushback _mod;
			_modicons pushback _modicon;
			_modindex = (count _modnames) - 1;
		};
	};
	if(ASORGS_ShowWeights) then {
	_displayName = format["%1 (%2oz)",_displayName, _mass];
	};
	if(_classname in _cfgexplosives) then {
		_explosives pushBack [DB_Explosives, _classname, _displayName, _modindex, _picture, [], count _explosives, _mass];
	} else {
		if(_classname in _cfgthrowable) then {
			_throwable pushBack [DB_Throwable, _classname, _displayName, _modindex, _picture, [], count _throwable, _mass];
		} else {
			_magazines pushBAck [DB_Magazines,_classname, _displayName, _modindex, _picture, [], count _magazines, _mass];
		}; 
	};
} foreach (_allMagazineClasses);

_allWeaponClasses = configProperties[(configFile >> "CfgWeapons"), 
"isClass(_x) && {(getNumber(_x >> 'scope') == 2) && {(getText(_x >> 'picture') != '') && (getText(_x >> 'displayName') != '') && {[configName(_x), true] call ASORGS_fnc_IsAllowed} }}", 
true];
//_allWeaponClasses = (configFile >> "CfgWeapons") call BIS_fnc_getCfgSubClasses;
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
_bipods = [];
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
	_cfg = _x;
	_classname = configName(_x);
	_type = getNumber(_cfg >> "type");
	if(_type in [IT_HANDGUN, IT_LAUNCHER, IT_RIFLE]) then {
		_classname = (_classname call ASORGS_fnc_GetWeaponBase);
		if([_classname, true] call ASORGS_fnc_IsAllowed) then {
			
			_cfg = configFile >>"CfgWeapons" >> _classname;
		} else {
			_cfg = nil;
			_classname = nil;
		}
	};
	if(!isNil '_cfg') then {
		_displayName = getText(_cfg >> "displayName");
		_picture = getText(_cfg >> "picture");
		_desc = getText(_cfg >> "descriptionShort");
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
		_wpnbipods = [];
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
			_wpnbipods = getArray(_cfg >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
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
												_slotitems pushBack (configName (_slotconfigdetails select _t));
											} else {
												_wpnexclude = (_wpnexclude - [configName (_slotconfigdetails select _t)]);
												_wpnexclude pushBack (configName (_slotconfigdetails select _t));
											};
										};
									} else {
									//	diag_log("not a class?");
									//	_slotitems = getArray (_slotconfigdetails);
									};
									if([_proxy, "TOP"] call ASORGS_fnc_endsWith) then {
									//	diag_log (_slotitems);
										_wpnscopes = (_wpnscopes - _slotitems) + _slotitems;
									} else {
										if([_proxy, "SIDE"] call ASORGS_fnc_endsWith) then {
											_wpnrail = (_wpnrail - _slotitems) +  _slotitems;
										} else {
											if([_proxy, "UNDERBARREL"] call ASORGS_fnc_endsWith) then {
												_wpnbipods = (_wpnbipods - _slotitems) + _slotitems;
											} else {//proxy ends with "MUZZLE"
												_wpnsuppressors = (_wpnsuppressors - _slotitems) + _slotitems;
											};
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
			_wpnbipods = _wpnbipods - _wpnexclude;
		};
		_modindex = 0;
		if(ASORGS_ShowModIcons) then {
			_mod = configSourceMod _cfg;
			_modindex = _modnames find _mod;
			if (_modindex == -1) then {
				_modicon = [_mod] call ASORGS_fnc_GetModIcon;
				_modnames pushback _mod;
				_modicons pushback _modicon;
				_modindex = (count _modnames) - 1;
			};
		};
		//vas does some acre check here?
		_added = false;
		if(_classname in ASORGS_medical) then {
			_medical pushBack [DB_Medical, _classname,_displayName,_modindex, _picture, [], count _medical, _mass]; 
			_added = true;
		};
		if(_classname in ASORGS_forceMisc) then {
			_items pushBack [DB_Misc, _classname,_displayName,_modindex, _picture, [], count _items, _mass]; 
			_added = true;
		};
		if(!_added) then {
			switch (_type) do {
				case IT_HANDGUN: {
					if(!(_displayName in _handgunnames)) then
					{
						_handgunnames pushBack _displayName;
						_handguns pushBack [DB_Handguns, _classname, _displayName, _modindex, _picture, _magindexs, count _handguns, _wpnscopes, _wpnrail, _wpnsuppressors, _wpnbipods];
					};
				};
				case IT_RIFLE: {
					if(!(_displayName in _riflenames)) then
					{
						_riflenames pushBack _displayName;
						_rifles pushBack[DB_Rifles, _classname,_displayName, _modindex, _picture, _magindexs, count _rifles, _wpnscopes, _wpnrail, _wpnsuppressors, _wpnbipods];
					};
				};
				case IT_LAUNCHER: {
					if(!(_displayName in _launchernames)) then
					{
						_launchernames pushBack _displayName;
						_launchers pushBack[DB_Launchers, _classname,_displayName, _modindex, _picture, _magindexs, count _launchers, _wpnscopes, _wpnrail, _wpnsuppressors, _wpnbipods];
					};
				};
				case IT_BINOCULAR: {
					//infotype 616 or it's a weapon according to vas?
					//magindexs just for laser designators
					if(_infotype == 616) then {
						_nightvision pushBack [DB_Nightvision,_classname, _displayName, _modindex, _picture, _magindexs, count _nightvision];
					} else {
						_binoculars pushBack [DB_Binoculars, _classname,_displayName, _modindex, _picture, _magindexs, count _binoculars];
					};
				};
				case IT_ITEM: {
					switch(_infotype) do {
						case IIT_SUPPRESSOR : {
							_suppressors pushBack [DB_Suppressors, _classname,_displayName, _modindex, _picture, [], count _suppressors]; 
							_allattachments pushBack [DB_Attachments, _classname, _displayName, _modindex, _picture, [], count _allattachments, _mass];
						};
						case IIT_SCOPE : {
							_scopes pushBack [DB_Scopes, _classname,_displayName, _modindex, _picture, [], count _scopes];
							_allattachments pushBack [DB_Attachments, _classname, _displayName, _modindex, _picture, [], count _allattachments, _mass];
						};
						case IIT_RAIL : { 
								_rails pushBack [DB_Rail, _classname,_displayName, _modindex, _picture, [], count _rails]; 
								_allattachments pushBack [DB_Attachments, _classname, _displayName, _modindex, _picture, [], count _allattachments, _mass];
						};
						case IIT_BIPOD : { 
								_bipods pushBack [DB_Bipods, _classname,_displayName, _modindex, _picture, [], count _bipods]; 
								_allattachments pushBack [DB_Attachments, _classname, _displayName, _modindex, _picture, [], count _allattachments, _mass];
						};
						case IIT_HEADGEAR : { _headgear pushBack [DB_Headgear, _classname,_displayName, _modindex, _picture, [], count _headgear]; };
						case IIT_UNIFORM : { 
						
								_uniforms pushBack [DB_Uniforms, _classname, _displayName, _modindex, _picture,_capacity, count _uniforms, _side]; 

						};
						case IIT_VEST : { _vests pushBack [DB_Vest, _classname,_displayName, _modindex, _picture, _capacity, count _vests]; };
						default { 
							_simulation = tolower getText (_cfg >> "simulation");
							switch(_simulation) do {
								case "itemmap": { _maps pushBack[DB_Maps, _classname,_displayName, _modindex, _picture, [], count _maps, _mass]};
								case "itemgps": { _gpss pushBack[DB_GPS, _classname,_displayName, _modindex, _picture, [], count _gpss, _mass]};
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
										_radios pushBack [DB_Radios, _classname,_displayName, _modindex, _picture, [], count _radios, _mass];
										_items pushBack [DB_Misc, _classname,_displayName, _modindex, _picture, [], count _items, _mass];
									};
								};
								case "itemcompass": { _compass pushBack [DB_Compass, _classname,_displayName, _modindex, _picture, [], count _compass, _mass]};
								case "itemwatch": { _watches pushBack [DB_Watchs, _classname,_displayName, _modindex, _picture, [], count _watches, _mass]};
								default {_items pushBack [DB_Misc, _classname,_displayName, _modindex, _picture, [], count _items, _mass]; };
							};
						};
					};
				};
				default {
					if(!(_displayName in _weaponnames)) then
					{
						_weaponnames pushBack _displayName;
						_weapons pushBack [DB_Weapons, _classname,_displayName, _modindex, _picture, [], count _items];
					};
				};
			};
		};
	};
} forEach (_allWeaponClasses);

_backpacks = [];
_allVehicleClasses = configProperties[(configFile >> "CfgVehicles"), 
"isClass(_x) && {getNumber(_x >> 'isbackpack')== 1 && { (getNumber(_x >> 'scope') == 2) && {(getText(_x >> 'picture') != '') && (getText(_x >> 'displayName') != '') && {[configName(_x), true] call ASORGS_fnc_IsAllowed} }}}", 
true];

{
	_cfg = _x;
	_classname = configName(_x);
	_displayName = getText(_cfg >> "displayName");
	_picture = getText(_cfg >> "picture");
	_desc = getText(_cfg >> "descriptionshort");
	_scope = getNumber(_cfg >> "scope");
	_type = getNumber(_cfg >> "type");
	_isbackpack = getNumber(_cfg >> "isbackpack");
	_capacity = getNumber (_cfg >> "maximumLoad");
	_modindex = 0;
	if(ASORGS_ShowModIcons) then {
		_mod = configSourceMod _cfg;
		_modindex = _modnames find _mod;
		if (_modindex == -1) then {
			_modicon = [_mod] call ASORGS_fnc_GetModIcon;
			_modnames pushback _mod;
			_modicons pushback _modicon;
			_modindex = (count _modnames) - 1;
		};
	};
	_backpacks pushBack [DB_Backpacks, _classname, _displayName, _modindex, _picture, _capacity, count _backpacks];
} forEach (_allVehicleClasses);

_allGoggleClasses = configProperties[(configFile >> "CfgGlasses"), 
"isClass(_x) && {(getNumber(_x >> 'scope') == 2) && {(getText(_x >> 'picture') != '') && (getText(_x >> 'displayName') != '') && {[configName(_x), true] call ASORGS_fnc_IsAllowed} }}", 
true];
_goggles = [];
{

	_cfg = _x;
	_classname = configName(_x);
	_displayName = getText(_cfg >> "displayName");
	_picture = getText(_cfg >> "picture");
	_desc = getText(_cfg >> "descriptionshort");
	_scope = getNumber(_cfg >> "scope");
	_modindex = 0;
	if(ASORGS_ShowModIcons) then {
		_mod = configSourceMod _cfg;
		_modindex = _modnames find _mod;
		if (_modindex == -1) then {
			_modicon = [_mod] call ASORGS_fnc_GetModIcon;
			_modnames pushback _mod;
			_modicons pushback _modicon;
			_modindex = (count _modnames) - 1;
		};
	};

		_goggles pushBack [DB_Goggles, _classname, _displayName, _modindex, _picture, [], count _goggles];

} forEach (_allGoggleClasses);

_allInsigniaClasses = configProperties[(configFile >> "CfgUnitInsignia"), 
"isClass(_x) && {(getText(_x >> 'texture') != '') && (getText(_x >> 'displayName') != '') && {[configName(_x), true] call ASORGS_fnc_IsAllowed} }", 
true];
_insignia = [];
{	
	_cfg = _x;
	_classname = configName(_x);
	_picture = getText (_cfg >> "texture");
	_displayName = getText (_cfg >> "displayName");
	_modindex = 0;
	if(ASORGS_ShowModIcons) then {
		_mod = configSourceMod _cfg;
		_modindex = _modnames find _mod;
		if (_modindex == -1) then {
			_modicon = [_mod] call ASORGS_fnc_GetModIcon;
			_modnames pushback _mod;
			_modicons pushback _modicon;
			_modindex = (count _modnames) - 1;
		};
	};
	_insignia pushBack [DB_Insignia, _classname, _displayName, _modindex, _picture, [], count _insignia];


} forEach (_allInsigniaClasses);

//find required magazines (ones that fit in something)
_requiredMagazines = ASORGS_throwable + ASORGS_explosives;
{
	{
		_weapon = _x;
		_weaponmags = []; //old indexs are no longer valid.. replace with names
		_oldindexs = _weapon select DBF_Magazines;
		for[{_i=0}, {_i<count _oldindexs}, {_i = _i+1}] do {
			_magindex = _oldindexs select _i;
		//	diag_log format["%1 from %2. %3", _magindex, count _magazines, _oldindexs];
			
			_classname = (_magazines select _magindex select DBF_Class);
			
			_requiredMagazines pushBack _classname;
			_weaponmags pushback _classname;
		};
		_weapon set [DBF_Magazines, _weaponmags];
	} foreach _x;
} foreach [_rifles, _launchers, _handguns, _binoculars]; //all things that can have magazines..hopefully
//remove useless magazines
for [{_i = (count _magazines)- 1}, {_i >= 0}, {_i = _i - 1}] do
{
	if(!((_magazines select _i select DBF_Class) in _requiredMagazines)) then { _magazines deleteAt _i; };
};
//fix their indexs
for [{_i = 0}, {_i < count _magazines}, {_i = _i + 1}] do {
	_magazines select _i set [DBF_Index, _i];
};
//build indexs
ASORGS_DB = [_rifles, _launchers, _handguns, _weapons, _items, _binoculars, _suppressors, _scopes, _rails, _bipods, _headgear, _uniforms, _vests,_magazines,_throwable,_explosives, _backpacks, _medical, _goggles, _nightvision, _allattachments, _insignia, _maps, _gpss, _radios, _compass, _watches];
ASORGS_DBIndexs = [];
{
	_newindex = [];
	{
		_newindex pushBack (toLower(_x select DBF_Class));
	} foreach _x;
	ASORGS_DBIndexs pushback _newindex;
} foreach ASORGS_DB;

ASORGS_DB pushBack _modicons;
ASORGS_DB pushBack _modnames;
//fix weapon mag indexs
{
	{
		_weapon = _x;
		_weaponmags = [];
		{
			_weaponmags pushBack (([_x, DB_Magazines] call ASORGS_fnc_GetDetails) select DBF_Index);
		} foreach (_weapon select DBF_Magazines);
		_weapon set [DBF_Magazines, _weaponmags];
	} foreach _x;
} foreach [_rifles, _launchers, _handguns, _binoculars];



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