private ["_newAttach", "_type", "_attachments", "_itemtype"];
_newAttach = _this select 0;
_type = _this select 1;
_itemtype = _this select 2;
switch(_type) do {
	case "primary": {
		_attachments = call ASORGS_fnc_GetPrimaryWeaponItems;
		for[{_i = (count _attachments) - 1}, {_i >= 0}, {_i = _i - 1}] do {
			if(getNumber(configFile >> "cfgWeapons" >> (_attachments select _i) >> "ItemInfo" >> "type") == _itemtype) then {
				[(_attachments select _i)] call ASORGS_fnc_RemovePrimaryWeaponItem;
			};
		};
		if(_newAttach != "") then {
			[_newAttach] call ASORGS_fnc_AddPrimaryWeaponItem;
		};
	};
	case "secondary": {
		_attachments = call ASORGS_fnc_GetLauncherItems;
		{
			if(getNumber(configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "type") == _itemtype) then {
				[_x] call ASORGS_fnc_RemoveLauncherItem;
			}
		} forEach _attachments;
		if(_newAttach != "") then {
			[_newAttach] call ASORGS_fnc_AddLauncherItem;
		};
	};
	case "handgun": {
		_attachments = call ASORGS_fnc_GetHandgunItems;
		{
			if(getNumber(configFile >> "cfgWeapons" >> _x >> "ItemInfo" >> "type") == _itemtype) then {
				[_x] call ASORGS_fnc_RemoveHandgunItem;
			}
		} forEach _attachments;
		if(_newAttach != "") then {
			[_newAttach] call ASORGS_fnc_AddHandgunItem;
		};
	};
};