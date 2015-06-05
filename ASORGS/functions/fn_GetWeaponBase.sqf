private["_weapon", "_this", "_weaponcfg", "_parents", "_parent"];
_weapon = _this;
if(_weapon == "") exitWith {""};
_weaponcfg = (configFile >> "cfgWeapons" >> _weapon);
if(!isClass _weaponcfg) exitWith {""};
_parents = (_weaponcfg call BIS_fnc_returnParents);
if((count _parents) < 2) exitWith {_weapon}; // 0 or 1 parents
_parent = _parents select 1;
if(getNumber(_parent >> "scope") !=2) exitWith {_weapon};
if(getText(_parent >> "displayName") == getText(_weaponcfg >> "displayName")) then { _weapon = (configName _parent) call ASORGS_fnc_GetWeaponBase; };
_weapon