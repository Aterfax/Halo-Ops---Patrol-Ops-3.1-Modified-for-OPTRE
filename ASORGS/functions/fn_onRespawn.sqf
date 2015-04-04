#include "macro.sqf"
disableSerialization;
private["_uniformchecked", "_vestchecked", "_backpackchecked", "_slot","_loadout","_primary","_launcher","_handgun","_magazines","_uniform","_vest","_backpack","_items","_primitems","_secitems","_handgunitems","_uitems","_vitems","_bitems","_handle"];
if(isNil 'ASORGS_RespawnGear') exitWith{};

if(!ASORGS_ReapplyOnRespawn) exitWith {};
waitUntil{isNil {ASORGS_loading_preset} };
waitUntil{alive player};
waitUntil{player == player};
ASORGS_Player = player;
[ASORGS_RespawnGear] call ASORGS_fnc_applyGearArray;
