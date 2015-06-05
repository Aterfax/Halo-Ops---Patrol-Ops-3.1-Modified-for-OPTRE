
#include "macro.sqf"
private ["_playerRifleAmmo", "_playerPistolAmmo", "_playerLauncherAmmo", "_playerExtraAmmo", "_comboCount", "_primaryWeapon", "_launcher", "_handgun", "_rifleDetails", "_launcherDetails", "_pistolDetails", "_rifleMagsRaw", "_rifleMags", "_pistolMagsRaw", "_pistolMags", "_launcherMagsRaw", "_launcherMags", "_alreadySelected", "_currentIDC", "_i", "_x"];
disableSerialization;
_playerRifleAmmo = [];
_playerPistolAmmo = [];
_playerLauncherAmmo = [];
_playerExtraAmmo = [];
_comboCount = 5;

_primaryWeapon = (call ASORGS_fnc_GetPrimaryWeapon) call ASORGS_fnc_getWeaponBase;// ((call ASORGS_fnc_GetPrimaryWeapon) call BIS_fnc_WeaponComponents) select 0;
_launcher = (call ASORGS_fnc_GetLauncher) call ASORGS_fnc_getWeaponBase;//((call ASORGS_fnc_GetLauncher) call BIS_fnc_WeaponComponents) select 0;
_handgun = (call ASORGS_fnc_GetHandgun) call ASORGS_fnc_getWeaponBase;//((call ASORGS_fnc_GetHandgun) call BIS_fnc_WeaponComponents) select 0;
if(isNil '_launcher') then {_launcher = ""};
if(isNil '_handgun') then {_handgun = ""};
if(isNil '_primaryWeapon') then {_primaryWeapon = ""};
_rifleDetails = [_primaryWeapon, DB_Rifles] call ASORGS_fnc_GetDetails;
_launcherDetails = [_launcher, DB_Launchers] call ASORGS_fnc_GetDetails;
_pistolDetails = [_handgun, DB_Handguns] call ASORGS_fnc_GetDetails;
/*
_rifleMagsRaw = _primaryWeapon call ASORGS_fnc_GetWeaponMuzzleMagazines;
_pistolMagsRaw = _handgun call ASORGS_fnc_GetWeaponMuzzleMagazines;
_launcherMagsRaw = _launcher call ASORGS_fnc_GetWeaponMuzzleMagazines;
*/

_rifleMagIndexs = [];
_rifleMags = [];
_pistolMagIndexs = [];
_pistolMags = [];
_launcherMagIndexs = [];
_launcherMags = [];
_alreadySelected = [];
if(0 < count _rifleDetails) then {
	_rifleMagIndexs = _rifleDetails select DBF_Magazines;
	{
		_rifleMags pushBack (ASORGS_DB select DB_Magazines select _x select DBF_ClassName);
	} foreach _rifleMagIndexs;
};
if(0 < count _pistolDetails) then {
	_pistolMagIndexs = _pistolDetails select DBF_Magazines;
	{
		_pistolMags pushBack (ASORGS_DB select DB_Magazines select _x select DBF_ClassName);
	} foreach _pistolMagIndexs;
};
if( 0 < count _launcherDetails) then {
	_launcherMagIndexs = _launcherDetails select DBF_Magazines;
	{
		_launcherMags pushBack (ASORGS_DB select DB_Magazines select _x select DBF_ClassName);
	} foreach _launcherMagIndexs;
};
_allWeaponMags = _rifleMags + _pistolMags + _launcherMags;

{
	private["_magDetails"];
	_magClass = _x;
	_details =  [];
	_placed = false;

	if(_magClass in _rifleMags) then {
		_playerRifleAmmo pushBack _magClass;
		_placed = true;
	};
	if(!_placed && {(_magClass in _launcherMags)}) then {
		_playerLauncherAmmo pushBack _magClass;
		_placed = true;
	};
	if(!_placed && {(_magClass in _pistolMags)}) then {
		_playerPistolAmmo pushBack _magClass;
		_placed = true;
	};
	if(!_placed) then {
		if(!(_magClass in ASORGS_throwable)) then {
			if(!(_magClass in ASORGS_explosives)) then {
				_playerExtraAmmo pushBack _magClass;
			};
		};
	};
} foreach (call ASORGS_fnc_GetAllMagazines);

#define COMBO_ADD(ITEMNAME, ITEMCLASS, ITEMID, ITEMPIC) \
				_comboControl lbAdd ITEMNAME;\
				_index = (lbSize _comboControl)-1; \
				_comboControl lbSetData [_index,ITEMCLASS]; \
				_comboControl lbSetValue [_index,ITEMID]; \
				_comboControl lbSetPicture [_index,ITEMPIC]; \
				_comboControl lbSetTooltip [_index,ITEMCLASS];\
				if(_currentMag == ITEMCLASS) then { _comboControl lbSetCurSel _index;	};
				
_currentIDC = ASORGS_primaryAmmo_label + 1;

for[{_i = 0}, {_i < _comboCount}, {_i = _i + 1}] do {
	_currentMag = "";
	if((count _playerRifleAmmo) > 0) then {
		_currentMag = (_playerRifleAmmo select 0);
	};
	_comboControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC );
	_countControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 2);
	_minus = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 1);
	lbClear _comboControl;
	_countControl ctrlSetText format["%1", 0];
	COMBO_ADD("None", "", -1, "")
	_itemCount = 0;
	if(count _rifleDetails > 0) then { //no current rifle
		{
			_details = ASORGS_DB select DB_Magazines select _x;	
		
			_class = _details select DBF_ClassName;
			if((count _details > 0) && ([_class, false] call ASORGS_fnc_IsAllowed) && !(_class in _alreadySelected)) then
			{
				COMBO_ADD((_details select DBF_Name), _class, (_details select DBF_Index), (_details select DBF_Picture))
				if(_class == _currentMag) then {
					_itemCount = { _x == _currentMag } count _playerRifleAmmo;
					_playerRifleAmmo = _playerRifleAmmo - [_currentMag];
					_countControl ctrlSetText format["%1", _itemCount];
					_alreadySelected pushBack _currentMag;
				};
			};
		} forEach (_rifleDetails select DBF_Magazines);
	};
	if(_itemCount <= 0) then {
		_minus ctrlEnable false;
	} else {
		_minus ctrlEnable true;
	};
	//next line is always 10 down
	_currentIDC = _currentIDC + 10;
	
};


_currentIDC = ASORGS_launcherAmmo_label + 1;
for[{_i = 0}, {_i < _comboCount}, {_i = _i + 1}] do {
	_currentMag = "";
	if((count _playerLauncherAmmo) > 0) then {
		_currentMag = (_playerLauncherAmmo select 0);
	};
	_comboControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC );
	_countControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 2);
	_minus = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 1);
	lbClear _comboControl;
	_countControl ctrlSetText format["%1", 0];
	COMBO_ADD("None", "", -1, "")
	_itemCount = 0;
	if(count _LauncherDetails > 0) then {
		{
			_details = ASORGS_DB select DB_Magazines select _x;	
			_class = _details select DBF_ClassName;
			if((count _details > 0) && ([(_details select DBF_Class), false] call ASORGS_fnc_IsAllowed) && !(_class in _alreadySelected)) then
			{
				COMBO_ADD((_details select DBF_Name), _class, (_details select DBF_Index), (_details select DBF_Picture))
				if(_class == _currentMag) then {
					_itemCount = { _x == _currentMag } count _playerLauncherAmmo;
					_playerLauncherAmmo = _playerLauncherAmmo - [_currentMag];
					_countControl ctrlSetText format["%1", _itemCount];
					_alreadySelected pushBack _currentMag;
				};
			};
		} forEach (_LauncherDetails select DBF_Magazines);
	};	
	if(_itemCount <= 0) then {
		_minus ctrlEnable false;
	} else {
		_minus ctrlEnable true;
	};
	//next line is always 10 down
	_currentIDC = _currentIDC + 10;
	
};

_currentIDC = ASORGS_handgunAmmo_label + 1;
for[{_i = 0}, {_i < _comboCount}, {_i = _i + 1}] do {
	_currentMag = "";
	if((count _playerPistolAmmo) > 0) then {
		_currentMag = (_playerPistolAmmo select 0);
	};
	_comboControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC );
	_countControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 2);
	_minus = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 1);
	lbClear _comboControl;
	_countControl ctrlSetText format["%1", 0];
	COMBO_ADD("None", "", -1, "")
	_itemCount = 0;
	if(count _PistolDetails > 0) then {
		{
			_details = ASORGS_DB select DB_Magazines select _x;	
			_class = _details select DBF_ClassName;
			if((count _details > 0) && ([(_details select DBF_Class), false] call ASORGS_fnc_IsAllowed) && !(_class in _alreadySelected)) then
			{
				COMBO_ADD((_details select DBF_Name), _class, (_details select DBF_Index), (_details select DBF_Picture))
				if(_class == _currentMag) then {
					_itemCount = { _x == _currentMag } count _playerPistolAmmo;
					_playerPistolAmmo = _playerPistolAmmo - [_currentMag];
					_countControl ctrlSetText format["%1", _itemCount];
					_alreadySelected pushBack _currentMag;
				};
			};
		} forEach (_PistolDetails select DBF_Magazines);
	};	
	if(_itemCount <= 0) then {
		_minus ctrlEnable false;
	} else {
		_minus ctrlEnable true;
	};
	//next line is always 10 down
	_currentIDC = _currentIDC + 10;
	
};

_currentIDC = ASORGS_extraammo_label + 1;
for[{_i = 0}, {_i < _comboCount}, {_i = _i + 1}] do {
	_currentMag = "";
	if((count _playerExtraAmmo) > 0) then {
		_currentMag = (_playerExtraAmmo select 0);
		//format ["Adding Mags. Details = %1. PlayerAmmo = %2.", _playerExtraAmmo] spawn ASORGS_fnc_Log;
	};
	_comboControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC );
	_countControl = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 2);
	_minus = ASORGS_getControl(ASORGS_Main_Display, _currentIDC + 1);
	lbClear _comboControl;
	_countControl ctrlSetText format["%1", 0];
	COMBO_ADD("None", "", -1, "")
	_itemCount = 0;
	{
		_details =  _x;	
		_class = _details select DBF_ClassName;
		if((count _details > 0) && ([(_details select DBF_Class), false] call ASORGS_fnc_IsAllowed) && !(_class in _alreadySelected)) then
		{
			COMBO_ADD((_details select DBF_Name), _class, (_details select DBF_Index), (_details select DBF_Picture))
			if(_class == _currentMag) then {
				_itemCount = { _x == _currentMag } count _playerExtraAmmo;
				_playerExtraAmmo = _playerExtraAmmo - [_currentMag];
				_countControl ctrlSetText format["%1", _itemCount];
				_alreadySelected pushBack _currentMag;
			};
		};
	} forEach (ASORGS_DB select DB_Magazines);
	if(_itemCount <= 0) then {
		_minus ctrlEnable false;
	} else {
		_minus ctrlEnable true;
	};
	//next line is always 10 down
	_currentIDC = _currentIDC + 10;
	
};
