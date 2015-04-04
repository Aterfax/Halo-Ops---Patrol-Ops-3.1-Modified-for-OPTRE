[] execvm "ASORGS\tests\open.sqf";
sleep 5;
format["setAmmoTime = %1.",    [ASORGS_fnc_setAmmo,    [], 20] call CBA_fnc_BenchmarkFunction] spawn BIS_fnc_Log;
format["updateAmmoTime = %1.", [ASORGS_fnc_updateAmmo, [], 20] call CBA_fnc_BenchmarkFunction] spawn BIS_fnc_Log;
format["resetClone = %1.", [ASORGS_fnc_resetClone, [], 20] call CBA_fnc_BenchmarkFunction] spawn BIS_fnc_Log;
closeDialog 0;