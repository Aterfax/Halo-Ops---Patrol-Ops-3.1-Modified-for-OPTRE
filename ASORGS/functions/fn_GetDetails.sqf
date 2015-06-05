private ["_arrayindex", "_classindex"];
_arrayindex = _this select 1;

_classindex = (ASORGS_DBIndexs select _arrayindex) find (toLower(_this select 0));
if(_classindex == -1) then { 
	[] 
} else {
	ASORGS_DB select _arrayindex select _classindex
}

