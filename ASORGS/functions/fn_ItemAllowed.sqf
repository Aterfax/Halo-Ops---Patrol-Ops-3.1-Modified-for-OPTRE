private["_class", "_RTBlacklist", "_RTWhitelist"];
_class = _this select 0;
_useFullLists = [_this, 1, false, [true]] call BIS_fnc_Param;
//if runtime black/whitelists haven't been defined, then must be preinit so use normal black/whitelist.
_RTBlacklist = if(isNil 'ASORGS_RuntimeBlacklist') then { [] } else { ASORGS_RuntimeBlacklist };
_RTWhitelist = if(isNil 'ASORGS_RuntimeWhitelist') then { [] } else { ASORGS_RuntimeWhitelist };
_result = true;
if(_class == "") exitWith {false;};
//check blacklists
if(_useFullLists && {_class in ASORGS_Blacklist}) exitWith { false;}
if(_class in _RTBlacklist) exitWith { false; };

//check whitelists if applicable
if(_useFullLists && {(count ASORGS_Whitelist > 0) && (!(_class in ASORGS_Whitelist))}) exitWith {false};
if((count _RTWhitelist > 0) && (!(_class in _RTWhitelist))) exitWith {false};

_result
