#include "macro.sqf"
disableSerialization;
#define CATEGORY_SPACING  .01
#define ITEM_SPACING .005
#define ITEM_HEIGHT (1/25)
#define DIALOG_MARGIN .01
#define LABEL_WIDTH .21
#define TOTAL_WIDTH (safezoneW * 0.33333)
#define SAVE_WIDTH 0.1
#define TOP_SPACING .005
#define TOP (safezoneY + TOP_SPACING)
#define TEXT_SIZE .04

#define FULLCOMBO_WIDTH (TOTAL_WIDTH - (DIALOG_MARGIN * 2) - LABEL_WIDTH)

#define BOX_COMBO_WIDTH ((FULLCOMBO_WIDTH/5) - (ITEM_SPACING * 4))
#define BOX_COMBO_HEIGHT ((BOX_COMBO_WIDTH *0.86)*(4/3))
#define BOX_SPACING ((FULLCOMBO_WIDTH - BOX_COMBO_WIDTH*5) / 4)

#define ASORGS_ControlHeight  (1/25)
#define ASORGS_ControlSpacing  0.005
#define ASORGS_CategorySpacing 0.01
#define ASORGS_TopMargin ASORGS_ControlSpacing
#define ASORGS_MultiComboControls 6
#define END_CATEGORY _y = _y + ASORGS_CategorySpacing; _categoryCount = _categoryCount + 1;
#define END_ITEM _y = _y + ASORGS_ControlHeight + ASORGS_ControlSpacing; _lineCount = _lineCount + 1;
#define SHOW_ITEM(FIRSTIDC, IDCCOUNT) [FIRSTIDC, IDCCOUNT, _y] call ASORGS_fnc_updateUIShow; END_ITEM
#define HIDE_ITEM(FIRSTIDC, IDCCOUNT) [FIRSTIDC, IDCCOUNT, _y] call ASORGS_fnc_updateUIhide;
#define SHOW_SINGLEITEM_IF(FIRSTIDC, SHOWCONDITION)  if(SHOWCONDITION) then {SHOW_ITEM(FIRSTIDC, 2)} else {HIDE_ITEM(FIRSTIDC, 2)};
#define SHOW_SINGLEITEMCAT_IF(FIRSTIDC, SHOWCONDITION)  if(SHOWCONDITION) then {SHOW_ITEM(FIRSTIDC, 2) END_CATEGORY} else {HIDE_ITEM(FIRSTIDC, 2)};
#define SHOW_MULTICOMBO_IF(FIRSTIDC, SHOWCONDITION, COMBOCOUNT) \
	if(SHOWCONDITION) then { [FIRSTIDC, 1, _y] call ASORGS_fnc_updateUIShow; } else { [FIRSTIDC, 1, _y] call ASORGS_fnc_updateUIHide; }; \
	_currentIDC = FIRSTIDC + 1; \
	_previousIDC = _currentIDC; \
	for[{_t = 0}, {_t < COMBOCOUNT}, {_t = _t + 1}] do 	{ \
		if(((_t > 0) && ((lbCurSel _previousIDC) == 0)) || !SHOWCONDITION) then { \
			HIDE_ITEM(_currentIDC, ASORGS_MultiComboControls) } else { \
			SHOW_ITEM(_currentIDC, ASORGS_MultiComboControls) }; \
		_previousIDC = _currentIDC; \
		_currentIDC = _currentIDC + 10; }; 
#define SHOW_MULTICOMBOCAT_IF(FIRSTIDC, SHOWCONDITION, COMBOCOUNT) \
	SHOW_MULTICOMBO_IF(FIRSTIDC, SHOWCONDITION, COMBOCOUNT) \
	if(SHOWCONDITION) then { END_CATEGORY };

#define ENDSHRUNK_ITEM _y = _y + _itemHeight + ASORGS_ControlSpacing;
#define ENDSHRUNK_CATEGORY _y = _y + ASORGS_CategorySpacing;
#define SHOWSHRUNK_ITEM(FIRSTIDC, IDCCOUNT) [FIRSTIDC, IDCCOUNT, _y, _itemHeight] call ASORGS_fnc_updateUIShow; ENDSHRUNK_ITEM;
#define SHOWSHRUNK_SINGLEITEM_IF(FIRSTIDC, SHOWCONDITION)  if(SHOWCONDITION) then {SHOWSHRUNK_ITEM(FIRSTIDC, 2)} else {HIDE_ITEM(FIRSTIDC, 2)};
#define SHOWSHRUNK_SINGLEITEMCAT_IF(FIRSTIDC, SHOWCONDITION)  if(SHOWCONDITION) then {SHOWSHRUNK_ITEM(FIRSTIDC, 2) ENDSHRUNK_CATEGORY} else {HIDE_ITEM(FIRSTIDC, 2)};
#define SHOWSHRUNK_MULTICOMBO_IF(FIRSTIDC, SHOWCONDITION, COMBOCOUNT) \
	if(SHOWCONDITION) then { [FIRSTIDC, 1, _y, _itemHeight] call ASORGS_fnc_updateUIShow; } else { [FIRSTIDC, 1, _y] call ASORGS_fnc_updateUIHide; }; \
	_currentIDC = FIRSTIDC + 1; \
	_previousIDC = _currentIDC; \
	for[{_t = 0}, {_t < COMBOCOUNT}, {_t = _t + 1}] do 	{ \
		if(((_t > 0) && ((lbCurSel _previousIDC) == 0)) || !SHOWCONDITION) then { \
			HIDE_ITEM(_currentIDC, ASORGS_MultiComboControls) } else { \
			SHOWSHRUNK_ITEM(_currentIDC, ASORGS_MultiComboControls) }; \
		_previousIDC = _currentIDC; \
		_currentIDC = _currentIDC + 10; }; 
#define SHOWSHRUNK_MULTICOMBOCAT_IF(FIRSTIDC, SHOWCONDITION, COMBOCOUNT) \
	SHOWSHRUNK_MULTICOMBO_IF(FIRSTIDC, SHOWCONDITION, COMBOCOUNT) \
	if(SHOWCONDITION) then { ENDSHRUNK_CATEGORY };

private ["_y", "_showPrimaryWeapon", "_showPrimaryAddons", "_showLauncher", "_showLauncherAddons", "_showHandgun", "_showHandgunAddons", "_showExtraAttachments", "_showExtraAmmo", "_showGrenades"];
_showPrimaryWeapon = ASORGS_ShowPrimaryWeapon&& ((lbSize ASORGS_primary_combo) > 1);
_showPrimaryAddons = ASORGS_ShowPrimaryAddons && ((lbCurSel ASORGS_primary_combo) != 0);
_showPrimaryScope = ((lbSize ASORGS_primaryScope_combo) > 1) && _showPrimaryAddons;
_showPrimaryRail = ((lbSize ASORGS_primaryRail_combo) > 1) && _showPrimaryAddons;
_showPrimarySuppressor = ((lbSize ASORGS_primarySuppressor_combo) > 1) && _showPrimaryAddons;
_showAnyPrimary = (_showPrimaryWeapon || _showPrimaryAddons || _showPrimaryScope || _showPrimaryRail || _showPrimarySuppressor);
_showLauncher = ASORGS_ShowLauncher && ((lbSize ASORGS_launcher_combo) > 1);
_showLauncherAddons = ASORGS_ShowLauncherAddons && ((lbCurSel ASORGS_launcher_combo) != 0);
_showLauncherScope = ((lbSize ASORGS_launcherScope_combo) > 1) && _showLauncherAddons;
_showAnyLauncher = (_showLauncher || _showLauncherAddons || _showLauncherScope);
_showHandgun = ASORGS_ShowHandgun && ((lbSize ASORGS_handgun_combo) > 1);
_showHandgunAddons = ASORGS_ShowHandgunAddons && ((lbCurSel ASORGS_handgun_combo) != 0);
_showHandgunScope = ((lbSize ASORGS_handgunScope_combo) > 1) && _showHandgunAddons;
_showHandgunSuppressor = ((lbSize ASORGS_handgunSuppressor_combo) > 1) && _showHandgunAddons;
_showAnyHandgun = (_showHandgun || _showHandgunScope || _showHandgunSuppressor || _showHandgunAddons);
_showExtraAttachments = ASORGS_ShowExtraAttachments && ((lbSize ASORGS_extraattach1_combo) > 1);
_showExtraAmmo = ASORGS_ShowExtraAmmo && ((lbSize ASORGS_extraammo1_combo) > 1);
_showGrenades = ASORGS_ShowGrenades && ((lbSize ASORGS_grenade1_combo) > 1);
_showExplosives = ASORGS_ShowExplosives && ((lbSize ASORGS_explosives1_combo) > 1);
_showAnyWeapons = _showAnyPrimary || _showAnyLauncher || _showAnyHandgun || _showExtraAttachments || _showExtraAmmo || _showExplosives || _showGrenades;
_showMisc = ASORGS_ShowMisc && ((lbSize ASORGS_misc1_combo) > 1);
_showMedical = ASORGS_ShowMedical && ((lbSize ASORGS_medical1_combo) > 1);
_showAnyMisc = _showMisc || _showMedical;
_showHeadgear = ASORGS_ShowHeadgear  && ((lbSize ASORGS_headgear_combo) > 1);
_showVest = ASORGS_ShowVest && ((lbSize ASORGS_vest_combo) > 1);
_showUniform = ASORGS_ShowUniform && ((lbSize ASORGS_uniform_combo) > 1);
_showGoggles = ASORGS_ShowGoggles  && ((lbSize ASORGS_goggles_combo) > 1);
_showBackpack = ASORGS_ShowBackpack  && ((lbSize ASORGS_backpack_combo) > 1);
_showBinoculars = ASORGS_ShowBinoculars && ((lbSize ASORGS_binoculars_combo) > 1);
_showNightvision = ASORGS_ShowNightvision && ((lbSize ASORGS_nightvision_combo) > 1);
_showInsignia = ASORGS_UnitInsigniaOption && ((lbSize ASORGS_insignia_combo) > 1);
_showAnyUniform = _showHeadgear || _showVest || _showUniform || _showGoggles || _showBackpack;
_showAnyUniformOrOthers = _showInsignia || _showBinoculars || _showNightvision || _showAnyUniform;
_lineCount = 1;
_categoryCount = 0;

_y = safezoneY + ASORGS_TopMargin;//safezoneY + ASORGS_ControlHeight + ASORGS_ControlSpacing;

//preset is never hidden
SHOW_ITEM(ASORGS_preset_label, 3);
END_CATEGORY

_presetbottom = _y - (ASORGS_CategorySpacing * 0.5);
_presetborderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_presetBorder);
_presetpos = ctrlPosition _presetborderControl;
_presetpos set [1, safezoneY];
_presetpos set [3, _presetbottom - safezoneY];
_presetborderControl ctrlSetPosition _presetpos;

_weapontop = _presetbottom;// - (ASORGS_CategorySpacing );//_y - (ASORGS_CategorySpacing * 0.5);

if(_showPrimaryWeapon) then {
	SHOW_ITEM(ASORGS_primary_label, 2)
} else {
	if(_showPrimaryAddons) then {
		[ASORGS_primary_label, 2, _y] call ASORGS_fnc_updateUIShowDisabled;
		END_ITEM
	} else {
		HIDE_ITEM(ASORGS_primary_label, 2)
	};
};

SHOW_MULTICOMBO_IF(ASORGS_primaryAmmo_label, _showPrimaryAddons, 5)
SHOW_SINGLEITEM_IF(ASORGS_primaryScope_label, _showPrimaryScope)
SHOW_SINGLEITEM_IF(ASORGS_primaryRail_label, _showPrimaryRail)
SHOW_SINGLEITEM_IF(ASORGS_primarySuppressor_label, _showPrimarySuppressor)

if(_showPrimaryWeapon || _showPrimaryAddons || _showPrimaryScope || _showPrimaryRail || _showPrimarySuppressor) then {
	END_CATEGORY
};
if(_showLauncher) then {
	SHOW_ITEM(ASORGS_launcher_label, 2)
} else {
	if(_showLauncherAddons) then {
		[ASORGS_launcher_label, 2, _y] call ASORGS_fnc_updateUIShowDisabled;
		END_ITEM
	} else {
		HIDE_ITEM(ASORGS_launcher_label, 2)
	};
};
SHOW_MULTICOMBO_IF(ASORGS_launcherAmmo_label, _showLauncherAddons, 5)
SHOW_SINGLEITEM_IF(ASORGS_launcherScope_label, _showLauncherScope)

if(_showAnyLauncher) then {
	END_CATEGORY
};
if(_showHandgun) then {
	SHOW_ITEM(ASORGS_handgun_label, 2)
} else {
	if(_showHandgunAddons) then {
		[ASORGS_handgun_label, 2, _y] call ASORGS_fnc_updateUIShowDisabled;
		END_ITEM
	} else {
		HIDE_ITEM(ASORGS_handgun_label, 2)
	};
};
SHOW_MULTICOMBO_IF(ASORGS_handgunAmmo_label, _showHandgunAddons, 5)
SHOW_SINGLEITEM_IF(ASORGS_handgunScope_label, _showHandgunScope)
SHOW_SINGLEITEM_IF(ASORGS_handgunSuppressor_label, _showHandgunSuppressor)

if(_showAnyHandgun) then {
	END_CATEGORY
};
SHOW_MULTICOMBOCAT_IF(ASORGS_grenade_label, _showGrenades, 5)
SHOW_MULTICOMBOCAT_IF(ASORGS_explosives_label, _showExplosives, 5)
SHOW_MULTICOMBOCAT_IF(ASORGS_extraammo_label, _showExtraAmmo, 5)

if(_showExtraAttachments) then {
	[ASORGS_extraattach_label, 1, _y] call ASORGS_fnc_updateUIShow;
} else {
	[ASORGS_extraattach_label, 1, _y] call ASORGS_fnc_updateUIHide;
};
_comboCount = 5;	
_currentIDC = ASORGS_extraattach_label + 1;
_previousIDC = ASORGS_extraattach_label + 1;
for[{_t = 0}, {_t < _comboCount}, {_t = _t + 1}] do 
{
	if(((_t > 0) && ((lbCurSel _previousIDC) == 0)) || !_showExtraAttachments) then {
		HIDE_ITEM(_currentIDC, 1)
	
	} else {
		SHOW_ITEM(_currentIDC, 1)
	};
	_previousIDC = _currentIDC;
	_currentIDC = _currentIDC + 10;
};
if(_showExtraAttachments) then {
	END_CATEGORY
};

_weaponbottom = _y - (ASORGS_CategorySpacing * 0.5);
_weaponborderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_weaponsBorder);
_wpnpos = ctrlPosition _weaponborderControl;
_wpnpos set [1, _presetbottom];
_wpnpos set [3, _weaponbottom - _presetbottom];
_weaponborderControl ctrlSetPosition _wpnpos;

if(_showAnyWeapons) then {
	_weaponborderControl ctrlShow true;
} else {
	_weaponborderControl ctrlShow false;
};
SHOW_SINGLEITEM_IF(ASORGS_uniform_label, _showUniform)
SHOW_SINGLEITEM_IF(ASORGS_headgear_label, _showHeadgear)
SHOW_SINGLEITEM_IF(ASORGS_vest_label, _showVest)
SHOW_SINGLEITEM_IF(ASORGS_backpack_label, _showBackpack)
SHOW_SINGLEITEM_IF(ASORGS_goggles_label, _showGoggles)
if(_showAnyUniform) then {
	END_CATEGORY
};
SHOW_SINGLEITEMCAT_IF(ASORGS_nightvision_label, _showNightvision)
SHOW_SINGLEITEMCAT_IF(ASORGS_binoculars_label, _showBinoculars)
SHOW_SINGLEITEMCAT_IF(ASORGS_insignia_label, _showInsignia)

_uniformbottom = _y - (ASORGS_CategorySpacing * 0.5);
_uniformborderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_uniformBorder);
_unipos = ctrlPosition _weaponborderControl;
_unipos set [1, _weaponbottom];
_unipos set [3, _uniformbottom - _weaponbottom];
_uniformborderControl ctrlSetPosition _unipos;
if(_showAnyUniformOrOthers) then {
	_uniformborderControl ctrlShow true;
} else {
	_uniformborderControl ctrlShow false;
};
SHOW_MULTICOMBOCAT_IF(ASORGS_medical_label, _showMedical, 20)
SHOW_MULTICOMBOCAT_IF(ASORGS_misc_label, _showMisc, 5)
_miscbottom = _y - (ASORGS_CategorySpacing * 0.5);
_miscborderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_miscBorder);
_miscpos = ctrlPosition _miscborderControl;
_miscpos set [1, _uniformbottom];
_miscpos set [3, _miscbottom - _uniformbottom];
_miscborderControl ctrlSetPosition _miscpos;
if(_showAnyMisc) then {
	_miscborderControl ctrlShow true;
} else {
	_miscborderControl ctrlShow false;
};
for "_i" from ASORGS_equipped_label to ASORGS_watch_combo do {
	_control = ASORGS_getControl(ASORGS_Main_Display, _i);
	_controlPos = ctrlPosition _control;
	_controlpos set [1, _y];
	_control ctrlSetPosition _controlpos;
};
_equippedBorderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_equippedBorder);
_equippedPos = ctrlPosition _equippedBorderControl;
_equippedPos set [1, _y - ASORGS_CategorySpacing * 0.5];
_equippedBorderControl ctrlSetPosition _equippedPos;
 _y = _y + BOX_COMBO_HEIGHT + ASORGS_ControlSpacing;

 //================================================================================Shrink - doesn't fit on screen
if(_y > (safezoneY + safezoneH - (1/25))) then {
	_totalSpace = safezoneH - (1/25) - BOX_COMBO_HEIGHT;
	_categorySize = _categoryCount * ASORGS_CategorySpacing;
	_spacingSize = (_lineCount) * ASORGS_ControlSpacing;
	_itemHeight = (_totalSpace - _categorySize - _spacingSize) / _lineCount;
	
	_y = safezoneY + ASORGS_TopMargin;// + ASORGS_ControlHeight + ASORGS_ControlSpacing;

	SHOWSHRUNK_ITEM(ASORGS_preset_label, 3);
	ENDSHRUNK_CATEGORY

	_presetbottom = _y - (ASORGS_CategorySpacing * 0.5);
	_presetborderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_presetBorder);
	_presetpos = ctrlPosition _presetborderControl;
	_presetpos set [1, safezoneY];
	_presetpos set [3, _presetbottom - safezoneY];
	_presetborderControl ctrlSetPosition _presetpos;

	_weapontop = _presetbottom;// - (ASORGS_CategorySpacing );//_y - (ASORGS_CategorySpacing * 0.5);

	//primary weapon is never hidden
	if(_showPrimaryWeapon) then {
		SHOWSHRUNK_ITEM(ASORGS_primary_label, 2)
	} else {
		if(_showPrimaryAddons) then {
			[ASORGS_primary_label, 2, _y, _itemHeight] call ASORGS_fnc_updateUIShowDisabled;
			ENDSHRUNK_ITEM
		} else {
			HIDE_ITEM(ASORGS_primary_label, 2)
		};
	};

	SHOWSHRUNK_MULTICOMBO_IF(ASORGS_primaryAmmo_label, _showPrimaryAddons, 5)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_primaryScope_label, _showPrimaryScope)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_primaryRail_label, _showPrimaryRail)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_primarySuppressor_label, _showPrimarySuppressor)

	if(_showPrimaryWeapon || _showPrimaryAddons || _showPrimaryScope || _showPrimaryRail || _showPrimarySuppressor) then {
		ENDSHRUNK_CATEGORY
	};
	//launcher is never hidden
	if(_showLauncher) then {
		SHOWSHRUNK_ITEM(ASORGS_launcher_label, 2)
	} else {
		if(_showLauncherAddons) then {
			[ASORGS_launcher_label, 2, _y, _itemHeight] call ASORGS_fnc_updateUIShowDisabled;
			ENDSHRUNK_ITEM
		} else {
			HIDE_ITEM(ASORGS_launcher_label, 2)
		};
	};
	SHOWSHRUNK_MULTICOMBO_IF(ASORGS_launcherAmmo_label, _showLauncherAddons, 5)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_launcherScope_label, _showLauncherScope)

	if(_showAnyLauncher) then {
		ENDSHRUNK_CATEGORY
	};
	//handgun is never hidden
	if(_showHandgun) then {
		SHOWSHRUNK_ITEM(ASORGS_handgun_label, 2)
	} else {
		if(_showHandgunAddons) then {
			[ASORGS_handgun_label, 2, _y, _itemHeight] call ASORGS_fnc_updateUIShowDisabled;
			ENDSHRUNK_ITEM
		} else {
			HIDE_ITEM(ASORGS_handgun_label, 2)
		};
	};
	//if no handgun weapon is selected then hide ammo
	//move label
	SHOWSHRUNK_MULTICOMBO_IF(ASORGS_handgunAmmo_label, _showHandgunAddons, 5)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_handgunScope_label, _showHandgunScope)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_handgunSuppressor_label, _showHandgunSuppressor)

	if(_showAnyHandgun) then {
		ENDSHRUNK_CATEGORY
	};
	SHOWSHRUNK_MULTICOMBOCAT_IF(ASORGS_grenade_label, _showGrenades, 5)
	SHOWSHRUNK_MULTICOMBOCAT_IF(ASORGS_explosives_label, _showExplosives, 5)
	SHOWSHRUNK_MULTICOMBOCAT_IF(ASORGS_extraammo_label, _showExtraAmmo, 5)

	if(_showExtraAttachments) then {
	//move label
		[ASORGS_extraattach_label, 1, _y, _itemHeight] call ASORGS_fnc_updateUIShow;
	} else {
		[ASORGS_extraattach_label, 1, _y] call ASORGS_fnc_updateUIHide;
	};
	_comboCount = 5;	
	_currentIDC = ASORGS_extraattach_label + 1;
	_previousIDC = ASORGS_extraattach_label + 1;
	for[{_t = 0}, {_t < _comboCount}, {_t = _t + 1}] do 
	{
		if(((_t > 0) && ((lbCurSel _previousIDC) == 0)) || !_showExtraAttachments) then {
			HIDE_ITEM(_currentIDC, 1)
		
		} else {
			SHOWSHRUNK_ITEM(_currentIDC, 1)
		};
		_previousIDC = _currentIDC;
		_currentIDC = _currentIDC + 10;
	};
	if(_showExtraAttachments) then {
		ENDSHRUNK_CATEGORY
	};

	_weaponbottom = _y - (ASORGS_CategorySpacing * 0.5);
	_weaponborderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_weaponsBorder);
	_wpnpos = ctrlPosition _weaponborderControl;
	_wpnpos set [1, _presetbottom];
	_wpnpos set [3, _weaponbottom - _presetbottom];
	_weaponborderControl ctrlSetPosition _wpnpos;

	if(_showAnyWeapons) then {
		_weaponborderControl ctrlShow true;
	} else {
		_weaponborderControl ctrlShow false;
	};
	//no uniform controls are ever hidden
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_uniform_label, _showUniform)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_headgear_label, _showHeadgear)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_vest_label, _showVest)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_backpack_label, _showBackpack)
	SHOWSHRUNK_SINGLEITEM_IF(ASORGS_goggles_label, _showGoggles)


	if(_showAnyUniform) then {
		ENDSHRUNK_CATEGORY
	};
	SHOWSHRUNK_SINGLEITEMCAT_IF(ASORGS_nightvision_label, _showNightvision)
	SHOWSHRUNK_SINGLEITEMCAT_IF(ASORGS_binoculars_label, _showBinoculars)
	SHOWSHRUNK_SINGLEITEMCAT_IF(ASORGS_insignia_label, _showInsignia)

	_uniformbottom = _y - (ASORGS_CategorySpacing * 0.5);
	_uniformborderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_uniformBorder);
	_unipos = ctrlPosition _weaponborderControl;
	_unipos set [1, _weaponbottom];
	_unipos set [3, _uniformbottom - _weaponbottom];
	_uniformborderControl ctrlSetPosition _unipos;
	if(_showAnyUniformOrOthers) then {
		_uniformborderControl ctrlShow true;
	} else {
		_uniformborderControl ctrlShow false;
	};
	SHOWSHRUNK_MULTICOMBOCAT_IF(ASORGS_medical_label, _showMedical, 20)
	SHOWSHRUNK_MULTICOMBOCAT_IF(ASORGS_misc_label, _showMisc, 5)

	_miscbottom = _y - (ASORGS_CategorySpacing * 0.5);
	_miscborderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_miscBorder);
	_miscpos = ctrlPosition _miscborderControl;
	_miscpos set [1, _uniformbottom];
	_miscpos set [3, _miscbottom - _uniformbottom];
	_miscborderControl ctrlSetPosition _miscpos;
	if(_showAnyMisc) then {
		_miscborderControl ctrlShow true;
	} else {
		_miscborderControl ctrlShow false;
	};

	for "_i" from ASORGS_equipped_label to ASORGS_watch_combo do {
		_control = ASORGS_getControl(ASORGS_Main_Display, _i);
		_controlPos = ctrlPosition _control;
		_controlpos set [1, _y];
		_control ctrlSetPosition _controlpos;
	};
	_equippedBorderControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_equippedBorder);
	_equippedPos = ctrlPosition _equippedBorderControl;
	_equippedPos set [1, _y - ASORGS_CategorySpacing * 0.5];
	_equippedBorderControl ctrlSetPosition _equippedPos;
	 _y = _y + BOX_COMBO_HEIGHT + ASORGS_ControlSpacing;

};
//now commit everything
_control = ASORGS_getControl(ASORGS_Main_Display,ASORGS_preset_label);
_control ctrlCommit 0.1;
_control = ASORGS_getControl(ASORGS_Main_Display,ASORGS_preset_label+1);
_control ctrlCommit 0.1;
_control = ASORGS_getControl(ASORGS_Main_Display,ASORGS_preset_label+2);
_control ctrlCommit 0.1;
//lines with 2 controls
{
	_control = ASORGS_getControl(ASORGS_Main_Display,_x);
	_control ctrlCommit 0.1;
	_control = ASORGS_getControl(ASORGS_Main_Display,_x+1);
	_control ctrlCommit 0.1;
} forEach [ASORGS_primary_label, ASORGS_primaryScope_label, ASORGS_primaryRail_label, ASORGS_primarySuppressor_label, ASORGS_launcher_label, ASORGS_launcherScope_label, ASORGS_handgun_label, ASORGS_handgunScope_label, ASORGS_handgunSuppressor_label, ASORGS_uniform_label, ASORGS_headgear_label, ASORGS_vest_label,ASORGS_backpack_label, ASORGS_binoculars_label, ASORGS_nightvision_label, ASORGS_goggles_label, ASORGS_extraattach_label, ASORGS_insignia_label];

//individual controls
{
	_control = ASORGS_getControl(ASORGS_Main_Display,_x);
	_control ctrlCommit 0.1;
} forEach [ASORGS_extraattach2_combo,ASORGS_extraattach3_combo,ASORGS_extraattach4_combo,ASORGS_extraattach5_combo];
//multicombos
{
	private["_i", "_t", "_control", "_currentIDC"];
	_control = ASORGS_getControl(ASORGS_Main_Display,_x);
	_control ctrlCommit 0.1;
	_comboCount = 5;	
	if(_x == ASORGS_medical_label) then {
		_comboCount = 20;
	};

	_currentIDC = _x + 1;
	for[{_t = 0}, {_t < _comboCount}, {_t = _t + 1}] do 
	{
		for[{_i = 0}, {_i < ASORGS_MultiComboControls}, {_i = _i + 1}] do {
			_control = ASORGS_getControl(ASORGS_Main_Display,_currentIDC + _i);
			_control ctrlCommit 0.1;
		};
		_currentIDC = _currentIDC + 10;
	};
} forEach [ASORGS_grenade_label, ASORGS_explosives_label, ASORGS_medical_label, ASORGS_misc_label, ASORGS_extraammo_label, ASORGS_handgunAmmo_label, ASORGS_launcherAmmo_label, ASORGS_primaryAmmo_label];

for "_i" from ASORGS_equipped_label to ASORGS_watch_combo do {
	_control = ASORGS_getControl(ASORGS_Main_Display, _i);
	_control ctrlCommit 0.1;
};
_weaponborderControl ctrlCommit 0.1;
_uniformborderControl ctrlCommit 0.1;
_miscborderControl ctrlCommit 0.1;
_miscborderControl ctrlCommit 0.1;
_presetborderControl ctrlCommit 0.1;
_equippedBorderControl ctrlCommit 0.1;