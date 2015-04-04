private ["_class", "_this"];
_class = _this select 0;
(tolower getText (configFile >> "cfgWeapons" >> _class >> "simulation")) == "itemradio"