_oldWeapon = _this select 0;
_newWeapon = _this select 1;
if(_oldWeapon == _newWeapon) exitWith {};
_type = _this select 2;
_magCount = 0;
if(_oldWeapon != "") then {
	_details = [_oldWeapon, "cfgWeapons"] call ASORGS_fnc_fetchCfgDetails;
	_magTypes = _details select 7;
	_playerMags = MagazinesAmmoFull ASORGS_Player;
	{
		_mag = _x;
		_magCount = _magCount + {(_x select 0 == _mag) } count (_playerMags);
		ASORGS_Player removeMagazines _mag;
	} foreach _magTypes;
	ASORGS_Player removeWeapon _oldWeapon;
} else {
	_magCount = 10;
};
//since i'm bad at count mags
_magCount = 10;
if(_newWeapon != "") then {
	_base = configName(inheritsFrom (configFile >> "CfgWeapons" >> _newWeapon));
	_basedetails = [_base, "CfgWeapons"] call ASORGS_fnc_fetchCfgDetails;
	_details = [_newWeapon, "CfgWeapons"] call ASORGS_fnc_fetchCfgDetails;
	_mags = ((_basedetails select 7) - (_details select 7)) + (_details select 7); //hopefully this will get all ammo?
	//hint format["%1",_details];
	_newMagType = _details select 7 select 0; //first in list
	ASORGS_Player addMagazines [_newMagType, _magCount];
	ASORGS_Player addWeapon _newWeapon;
};

