private["_class", "_RTBlacklist", "_RTWhitelist", "_result", "_useFullLists"];
_class = [_this, 0, "", [""]] call BIS_fnc_Param;
if(_class == "") exitWith {false;};
_useFullLists = [_this, 1, false, [true]] call BIS_fnc_Param;
//if runtime black/whitelists haven't been defined, then must be preinit so use normal black/whitelist.
_RTBlacklist = if(isNil 'ASORGS_RuntimeBlacklist') then { [] } else { ASORGS_RuntimeBlacklist };
_RTWhitelist = if(isNil 'ASORGS_RuntimeWhitelist') then { [] } else { ASORGS_RuntimeWhitelist };
_result = true;
if([_class] call ASORGS_fnc_IsRadio) then {_class = [_class, true] call ASORGS_fnc_GetRadioClass; };
//check full lists
if(_useFullLists) then {
	if(_class in ASORGS_Blacklist) then {
		_result = false;
	};
	if((count ASORGS_Whitelist > 0) && (!(_class in ASORGS_Whitelist))) then {
		_result = false;
	};
};

//check runtime lists
if(_class in _RTBlacklist) exitWith { false; };
if((count _RTWhitelist > 0) && (!(_class in _RTWhitelist))) exitWith {false};

_result
