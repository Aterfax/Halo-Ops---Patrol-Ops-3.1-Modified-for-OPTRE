
#include "macro.sqf"

private["_request","_filter","_control","_info"];
_selectedPreset = [_this, 0, -1, [1]] call BIS_fnc_Param;

waitUntil {!isNull (findDisplay ASORGS_Main_Display)};
waitUntil {!ASORGS_Loading};
disableSerialization;
#define SIDE_EAST 0
#define SIDE_WEST 1
#define SIDE_INDEPENDENT 2
#define SIDE_CIV 3
_playerSide = -1;

switch (side ASORGS_Player) do {
	case EAST: {_playerSide = SIDE_EAST;};
	case WEST: {_playerSide = SIDE_WEST;};
	case INDEPENDENT: {_playerSide = SIDE_INDEPENDENT;};
	case CIVILIAN: {_playerSide = SIDE_CIV;};
};
ASORGS_PlayerSideID = _playerSide;

_sideBlacklistName = format["ASORGS_Blacklist_%1", side ASORGS_Player];
_sideBlacklist = missionNamespace getVariable _sideBlacklistName;
if(isNil '_sideBlacklist') then {_sideBlacklist = [];};

_factionName = faction ASORGS_Player;
_factionBlacklistName = format["ASORGS_Blacklist_%1", side ASORGS_Player];
_factionBlacklist = missionNamespace getVariable _factionBlacklistName;
if(isNil '_factionBlacklist') then {_factionBlacklist = [];};

ASORGS_RuntimeBlacklist = _sideBlacklist + _factionBlacklist;

_sideWhitelistName = format["ASORGS_Whitelist_%1", side ASORGS_Player];
_sideWhitelist = missionNamespace getVariable _sideWhitelistName;
if(isNil '_sideWhitelist') then {_sideWhitelist = [];};

_factionName = faction ASORGS_Player;
_factionWhitelistName = format["ASORGS_Whitelist_%1", side ASORGS_Player];
_factionWhitelist = missionNamespace getVariable _factionWhitelistName;
if(isNil '_factionWhitelist') then {_factionWhitelist = [];};
ASORGS_RuntimeWhitelist = _sideWhitelist + _factionWhitelist;

//hint format["%1,%2,%3",_sideBlacklist, _factionBlacklist, ASORGS_RuntimeBlacklist];
ASORGS_Busy = 0;
ASORGS_Loading = true;
ASORGS_NeedsUpdating = [];

[_selectedPreset] call ASORGS_fnc_UpdatePresets;


_playerPrimary = call ASORGS_fnc_GetPrimaryWeapon;
_playerHandgun = call ASORGS_fnc_GetHandgun;
_playerSecondary = call ASORGS_fnc_GetLauncher;
_primaryAttachments = call ASORGS_fnc_GetPrimaryWeaponItems;
_secondaryAttachments = call ASORGS_fnc_GetLauncherItems;
_handgunAttachments = call ASORGS_fnc_GetHandgunItems;
_playerUniform = call ASORGS_fnc_GetUniform;
_playerVest = call ASORGS_fnc_GetVest;
_playerBackpack = call ASORGS_fnc_GetBackpack;
_playerHeadgear = call ASORGS_fnc_GetHeadgear;
_playerItems = call ASORGS_fnc_GetInventoryItems;
_playerNightvision = call ASORGS_fnc_GetNightvision;
_playerGoggles = call ASORGS_fnc_GetGoggles;
_playerInsignia =  call ASORGS_fnc_GetInsignia;
_playerBinoculars = call ASORGS_fnc_GetBinoculars;
_playerMap = call ASORGS_fnc_GetMap;
_playerGPS = call ASORGS_fnc_GetGPS;
_playerRadio = call ASORGS_fnc_GetRadio;
_playerCompass = call ASORGS_fnc_GetCompass;
_playerWatch = call ASORGS_fnc_GetWatch;

_playerRadio = [_playerRadio] call ASORGS_fnc_GetRadioClass;

[ASORGS_map_combo, "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_map_gs.paa", [_playerMap], DB_Maps] call ASORGS_fnc_Updatecombo;
[ASORGS_gps_combo, "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_gps_gs.paa", [_playerGPS], DB_GPS] call ASORGS_fnc_Updatecombo;
[ASORGS_radio_combo, "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_radio_gs.paa", [_playerRadio], DB_Radios] call ASORGS_fnc_Updatecombo;
[ASORGS_compass_combo, "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_compass_gs.paa", [_playerCompass], DB_Compass] call ASORGS_fnc_Updatecombo;
[ASORGS_watch_combo, "\A3\ui_f\data\gui\rsc\rscdisplaygear\ui_gear_watch_gs.paa", [_playerWatch], DB_Watchs] call ASORGS_fnc_Updatecombo;

[ASORGS_primary_combo, "", [_playerPrimary, configName(inheritsFrom (configFile >> "CfgWeapons" >> _playerPrimary))], DB_Rifles] call ASORGS_fnc_Updatecombo;
[ASORGS_launcher_combo, "", [_playerSecondary, configName(inheritsFrom (configFile >> "CfgWeapons" >> _playerSecondary))], DB_Launchers] call ASORGS_fnc_Updatecombo;
[ASORGS_handgun_combo, "", [_playerHandgun, configName(inheritsFrom (configFile >> "CfgWeapons" >> _playerHandgun))], DB_Handguns] call ASORGS_fnc_Updatecombo;

[ASORGS_uniform_combo, "", [_playerUniform], DB_Uniforms, {((_this select DBF_Side) == ASORGS_PlayerSideID) || !(ASORGS_UniformSideRestriction)}] call ASORGS_fnc_Updatecombo;

[ASORGS_headgear_combo, "", [_playerHeadgear], DB_Headgear] call ASORGS_fnc_Updatecombo;
[ASORGS_vest_combo, "", [_playerVest], DB_Vests] call ASORGS_fnc_Updatecombo;
[ASORGS_backpack_combo, "", [_playerBackpack], DB_Backpacks] call ASORGS_fnc_Updatecombo;
[ASORGS_goggles_combo, "", [_playerGoggles], DB_Goggles] call ASORGS_fnc_Updatecombo;

[ASORGS_nightvision_combo, "", [_playerNightvision] + _playerItems, DB_NightVision] call ASORGS_fnc_UpdateCombo;
[ASORGS_binoculars_combo, "", [_playerBinoculars] + _playerItems, DB_Binoculars] call ASORGS_fnc_UpdateCombo;
[ASORGS_insignia_combo, "", [_playerInsignia], DB_Insignia] call ASORGS_fnc_UpdateCombo;


//[] call ASORGS_fnc_UpdateAmmo;
["primary"] call ASORGS_fnc_UpdateAttachments;
["secondary"] call ASORGS_fnc_UpdateAttachments;
["handgun"] call ASORGS_fnc_UpdateAttachments;

[ASORGS_grenade_label, "mags"] call ASORGS_fnc_updateMultiCombo;
[ASORGS_misc_label, "misc"] call ASORGS_fnc_updateMultiCombo;
[ASORGS_explosives_label, "mags"] call ASORGS_fnc_updateMultiCombo;
[ASORGS_medical_label, "medical"] call ASORGS_fnc_updateMultiCombo;
call ASORGS_fnc_UpdateAmmo; 
/*
[ASORGS_primaryAmmo_label, "mags"] call ASORGS_fnc_updateMultiCombo;
[ASORGS_launcherAmmo_label, "mags"] call ASORGS_fnc_updateMultiCombo;
[ASORGS_handgunAmmo_label, "mags"] call ASORGS_fnc_updateMultiCombo;
[ASORGS_extraammo_label, "mags"] call ASORGS_fnc_updateMultiCombo;*/
[] call ASORGS_fnc_updateExtraAttach;
[] call ASORGS_fnc_UpdateCapacity;
[] call ASORGS_fnc_UpdateUI;
sleep 0.1;
//nothing needs updating as loading just finished
ASORGS_NeedsUpdating = [];
if(isNil {ASORGS_UpdateLoop}) then {
	ASORGS_UpdateLoop = [] spawn ASORGS_fnc_UpdateLoop;
};
ASORGS_Loading = false;
ASORGS_FirstLoad = false;