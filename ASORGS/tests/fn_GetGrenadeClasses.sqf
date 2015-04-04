hint "getting grenade classes";
_throwWeapons = ["Throw"];
_allGrenades = [];
{
	_weapon = (configFile >> "CfgWeapons" >> _x);
	_muzzles = getArray (_weapon >> "muzzles");
	for[{_i = 0}, {_i < count _muzzles}, {_i = _i + 1}] do 
	{
		_allGrenades = _allGrenades + getArray(_weapon >> (_muzzles select _i) >> "magazines");
	};

} foreach _throwWeapons;

{
	diag_log _x;
} forEach _allGrenades;
hint format["%1", _allGrenades];