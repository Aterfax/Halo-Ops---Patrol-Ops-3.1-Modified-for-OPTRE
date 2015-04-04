
#include "macro.sqf"

disableserialization;
_firstIDC = ASORGS_extraattach_label;
_playerHas = [];
_magCacheNames = [];
_magCacheDetails = [];
_db = -1;
_comboCount = 5;
_weaponComboIDC = _firstIDC - 10 + 1;
_list = [];
_weaponDetails = [];
_ignore = [];
_db = DB_Attachments;
_list = (ASORGS_DB select DB_Attachments);

//_blacklist = missionNamespace getVariable 'ASORGS_RuntimeBlacklist';
//sort current inventory items

_comboCount = 5;
{
	_itemClass = _x;
	_cacheIndex = _magCacheNames find _itemClass;
	if(_cacheIndex < 0) then {
		_details  = [_itemClass, _db ] call ASORGS_fnc_getDetails;	
		if ((count _details > 0)) then {
			if(!((_details select DBF_Class) in ASORGS_RuntimeBlacklist)) then 	{
				_cacheIndex = count _magCacheNames;
				_magCacheNames set [_cacheIndex, _itemClass];
				_magCacheDetails set [_cacheIndex, _details];
				_playerHas = _playerHas + [_cacheIndex];
			}; 
		};
	} else {
		_playerHas = _playerHas + [_cacheIndex];
	};
} foreach (call ASORGS_fnc_GetInventoryItems);


//skip the label
_currentIDC = _firstIDC + 1;

_alreadySelected = _ignore;

for[{_i = 0}, {_i < _comboCount}, {_i = _i + 1}] do {
	_index = -1;
	_cacheindex = -1;
	if((count _playerHas) > 0) then {
		_cacheindex = (_playerHas select 0);
		_index = _magCacheDetails select _cacheindex select DBF_Index; };
	_comboControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC );
	lbClear _comboControl;
	_comboControl lbAdd "None"; //Displayname on list
	_comboControl lbSetData [(lbSize _comboControl)-1,""]; //Data for index is classname
	_comboControl lbSetValue [(lbSize _comboControl)-1,-1]; 
	_comboControl lbSetCurSel 0;
	//diag_log format["%1", _list];
	{
		_details = _x;
		if((count _details > 0) && !((_details select DBF_Class) in ASORGS_RuntimeBlacklist) && !(_details select DBF_Index in _alreadySelected)) then
		{
			_comboControl lbAdd format["%1", (_details select DBF_Name)]; //Displayname on list
			_comboControl lbSetData [(lbSize _comboControl)-1,(_details select DBF_Class)]; //Data for index is classname
			_comboControl lbSetValue [(lbSize _comboControl)-1,(_details select DBF_Index)]; //Value for index is type
			_comboControl lbSetPicture [(lbSize _comboControl)-1,(_details select DBF_Picture)];
			if((_details select DBF_Index) == _index) then {
				_comboControl lbSetCurSel ((lbSize _comboControl)-1);
				_alreadySelected = _alreadySelected + [_index];
			};
		};
	} forEach _list;
	_currentIDC = _currentIDC + 10;
	_playerHas = _playerHas - [_cacheindex];
};

