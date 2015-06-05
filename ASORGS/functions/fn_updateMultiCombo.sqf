
#include "macro.sqf"

disableserialization;
_firstIDC = _this select 0;
_type = _this select 1;
//weapon index
_weapon = [_this, 2, -1, [2]] call BIS_fnc_Param;
_weapondb = [_this, 3, -1, [2]] call BIS_fnc_Param;
_playerHas = [];
_magCacheNames = [];
_magCacheDetails = [];
_db = -1;
_comboCount = 5;
_weaponComboIDC = _firstIDC - 10 + 1;
_list = [];
_weaponDetails = [];
_ignore = [];
switch(_firstIDC) do {
	case ASORGS_grenade_label: {
		_db=DB_Throwable;
		_list = (ASORGS_DB select _db);
	};
	case ASORGS_explosives_label: {
		_db=DB_Explosives;
		_list = (ASORGS_DB select _db);
	};
	case ASORGS_medical_label: {
		_db=DB_Medical;
		_list = (ASORGS_DB select _db);
	};
	case ASORGS_misc_label: {
		_db=DB_Items;
		_list = (ASORGS_DB select _db);
	};
	default {
		hint "unsupported label for updateMultiCombo";
	};
};

//sort current inventory items
switch(_type) do {
	case "mags": {
		{
			private["_magDetails"];
			_magClass = _x;
			_details =  [];
			_cacheIndex = _magCacheNames find _magClass;
			
			if(_cacheIndex < 0) then {
				_details  = [_magClass, _db] call ASORGS_fnc_getDetails;
				if((count _details) > 0) then {
					_cacheIndex = count _magCacheNames;
					_magCacheNames pushBack _magClass;
					_magCacheDetails pushBack _details;
				};
			} else {
				_details = _magCacheDetails select _cacheIndex;
			};
			if(_cacheIndex > -1) then {
				switch(_firstIDC) do {
					case ASORGS_grenade_label: {
						if((_details select DBF_DB) == DB_Throwable) then {
							_playerHas = _playerHas + [_cacheIndex]; };
					};
					case ASORGS_explosives_label: {
						if((_details select DBF_DB) == DB_Explosives) then {
							_playerHas = _playerHas + [_cacheIndex]; };
					};
				};
			};
		} foreach (call ASORGS_fnc_GetAllMagazines);
	};
	case "medical": {
		_comboCount = 20;
		{
			_itemClass = _x;
			_cacheIndex = _magCacheNames find _itemClass;
			if(_cacheIndex < 0) then {
				_details  = [_itemClass, _db ] call ASORGS_fnc_getDetails;	
				if((count _details) > 0) then {
					_cacheIndex = count _magCacheNames;
					_magCacheNames set [_cacheIndex, _itemClass];
					_magCacheDetails set [_cacheIndex, _details];
					_playerHas = _playerHas + [_cacheIndex];
				}; //else it's not medical
			} else {
				_playerHas = _playerHas + [_cacheIndex];
			};
		} foreach (call ASORGS_fnc_GetInventoryItems);
	};
	case "misc": {
		_comboCount = 10;
		{	
			_itemClass = _x;
			if([_itemClass] call ASORGS_fnc_IsRadio) then {
				_itemClass = [_itemClass, true] call ASORGS_fnc_GetRadioClass;
			};
			_cacheIndex = _magCacheNames find _itemClass;
			if(_cacheIndex < 0) then {
				_details  = [_itemClass, _db ] call ASORGS_fnc_getDetails;	
				if((count _details) > 0) then {
					_cacheIndex = count _magCacheNames;
					_magCacheNames set [_cacheIndex, _itemClass];
					_magCacheDetails set [_cacheIndex, _details];
					_playerHas = _playerHas + [_cacheIndex];
				}; //else it's not medical
			} else {
				_playerHas = _playerHas + [_cacheIndex];
			};
		} foreach (call ASORGS_fnc_GetInventoryItems);
	};
};


//skip the label
_currentIDC = _firstIDC + 1;

_alreadySelected = _ignore;
_needsUpdating = false;
_updateCheck = +_magCacheNames;
for[{_i = 0}, {_i < _comboCount}, {_i = _i + 1}] do {
	_comboControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + (_i * 10));
	_data = (_comboControl lbData (lbCurSel _comboControl));
	if(_data != "") then {
		_needsUpdating = _needsUpdating || (!(_data in _updateCheck));
		_updateCheck = _updateCheck - [_data];
	};
};
_needsUpdating = _needsUpdating || ((count _updateCheck) > 0);
format["DB = %1. _needsUpdating = %2. playerHas = %3. ignore = %4.", _db, _needsUpdating, _playerHas, _ignore] call ASORGS_fnc_Log;
for[{_i = 0}, {_i < _comboCount}, {_i = _i + 1}] do {
	//next line is always 10 down
	
	_index = -1;
	_cacheindex = -1;
	if(((count _playerHas) > 0)) then {

		_cacheindex = (_playerHas select 0);
		_index = _magCacheDetails select _cacheindex select DBF_Index; 
		
		};
	_comboControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC );
	_countControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 2);
	_minus = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 1);
	lbClear _comboControl;
	_countControl ctrlSetText format["%1", 0];
	_comboControl lbAdd "None"; //Displayname on list
	_comboControl lbSetData [(lbSize _comboControl)-1,""]; //Data for index is classname
	_comboControl lbSetValue [(lbSize _comboControl)-1,-1]; 
	_comboControl lbSetCurSel 0;
	_itemCount =0;
	//diag_log format["%1", _list];
	{
		_details = _x;
		
		if((count _details > 0) && ([(_details select DBF_Class), false] call ASORGS_fnc_IsAllowed) && !(_details select DBF_Index in _alreadySelected)) then
		{
			_comboControl lbAdd format["%1", (_details select DBF_Name)]; //Displayname on list
			_comboControl lbSetData [(lbSize _comboControl)-1,(_details select DBF_Class)]; //Data for index is classname
			_comboControl lbSetValue [(lbSize _comboControl)-1,(_details select DBF_Index)]; //Value for index is type
			_comboControl lbSetPicture [(lbSize _comboControl)-1,(_details select DBF_Picture)];
			if((_details select DBF_Index) == _index) then {
				_comboControl lbSetCurSel ((lbSize _comboControl)-1);
				_itemCount = { _x == _cacheindex } count _playerHas;
				_countControl ctrlSetText format["%1", _itemCount];
				_alreadySelected = _alreadySelected + [_index];
			};
		};
	} forEach _list;
	if(_itemCount <= 0) then {
		_minus ctrlEnable false;
	} else {
		_minus ctrlEnable true;
	};
	_currentIDC = _currentIDC + 10;
	_playerHas = _playerHas - [_cacheindex];
};

