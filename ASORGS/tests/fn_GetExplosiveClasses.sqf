hint "getting explosive classes";
_explosives = [];
_allMags = (configFile >> "CfgMagazines");
for[{_i = 0}, {_i < count _allMags}, {_i = _i + 1}] do 
{
	_cfg = _allMags select _i;
	if(getText(_cfg >> "UseActionTitle") != "") then {
		_explosives pushBack configName(_cfg);
	};
};

{
	diag_log _x;
} forEach _explosives;
hint format["%1", _explosives];