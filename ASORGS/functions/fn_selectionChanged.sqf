#include "macro.sqf"
if(ASORGS_Loading) exitWith{};

waitUntil {isNil 'ASORGS_HandlingEvent'};
ASORGS_HandlingEvent = true;
disableSerialization;
_control = _this select 0;
_index = _this select 1;


_idc = ctrlIDC _control;
switch (_idc) do
{	

	default {
		ASORGS_NeedsUpdating = ASORGS_NeedsUpdating - [_idc];
		ASORGS_NeedsUpdating = ASORGS_NeedsUpdating + [_idc];
	};
};
ASORGS_HandlingEvent = nil;