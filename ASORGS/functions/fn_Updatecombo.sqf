#include "macro.sqf"
_comboIDC = _this select 0;
_nonePicture = _this select 1;
_currentItem = _this select 2;
_DB = _this select 3;
_additionalCheck = [_this, 4, {true}, [{}]] call BIS_fnc_Param;
_control = ASORGS_getControl(ASORGS_Main_Display,_comboIDC);
if(ASORGS_FirstLoad) then {
	lbClear _control;
	_control lbAdd format["%1", "None"]; //Displayname on list
	_control lbSetData [(lbSize _control)-1,""]; //Data for index is classname
	_control lbSetValue [(lbSize _control)-1,-1]; //index 
	_control lbSetPicture [(lbSize _control)-1,_nonePicture];
	_control lbSetCurSel 0;
	{
		_details = _x;
		if((count _details > 0) && (!((_details select DBF_Class) in ASORGS_RuntimeBlacklist)) && (_details call _additionalCheck)) then
		{
			_control lbAdd format["%1", (_details select DBF_Name)]; //Displayname on list
			_control lbSetData [(lbSize _control)-1,(_details select DBF_Class)]; //Data for index is classname
			if ((_details select DBF_Class) in _currentItem) then {
				_control lbSetCurSel (lbSize _control)-1;
			};
			_control lbSetValue [(lbSize _control)-1,(_details select DBF_Index)]; //index 
			_control lbSetPicture [(lbSize _control)-1,(_details select DBF_Picture)];
		};
	} foreach (ASORGS_DB select _DB);
} else {
	for [{_i = 0}, {_i < (lbSize _control)}, {_i = _i + 1}] do {
		if((_control lbData _i) in _currentItem) then {
			_control lbSetCurSel _i;
		};
	};
};