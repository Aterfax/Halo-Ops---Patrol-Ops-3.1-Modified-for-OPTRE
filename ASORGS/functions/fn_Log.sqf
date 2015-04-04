if(isNil 'ASORGS_Debug') exitWith {};
private ["_string", "_this"];
_string = format["%1", _this];
diag_log format["ASORGS_Debug: %1", _string];
hint _string;
