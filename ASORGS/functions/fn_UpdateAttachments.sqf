#include "macro.sqf"
_type = _this select 0;
//hint format["%1", _type];
private ["_weaponDetails", "_scopeControl", "_railControl", "_suppControl", "_bipodControl", "_weapon", "_attachments", "_index"];

if((_type == "primary")) then {
	//load scopes for current rifle
	
	_guncontrol = ASORGS_getControl(ASORGS_Main_Display,ASORGS_primary_combo);
	_index = _guncontrol lbValue lbCurSel _guncontrol;
	_weaponDetails = [];
	if(_index > -1) then {
		_weaponDetails = ASORGS_DB select DB_Rifles select _index; 
	};
	_scopeControl = ASORGS_getControl(ASORGS_Main_Display,ASORGS_primaryScope_combo);
	_railControl = ASORGS_getControl(ASORGS_Main_Display,ASORGS_primaryRail_combo);
	_suppControl = ASORGS_getControl(ASORGS_Main_Display,ASORGS_primarySuppressor_combo);
	_bipodControl = ASORGS_getControl(ASORGS_Main_Display,ASORGS_primaryBipod_combo);
	_attachments = call ASORGS_fnc_GetPrimaryWeaponItems;
};
if((_type == "secondary")) then {
	//load scopes for current rifle
	_guncontrol = ASORGS_getControl(ASORGS_Main_Display,ASORGS_launcher_combo);
	_index = _guncontrol lbValue lbCurSel _guncontrol;
	_weaponDetails = [];
	if(_index > -1) then {
		_weaponDetails = ASORGS_DB select DB_Launchers select _index; 
	};
	_scopeControl = ASORGS_getControl(ASORGS_Main_Display,ASORGS_launcherScope_combo);
	_attachments = call ASORGS_fnc_GetLauncherItems;

};
if((_type == "handgun")) then {
	//load scopes for current rifle
	_guncontrol = ASORGS_getControl(ASORGS_Main_Display,ASORGS_handgun_combo);
	_index = _guncontrol lbValue lbCurSel _guncontrol;
	_weaponDetails = [];
	if(_index > -1) then {
		_weaponDetails = ASORGS_DB select DB_Handguns select _index; 
	};
	_scopeControl = ASORGS_getControl(ASORGS_Main_Display,ASORGS_handgunScope_combo);
	_suppControl = ASORGS_getControl(ASORGS_Main_Display,ASORGS_handgunSuppressor_combo);
	_bipodControl = ASORGS_getControl(ASORGS_Main_Display,ASORGS_handgunBipod_combo);
	_attachments = call ASORGS_fnc_GetHandgunItems;
};
/*
_allattachments = weaponsItems ASORGS_Player;
_attachments = [];
if(_index > -1) then {
	{
		if(((_x select 0) == (_weaponDetails select DBF_Class)) || ((_weaponDetails select DBF_Class) == (((_x select 0) call BIS_fnc_weaponComponents) select 0))) then {
			_attachments = _x;
		};
	} foreach (weaponsItems ASORGS_Player);
};	
*/
_weaponDetails spawn ASORGS_fnc_Log;
if(!isNil "_scopeControl") then {	
	
	lbClear _scopeControl;
	_scopeControl lbAdd "None"; //Displayname on list
	_scopeControl lbSetData [(lbSize _scopeControl)-1,""]; //Data for index is classname
	_scopeControl lbSetValue [(lbSize _scopeControl)-1,-1]; 
	_scopeControl lbSetCurSel 0;
	if((count _weaponDetails) > 0) then {
		_info = _weaponDetails select DBF_Scopes;
		{
				_details = [_x, DB_Scopes] call ASORGS_fnc_getDetails;
			if((count _details > 0) && {([(_details select DBF_Class), false] call ASORGS_fnc_IsAllowed)}) then
				{
					_scopeControl lbAdd format["%1", (_details select DBF_Name)]; //Displayname on list
					_scopeControl lbSetData [(lbSize _scopeControl)-1,(_details select DBF_Class)]; //Data for index is classname
					_scopeControl lbSetValue [(lbSize _scopeControl)-1,(_details select DBF_Index)]; //Value for index is type
					_scopeControl lbSetPicture [(lbSize _scopeControl)-1,(_details select DBF_Picture)];
					if((count _attachments) > 0) then {
						if ( (_details select DBF_Class) in _attachments ) then {
							_scopeControl lbSetCurSel (lbSize _scopeControl)-1;
						};
					};
				};
		} foreach _info;
	};	
	//if((lbCurSel _scopeControl) <= 0) then {_scopeControl lbSetCurSel 0};
};
if(!isNil "_railControl") then {
	lbClear _railControl;

	//load rail accessories for current rifle
	_railControl lbAdd "None"; //Displayname on list
	_railControl lbSetData [(lbSize _railControl)-1,""]; //Data for index is classname
	_railControl lbSetValue [(lbSize _railControl)-1,-1]; //Value for index is type
	_railControl lbSetCurSel 0;
	if((count _weaponDetails) > 0) then {
		_info = _weaponDetails select DBF_Rail;
		//format["Rails: %1. Attachments: %2", _info, _attachments] call ASORGS_fnc_Log;
		{
			_details = [_x,DB_Rail] call ASORGS_fnc_getDetails;
		//	format["Details: %1", _details] call ASORGS_fnc_Log;
			if((count _details > 0) && {([(_details select DBF_Class), false] call ASORGS_fnc_IsAllowed)}) then
			{
				_railControl lbAdd format["%1", (_details select DBF_Name)]; //Displayname on list
				_railControl lbSetData [(lbSize _railControl)-1,(_details select DBF_Class)]; //Data for index is classname
				_railControl lbSetValue [(lbSize _railControl)-1,(_details select DBF_Index)]; //Value for index is type
				_railControl lbSetPicture [(lbSize _railControl)-1,(_details select DBF_Picture)];
				if((count _attachments) > 0) then {
					if ((_details select DBF_Class) in _attachments) then {
						_railControl lbSetCurSel (lbSize _railControl)-1;
					};
				};
			} else {
				format["%1 not added. All rails: %2", _details, _info] call ASORGS_fnc_Log;
			};
		} foreach _info;
	};
	if((lbCurSel _railControl) <= 0) then {_railControl lbSetCurSel 0};
};
if(!isNil "_suppControl") then {
	lbClear _suppControl;
	//load muzzle accessories for current rifle
	_suppControl lbAdd "None"; //Displayname on list
	_suppControl lbSetData [(lbSize _suppControl)-1,""]; //Data for index is classname
	_suppControl lbSetValue [(lbSize _suppControl)-1,-1];
	_suppControl lbSetCurSel 0;
	if((count _weaponDetails) > 0) then {
		_info = _weaponDetails select DBF_Suppressors;
		{
			_details = [_x, DB_Suppressors] call ASORGS_fnc_getDetails;
			if((count _details > 0) && {([(_details select DBF_Class), false] call ASORGS_fnc_IsAllowed)}) then
			{
				_suppControl lbAdd format["%1", (_details select DBF_Name)]; //Displayname on list
				_suppControl lbSetData [(lbSize _suppControl)-1,(_details select DBF_Class)]; //Data for index is classname
				_suppControl lbSetValue [(lbSize _suppControl)-1,(_details select DBF_Index)]; //Value for index is type
				_suppControl lbSetPicture [(lbSize _suppControl)-1,(_details select DBF_Picture)];
				if((count _attachments) > 0) then {
					if ((_details select DBF_Class) in _attachments) then {
						_suppControl lbSetCurSel (lbSize _suppControl)-1;
					};
				};
			};
		} foreach _info;
	};
};
if(!isNil "_bipodControl") then {
	lbClear _bipodControl;
	//load muzzle accessories for current rifle
	_bipodControl lbAdd "None"; //Displayname on list
	_bipodControl lbSetData [(lbSize _bipodControl)-1,""]; //Data for index is classname
	_bipodControl lbSetValue [(lbSize _bipodControl)-1,-1];
	_bipodControl lbSetCurSel 0;
	if((count _weaponDetails) > 0) then {
		_info = _weaponDetails select DBF_Bipods;
		{
			_details = [_x, DB_Bipods] call ASORGS_fnc_getDetails;
			if((count _details > 0) && {([(_details select DBF_Class), false] call ASORGS_fnc_IsAllowed)}) then
			{
				_bipodControl lbAdd format["%1", (_details select DBF_Name)]; //Displayname on list
				_bipodControl lbSetData [(lbSize _bipodControl)-1,(_details select DBF_Class)]; //Data for index is classname
				_bipodControl lbSetValue [(lbSize _bipodControl)-1,(_details select DBF_Index)]; //Value for index is type
				_bipodControl lbSetPicture [(lbSize _bipodControl)-1,(_details select DBF_Picture)];
				if((count _attachments) > 0) then {
					if ((_details select DBF_Class) in _attachments) then {
						_bipodControl lbSetCurSel (lbSize _bipodControl)-1;
					};
				};
			};
		} foreach _info;
	};
};
