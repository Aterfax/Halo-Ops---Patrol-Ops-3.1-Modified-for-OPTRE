#include "macro.sqf"
//#include "selectionChangedMacros.sqf"
disableSerialization;
_maxChangeFrequency = 0.02;
waitUntil{!ASORGS_Loading};
#define ASORGS_SLEEPTIME 0.0
_setAmmo = {
		private ["_labelIDC", "_combonumber", "_count", "_countControl"];
		_labelIDC = _this select 0;
		_combonumber = _this select 1;
		_countControl = ASORGS_getControl(ASORGS_Main_Display, _labelIDC + 1 + (10*(_combonumber-1))+2);
		_comboControl = ASORGS_getControl(ASORGS_Main_Display, _labelIDC + 1 + (10*(_combonumber-1)));
		_db = DB_Magazines;
		_itemIndex = _comboControl lbValue (lbCurSel _comboControl);
		_itemName = _comboControl lbData (lbCurSel _comboControl);
		_count = parseNumber ctrlText _countControl;
		if(_count <= 0) then { _count = 1;  };
		if(_itemIndex == -1) then {_count = 0;};
		_countControl ctrlSetText format["%1", _count];
		[] call ASORGS_fnc_SetAmmo;
		call ASORGS_fnc_UpdateAmmo;
		/*[_labelIDC, "mags"] call ASORGS_fnc_UpdateMultiCombo;
		[ASORGS_primaryAmmo_label, "mags"] call ASORGS_fnc_updateMultiCombo;
		[ASORGS_launcherAmmo_label, "mags"] call ASORGS_fnc_updateMultiCombo;
		[ASORGS_handgunAmmo_label, "mags"] call ASORGS_fnc_updateMultiCombo;
		[ASORGS_extraammo_label, "mags"] call ASORGS_fnc_updateMultiCombo;*/
		[] call ASORGS_fnc_UpdateUI;
		sleep ASORGS_SLEEPTIME;
		ASORGS_NeedsUpdating = [];
};
_setItems = {
	_labelIDC = _this select 0;
	_combonumber = _this select 1;
	_type = _this select 2;
	_countControl = ASORGS_getControl(ASORGS_Main_Display, _labelIDC + 1 + (10*(_combonumber-1))+2);
	_comboControl = ASORGS_getControl(ASORGS_Main_Display, _labelIDC + 1 + (10*(_combonumber-1)));

	_db = 0;
	switch(_labelIDC) do {
		case ASORGS_extraattach_label: {_db = DB_Attachments;};
		case ASORGS_medical_label: {_db = DB_Medical;};
		case ASORGS_misc_label: {_db = DB_Items;};
	};
	_itemIndex = _comboControl lbValue (lbCurSel _comboControl);
	_itemName = _comboControl lbData (lbCurSel _comboControl);
	_count = parseNumber ctrlText _countControl;
	if(_count <= 0) then { _count = 1;  };	
	_countControl ctrlSetText format["%1", _count];
	[] call ASORGS_fnc_setItems;
	[_labelIDC, _type] call ASORGS_fnc_UpdateMultiCombo;
	[] call ASORGS_fnc_UpdateUI;
	sleep ASORGS_SLEEPTIME;
	ASORGS_NeedsUpdating = [];
};
_setExtraAttach = {
	[] call ASORGS_fnc_setItems;
	[] call ASORGS_fnc_UpdateExtraAttach;
	[] call ASORGS_fnc_UpdateUI;
	sleep ASORGS_SLEEPTIME;
	ASORGS_NeedsUpdating = [];
};
_setExplosives = {
		private ["_labelIDC", "_combonumber", "_count", "_countControl"];
		_labelIDC = _this select 0;
		_combonumber = _this select 1;
		_countControl = ASORGS_getControl(ASORGS_Main_Display, _labelIDC + 1 + (10*(_combonumber-1))+2);
		_comboControl = ASORGS_getControl(ASORGS_Main_Display, _labelIDC + 1 + (10*(_combonumber-1)));
		_db = DB_Explosives;
		_itemIndex = _comboControl lbValue (lbCurSel _comboControl);
		_itemName = _comboControl lbData (lbCurSel _comboControl);
		_count = parseNumber ctrlText _countControl;
		if(_count <= 0) then { _count = 1;  };
		_countControl ctrlSetText format["%1", _count];
		[] call ASORGS_fnc_SetExplosives;
		[_labelIDC, "mags"] call ASORGS_fnc_UpdateMultiCombo;
		[] call ASORGS_fnc_UpdateUI;
		sleep ASORGS_SLEEPTIME;
		ASORGS_NeedsUpdating = [];
};

_setGrenades = {
		private ["_labelIDC", "_combonumber", "_count", "_countControl"];
		_labelIDC = _this select 0;
		_combonumber = _this select 1;
		_countControl = ASORGS_getControl(ASORGS_Main_Display, _labelIDC + 1 + (10*(_combonumber-1))+2);
		_comboControl = ASORGS_getControl(ASORGS_Main_Display, _labelIDC + 1 + (10*(_combonumber-1)));
		_db = DB_Throwable;
		_itemIndex = _comboControl lbValue (lbCurSel _comboControl);
		_itemName = _comboControl lbData (lbCurSel _comboControl);
		_count = parseNumber ctrlText _countControl;
		if(_count <= 0) then { _count = 1;  };
		_countControl ctrlSetText format["%1", _count];
		[] call ASORGS_fnc_SetGrenades;
		[ASORGS_grenade_label, "mags"] call ASORGS_fnc_updateMultiCombo;
		[] call ASORGS_fnc_UpdateUI;
		sleep ASORGS_SLEEPTIME;
		ASORGS_NeedsUpdating = [];
};



while{ASORGS_Open} do {
	while{(count ASORGS_NeedsUpdating) > 0} do {
		_idc = ASORGS_NeedsUpdating select 0;
		_control = ASORGS_getControl(ASORGS_Main_Display, _idc);
		_index = _control lbValue (lbCurSel _control) ;
		_newclass = _control lbData (lbCurSel _control);
		switch (_idc) do
		{	
			case ASORGS_primary_combo : {
				[_newclass, "primary"] call ASORGS_fnc_SwitchWeapons;
			};
			case ASORGS_preset_combo : {
				[] call ASORGS_fnc_presetSelected;
			};

			case ASORGS_primaryScope_combo : {
				[_newclass, "primary", IIT_SCOPE ] call ASORGS_fnc_SwitchAttachments;
			};
			case ASORGS_primarySuppressor_combo : {
				[_newclass, "primary", IIT_SUPPRESSOR ] call ASORGS_fnc_SwitchAttachments;
			};
			case ASORGS_primaryRail_combo : {
				[_newclass, "primary", IIT_RAIL] call ASORGS_fnc_SwitchAttachments;
			};
			case ASORGS_primaryBipod_combo : {
				[_newclass, "primary", IIT_BIPOD] call ASORGS_fnc_SwitchAttachments;
			};
			case ASORGS_launcher_combo : {
				[_newclass, "secondary"] call ASORGS_fnc_SwitchWeapons;
			};
			case ASORGS_launcherScope_combo : {
				[_newclass, "secondary", IIT_SCOPE] call ASORGS_fnc_SwitchAttachments;
			};
			case ASORGS_handgunScope_combo : {
				[_newclass, "handgun", IIT_SCOPE] call ASORGS_fnc_SwitchAttachments;
			};
			case ASORGS_handgunSuppressor_combo : {
				[_newclass, "handgun", IIT_SUPPRESSOR] call ASORGS_fnc_SwitchAttachments;
			};
			case ASORGS_handgunBipod_combo : {
				[_newclass, "handgun", IIT_BIPOD] call ASORGS_fnc_SwitchAttachments;
			};
			case ASORGS_handgun_combo : {
				[_newclass, "handgun"] call ASORGS_fnc_SwitchWeapons;
			};
			case ASORGS_uniform_combo : {
				_oldUniform = call ASORGS_fnc_GetUniform;
				if(_oldUniform != "") then {
					call ASORGS_fnc_RemoveUniform;
				};
				 if(_newclass != "") then {
					[_newclass] call ASORGS_fnc_AddUniform;
				};	
				call ASORGS_fnc_ValidateInventory;
				[ASORGS_grenade_label, "mags"] call ASORGS_fnc_updateMultiCombo;
				[ASORGS_misc_label, "misc"] call ASORGS_fnc_updateMultiCombo;
				[ASORGS_explosives_label, "mags"] call ASORGS_fnc_updateMultiCombo;
				[ASORGS_medical_label, "medical"] call ASORGS_fnc_updateMultiCombo;
				call ASORGS_fnc_UpdateAmmo;
				[] call ASORGS_fnc_updateExtraAttach;
				[ASORGS_Player, ASORGS_Player call BIS_fnc_getUnitInsignia] call ASORGS_fnc_setUnitInsignia;
			};
			case ASORGS_vest_combo : {
				_oldvest = call ASORGS_fnc_GetVest;
				if(_oldvest != "") then {
					call ASORGS_fnc_RemoveVest;
				};
				 if(_newclass != "") then {
					[_newclass] call ASORGS_fnc_AddVest;
				};	
				call ASORGS_fnc_ValidateInventory;
				[ASORGS_grenade_label, "mags"] call ASORGS_fnc_updateMultiCombo;
				[ASORGS_misc_label, "misc"] call ASORGS_fnc_updateMultiCombo;
				[ASORGS_explosives_label, "mags"] call ASORGS_fnc_updateMultiCombo;
				[ASORGS_medical_label, "medical"] call ASORGS_fnc_updateMultiCombo;
				call ASORGS_fnc_UpdateAmmo;
				[] call ASORGS_fnc_updateExtraAttach;
			};
			case ASORGS_backpack_combo : {
				_oldbp = call ASORGS_fnc_GetBackpack;
				if(_oldbp != "") then {
					call ASORGS_fnc_RemoveBackpack;
				};
				 if(_newclass != "") then {
					[_newclass] call ASORGS_fnc_AddBackpack;
				};	
				call ASORGS_fnc_ValidateInventory;
				[ASORGS_grenade_label, "mags"] call ASORGS_fnc_updateMultiCombo;
				[ASORGS_misc_label, "misc"] call ASORGS_fnc_updateMultiCombo;
				[ASORGS_explosives_label, "mags"] call ASORGS_fnc_updateMultiCombo;
				[ASORGS_medical_label, "medical"] call ASORGS_fnc_updateMultiCombo;
				call ASORGS_fnc_UpdateAmmo;
				[] call ASORGS_fnc_updateExtraAttach;
			};
			case ASORGS_headgear_combo : {
				_oldhg = call ASORGS_fnc_GetHeadgear;
				if(_oldhg != "") then {
					[_oldhg] call ASORGS_fnc_RemoveHeadgear;
				};
				if(_newclass != "") then {
					[_newclass] call ASORGS_fnc_AddHeadgear;
				};
			};
			case ASORGS_binoculars_combo : {
				//remove players mags first so there's (almost) always room for binoculars
				//{ ASORGS_Player removeMagazine _x; } forEach (magazines ASORGS_Player);
				[] call ASORGS_fnc_setBinoculars;
				[] call ASORGS_fnc_SetAmmo;
				[] call ASORGS_fnc_SetGrenades;
				[] call ASORGS_fnc_SetExplosives;
			};
			case ASORGS_goggles_combo : {
			
				[] call ASORGS_fnc_setGoggles;
			};
			case ASORGS_nightvision_combo : {
				//remove players mags first so there's (almost) always room for NV
				//{  ASORGS_Player removeMagazine _x; } forEach (magazines ASORGS_Player);
				[] call ASORGS_fnc_setNightvision;
				
				[] call ASORGS_fnc_SetAmmo;
				[] call ASORGS_fnc_SetGrenades;
				[] call ASORGS_fnc_SetExplosives;
			};
			case ASORGS_primaryAmmo1_combo : {
				[ASORGS_primaryAmmo_label,1] call _setAmmo;
			};
			case ASORGS_primaryAmmo2_combo : {
				[ASORGS_primaryAmmo_label,2] call _setAmmo;
			};			
			case ASORGS_primaryAmmo3_combo : {
				[ASORGS_primaryAmmo_label,3] call _setAmmo;
			};			
			case ASORGS_primaryAmmo4_combo : {
				[ASORGS_primaryAmmo_label,4] call _setAmmo;
			};
			case ASORGS_primaryAmmo5_combo : {
				[ASORGS_primaryAmmo_label,5] call _setAmmo;
			};
			case ASORGS_handgunAmmo1_combo : {
				[ASORGS_handgunAmmo_label,1] call _setAmmo;
			};
			case ASORGS_handgunAmmo2_combo : {
				[ASORGS_handgunAmmo_label,2] call _setAmmo;
			};
			case ASORGS_handgunAmmo3_combo : {
				[ASORGS_handgunAmmo_label,3] call _setAmmo;
			};
			case ASORGS_handgunAmmo4_combo : {
				[ASORGS_handgunAmmo_label,4] call _setAmmo;
			};			
			case ASORGS_handgunAmmo5_combo : {
				[ASORGS_handgunAmmo_label,5] call _setAmmo;
			};			
			case ASORGS_launcherAmmo1_combo : {
				[ASORGS_launcherAmmo_label,1] call _setAmmo;
			};
			case ASORGS_launcherAmmo2_combo : {
				[ASORGS_launcherAmmo_label,2] call _setAmmo;
			};
			case ASORGS_launcherAmmo3_combo : {
				[ASORGS_launcherAmmo_label,3] call _setAmmo;
			};
			case ASORGS_launcherAmmo4_combo : {
				[ASORGS_launcherAmmo_label,4] call _setAmmo;
			};
			case ASORGS_launcherAmmo5_combo : {
				[ASORGS_launcherAmmo_label,5] call _setAmmo;
			};
			case ASORGS_medical1_combo : {
				[ASORGS_medical_label,1, "medical"] call _setItems;
			};
			case ASORGS_medical2_combo : {
				[ASORGS_medical_label,2, "medical"] call _setItems;
			};
			case ASORGS_medical3_combo : {
				[ASORGS_medical_label,3, "medical"] call _setItems;
			};
			case ASORGS_medical4_combo : {
				[ASORGS_medical_label,4, "medical"] call _setItems;
			};
			case ASORGS_medical5_combo : {
				[ASORGS_medical_label,5, "medical"] call _setItems;
			};
			case ASORGS_medical6_combo : {
				[ASORGS_medical_label,6, "medical"] call _setItems;
			};
			case ASORGS_medical7_combo : {
				[ASORGS_medical_label,7, "medical"] call _setItems;
			};
			case ASORGS_medical8_combo : {
				[ASORGS_medical_label,8, "medical"] call _setItems;
			};
			case ASORGS_medical9_combo : {
				[ASORGS_medical_label,9, "medical"] call _setItems;
			};
			case ASORGS_medical10_combo : {
				[ASORGS_medical_label,10, "medical"] call _setItems;
			};
			case ASORGS_medical11_combo : {
				[ASORGS_medical_label,11, "medical"] call _setItems;
			};
			case ASORGS_medical12_combo : {
				[ASORGS_medical_label,12, "medical"] call _setItems;
			};
			case ASORGS_medical13_combo : {
				[ASORGS_medical_label,13, "medical"] call _setItems;
			};
			case ASORGS_medical14_combo : {
				[ASORGS_medical_label,14, "medical"] call _setItems;
			};
			case ASORGS_medical15_combo : {
				[ASORGS_medical_label,15, "medical"] call _setItems;
			};
			case ASORGS_medical16_combo : {
				[ASORGS_medical_label,16, "medical"] call _setItems;
			};
			case ASORGS_medical17_combo : {
				[ASORGS_medical_label,17, "medical"] call _setItems;
			};
			case ASORGS_medical18_combo : {
				[ASORGS_medical_label,18, "medical"] call _setItems;
			};
			case ASORGS_medical19_combo : {
				[ASORGS_medical_label,19, "medical"] call _setItems;
			};
			case ASORGS_medical20_combo : {
				[ASORGS_medical_label,20, "medical"] call _setItems;
			};
			case ASORGS_misc1_combo : {
				[ASORGS_misc_label,1, "misc"] call _setItems;
			};
			case ASORGS_misc2_combo : {
				[ASORGS_misc_label,2, "misc"] call _setItems;
			};
			case ASORGS_misc3_combo : {
				[ASORGS_misc_label,3, "misc"] call _setItems;
			};
			case ASORGS_misc4_combo : {
				[ASORGS_misc_label,4, "misc"] call _setItems;
			};
			case ASORGS_misc5_combo : {
				[ASORGS_misc_label,5, "misc"] call _setItems;
			};
			case ASORGS_misc6_combo : {
				[ASORGS_misc_label,6, "misc"] call _setItems;
			};
			case ASORGS_misc7_combo : {
				[ASORGS_misc_label,7, "misc"] call _setItems;
			};
			case ASORGS_misc8_combo : {
				[ASORGS_misc_label,8, "misc"] call _setItems;
			};
			case ASORGS_misc9_combo : {
				[ASORGS_misc_label,9, "misc"] call _setItems;
			};
			case ASORGS_misc10_combo : {
				[ASORGS_misc_label,10, "misc"] call _setItems;
			};
			case ASORGS_grenade1_combo : {
				[ASORGS_grenade_label,1] call _setGrenades;
			};
			case ASORGS_grenade2_combo : {
				[ASORGS_grenade_label,2] call _setGrenades;
			};
			case ASORGS_grenade3_combo : {
				[ASORGS_grenade_label,3] call _setGrenades;
			};
			case ASORGS_grenade4_combo : {
				[ASORGS_grenade_label,4] call _setGrenades;
			};
			case ASORGS_grenade5_combo : {
				[ASORGS_grenade_label,5] call _setGrenades;
			};
			case ASORGS_explosives1_combo : {
				[ASORGS_explosives_label,1] call _setExplosives;
			};
			case ASORGS_explosives2_combo : {
				[ASORGS_explosives_label,2] call _setExplosives;
			};
			case ASORGS_explosives3_combo : {
				[ASORGS_explosives_label,3] call _setExplosives;
			};
			case ASORGS_explosives4_combo : {
				[ASORGS_explosives_label,4] call _setExplosives;
			};
			case ASORGS_explosives5_combo : {
				[ASORGS_explosives_label,5] call _setExplosives;
			};
			case ASORGS_extraammo1_combo : {
				[ASORGS_extraammo_label,1] call _setAmmo;
			};
			case ASORGS_extraammo2_combo : {
				[ASORGS_extraammo_label,2] call _setAmmo;
			};
			case ASORGS_extraammo3_combo : {
				[ASORGS_extraammo_label,3] call _setAmmo;
			};
			case ASORGS_extraammo4_combo : {
				[ASORGS_extraammo_label,4] call _setAmmo;
			};
			case ASORGS_extraammo5_combo : {
				[ASORGS_extraammo_label,5] call _setAmmo;
			};
			case ASORGS_extraattach1_combo : {
				[] call _setextraattach;
			};
			case ASORGS_extraattach2_combo : {
				[] call _setextraattach;
			};
			case ASORGS_extraattach3_combo : {
				[] call _setextraattach;
			};
			case ASORGS_extraattach4_combo : {
				[] call _setextraattach;
			};
			case ASORGS_extraattach5_combo : {
				[] call _setextraattach;
			};
			case ASORGS_insignia_combo : {
				if(ASORGS_UnitInsigniaOption) then {
					
					_ctrl = ASORGS_getControl(ASORGS_Main_Display,ASORGS_insignia_combo);
					_insignia = _ctrl lbData (lbCurSel _ctrl);
					[_insignia] call ASORGS_fnc_AddInsignia;
				};
			};
			case ASORGS_map_combo : {
				[_newclass] call ASORGS_fnc_AddMap;
			};
			case ASORGS_gps_combo : {
				[_newclass] call ASORGS_fnc_AddGPS;
			};
			case ASORGS_radio_combo: {
				[_newclass] call ASORGS_fnc_AddRadio;
			};
			case ASORGS_compass_combo : {
				[_newclass] call ASORGS_fnc_AddCompass;
			};
			case ASORGS_watch_combo : {
				[_newclass] call ASORGS_fnc_AddWatch;
			};

		};
		[] call ASORGS_fnc_ResetClone;		
		[] call ASORGS_fnc_UpdateCapacity;
		
		ASORGS_NeedsUpdating = ASORGS_NeedsUpdating - [_idc];
		//	diag_log format["%1", ASORGS_NeedsUpdating] ;
	};
	sleep _maxChangeFrequency;
};
ASORGS_UpdateLoop = nil;