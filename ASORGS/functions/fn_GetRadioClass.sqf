private ["_class", "_forceBaseRadio", "_acre2Enabled", "_tfarEnabled"];
_class = _this select 0;
_forceBaseRadio = [_this,1,true,[true]] call BIS_fnc_Param;

_acre2Enabled = !isNil 'ACRE_IS_SPECTATOR';
_tfarEnabled = !isNil 'TF_radio_request_mutex';

if([_class, "tf_"] call ASORGS_fnc_StartsWith) then {
	if(_tfarEnabled) then {
		if(_forceBaseRadio) then {
			_parent = configName (inheritsFrom (configFile >> "cfgweapons" >> _class));
			if(_parent != "ItemRadio") then { _class = _parent };
		};
	} else {
		_class = "ItemRadio"; // just use default radio instead. will be 343 if Acre is enabled.
	};
};
if([_class, "acre_"] call ASORGS_fnc_StartsWith) then {
	if(_acre2Enabled) then {
		if(_forceBaseRadio) then {
			if(isNumber (configFile >> "cfgWeapons" >> _class >> "acre_isUnique")) then {
				if( getNumber (configFile >> "cfgWeapons" >> _class >> "acre_isUnique") == 1 ) then {
					_class = configName (inheritsFrom (configFile >> "cfgweapons" >> _class));
				};
			};
		};
	} else {
		_class = "ItemRadio"; // just use default radio instead. will turn into default radio if TFAR is enabled
	};
};
_class