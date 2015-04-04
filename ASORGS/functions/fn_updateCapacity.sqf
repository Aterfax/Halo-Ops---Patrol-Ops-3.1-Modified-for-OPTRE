#include "macro.sqf"
disableSerialization;
call ASORGS_fnc_UpdateWeight;
/*_uniformCombo = ASORGS_getControl(ASORGS_Main_Display, ASORGS_uniform_combo);
_uniformIndex = _uniformCombo lbValue (lbCurSel _uniformCombo);
if(_uniformIndex <= -1) then {
	ASORGS_UniformCapacity = 0;
	ASORGS_UniformFilled = 0;
} else { 
	ASORGS_UniformCapacity = (ASORGS_DB select DB_Uniforms select _uniformIndex select DBF_Capacity);
	ASORGS_UniformFilled = (loadUniform ASORGS_Player) * ASORGS_UniformCapacity;
};

_vestCombo = ASORGS_getControl(ASORGS_Main_Display, ASORGS_vest_combo);
_vestIndex = _vestCombo lbValue (lbCurSel _vestCombo); 
if(_vestIndex <= -1) then {
	ASORGS_VestCapacity = 0;
	ASORGS_VestFilled = 0;
} else { 
	ASORGS_VestCapacity = (ASORGS_DB select DB_Vests select _vestIndex select DBF_Capacity);
	ASORGS_VestFilled = (loadVest ASORGS_Player) * ASORGS_VestCapacity;
};

_backpackCombo = ASORGS_getControl(ASORGS_Main_Display, ASORGS_backpack_combo);
_backpackIndex = _backpackCombo lbValue (lbCurSel _backpackCombo); 
if(_backpackIndex <= -1) then {
	ASORGS_BackpackCapacity = 0;
	ASORGS_BackpackFilled = 0;
} else { 
	ASORGS_BackpackCapacity = (ASORGS_DB select DB_Backpacks select _backpackIndex select DBF_Capacity);
	ASORGS_BackpackFilled = (loadBackpack ASORGS_Player) * ASORGS_BackpackCapacity;
};
*/
//_dbfFitCounts = [];
{	_labelIDC = _x select 0;
	_db = _x select 1;
	_comboCount = 5;
	if(_labelIDC == ASORGS_medical_label) then {
		_comboCount = 20;
	};
	_comboIDC = _labelIDC + 1;
	for[{_i = 0}, {_i < _comboCount}, {_i = _i + 1}] do {
		_combo = ASORGS_getControl(ASORGS_Main_Display, _comboIDC);
		_index = -1;
		if((lbCurSel _combo) > 0) then {
			_index = _combo lbValue (lbCurSel _combo);
		};
		_canFit = false;
		if(_index > -1) then { 
			_item = ASORGS_DB select _db select _index;
			if(_item call ASORGS_fnc_CanFit) then {
				_canFit = true;
			};
		};
		_plus = ASORGS_getControl(ASORGS_Main_Display, _comboIDC+3);
		_minus = ASORGS_getControl(ASORGS_Main_Display, _comboIDC+1);
		if(_canFit) then {
			_plus ctrlEnable true;
		} else {
			_plus ctrlEnable false;
		};
		_comboIDC = _comboIDC + 10;
		//_dbfFitCounts = _dbfFitCounts + [_fitAmount];
	};
} forEach [
[ASORGS_primaryAmmo_label, DB_Magazines], 
[ASORGS_launcherAmmo_label, DB_Magazines],
[ASORGS_handgunAmmo_label, DB_Magazines],
[ASORGS_explosives_label, DB_Explosives],
[ASORGS_grenade_label, DB_Throwable],
[ASORGS_misc_label, DB_Items],
[ASORGS_medical_label, DB_Medical],
[ASORGS_extraammo_label, DB_Magazines]];

_totalWidth = safezoneW * 0.34;
_uniformWidth = 0;
_vestWidth = 0;
_backpackWidth = 0;
_uniformpercent = 0;
_vestpercent = 0;
_backpackpercent = 0;
_totalCapacity = ASORGS_BackpackCapacity+ASORGS_VestCapacity+ASORGS_UniformCapacity;
_uniformControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_capacityUniform);
_vestControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_capacityVest);
_backpackControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_capacityBackpack);
_uniformTTControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_capacityUniformTT);
_vestTTControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_capacityVestTT);
_backpackTTControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_capacityBackpackTT);

//hint format["%1/%2, %3/%4, %5/%6", ASORGS_UniformFilled, ASORGS_UniformCapacity, ASORGS_VestFilled, ASORGS_VestCapacity, ASORGS_BackpackFilled, ASORGS_BackpackCapacity];
_ypos = safezoneY+safezoneH-(1/25);

if(_totalCapacity > 0) then {
	if(ASORGS_UniformCapacity > 0) then {
		if(ASORGS_UniformFilled > 0) then {
			_uniformpercent = ASORGS_UniformFilled / ASORGS_UniformCapacity;
		};
		_uniformWidth = _totalWidth * (ASORGS_UniformCapacity/_totalCapacity);
	};
	if(ASORGS_VestCapacity > 0) then {
		if(ASORGS_VestFilled > 0) then {
			_vestpercent = ASORGS_VestFilled / ASORGS_VestCapacity;
		};
		_vestWidth = _totalWidth * (ASORGS_VestCapacity/_totalCapacity);
	};
	if(ASORGS_BackpackCapacity > 0) then {
		if(ASORGS_BackpackFilled > 0) then {
			_backpackpercent = ASORGS_BackpackFilled / ASORGS_BackpackCapacity;
		};
		_backpackWidth = _totalWidth * (ASORGS_BackpackCapacity/_totalCapacity);
	};
	_uniformControl ctrlSetPosition [safezoneX, _ypos, _uniformWidth, (1/25)];
	_uniformTTControl ctrlSetPosition [safezoneX, _ypos, _uniformWidth, (1/25)];
	_uniformTTControl ctrlSetTooltip format["Uniform Capacity: %1/%2", ASORGS_UniformFilled, ASORGS_UniformCapacity];
	_vestControl ctrlSetPosition [safezoneX + _uniformWidth, _ypos, _vestWidth, (1/25)];
	_vestTTControl ctrlSetPosition [safezoneX + _uniformWidth, _ypos, _vestWidth, (1/25)];
	_vestTTControl ctrlSetTooltip format["Vest Capacity: %1/%2", ASORGS_VestFilled, ASORGS_VestCapacity];
	_backpackControl ctrlSetPosition [safezoneX + _uniformWidth + _vestWidth, _ypos, _backpackWidth, (1/25)];
	_backpackTTControl ctrlSetPosition [safezoneX + _uniformWidth + _vestWidth, _ypos, _backpackWidth, (1/25)];
	_backpackTTControl ctrlSetTooltip format["Backpack Capacity: %1/%2", ASORGS_BackpackFilled, ASORGS_BackpackCapacity];
	/*_backpackTTControl ctrlEnable false;
	_uniformTTControl ctrlEnable false;
	_vestTTControl ctrlEnable false;*/
	_backpackControl ctrlCommit 0.1;
	_vestControl ctrlCommit 0.1;
	_uniformControl ctrlCommit 0.1;	
	_backpackTTControl ctrlCommit 0.1;
	_vestTTControl ctrlCommit 0.1;
	_uniformTTControl ctrlCommit 0.1;	
	_uniformControl progressSetPosition _uniformpercent;
	_vestControl progressSetPosition _vestpercent;
	_backpackControl progressSetPosition _backpackpercent;
};
_weightControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_weightProgress);
_weightTTControl = ASORGS_getControl(ASORGS_Main_Display, ASORGS_weightTT);
_weightWidth = ASORGS_Weight / ASORGS_MaxMass;
_weightWidth = 1 min _weightWidth;
_weightControl progressSetPosition _weightWidth;
_weightTTControl ctrlSetTooltip format["Weight: %1/55kg", (round (ASORGS_Weight* 0.1 / 2.2)) , 55];

//diag_log format["%1", _dbfFitCounts];
//hint format["%1", _dbfFitCounts];
/*//works but probly slow
_backpack = backpack ASORGS_Player; 
if(_backpack == "") then {
	
} else {
	ASORGS_BackpackCapacity = getNumber(configFile >> "CfgVehicles" >> _backpack >> "maximumload");
	ASORGS_BackpackFilled = (loadBackpack ASORGS_Player) * ASORGS_BackpackCapacity;
};

if(_uniform == "") then {
	ASORGS_UniformCapacity = 0;
	ASORGS_UniformFilled = 0;
} else {
	_uniformSupply = getText(configFile >> "CfgWeapons" >> _uniform >> "ItemInfo" >> "containerClass"); 
	ASORGS_UniformCapacity = getNumber(configFile >> "CfgVehicles" >> _uniformSupply >> "maximumload");
	ASORGS_UniformFilled = (loadUniform ASORGS_Player) * ASORGS_UniformCapacity;
};
*/


