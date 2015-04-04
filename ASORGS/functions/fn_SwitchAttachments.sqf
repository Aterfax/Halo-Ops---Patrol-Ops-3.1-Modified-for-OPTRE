_oldAttach = [_this, 0, "", [""]] call BIS_fnc_param;
_newAttach = _this select 1;
_type = _this select 2;

if(_type=="primary") then {
	if(_oldAttach != "") then {
		[_oldAttach] call ASORGS_fnc_RemovePrimaryWeaponItem;
	};
	if(_newAttach != "") then {
		[_newAttach] call ASORGS_fnc_AddPrimaryWeaponItem;
	};
};
if(_type=="secondary") then {

	if(_oldAttach != "") then {
		[_oldAttach] call ASORGS_fnc_RemoveLauncherItem;
		//ASORGS_Player removeSecondaryWeaponItem _oldAttach; 
	};
	if(_newAttach != "") then {
		[_newAttach] call ASORGS_fnc_AddLauncherItem;
	};
};
if(_type=="handgun") then {
	if(_oldAttach != "") then {
		[_oldAttach] call ASORGS_fnc_RemoveHandgunItem;
	};
	if(_newAttach != "") then {
		[_newAttach] call ASORGS_fnc_AddHandgunItem;
	};
};