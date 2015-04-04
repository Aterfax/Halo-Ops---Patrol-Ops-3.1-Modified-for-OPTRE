[] call ASORGS_fnc_CameraEnd;
[ASORGS_CurrentInventory] spawn ASORGS_fnc_applyGearArray;
if(ASORGS_Player != player) exitWith {};

ASORGS_RespawnGear = ASORGS_CurrentInventory;

TF_respawnedAt = time - 20;