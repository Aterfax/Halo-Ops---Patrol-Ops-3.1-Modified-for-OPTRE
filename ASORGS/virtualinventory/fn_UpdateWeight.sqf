private ["_capacity", "_backpack", "_currentWeight", "_uniform", "_vest", "_containerClass", "_weight"];
#include "macro.sqf"
if(ASORGS_BackpackCapacityChanged) then {
	_capacity = 0;
	_backpack = (ASORGS_CurrentInventory select GSVI_Backpack);
	if(_backpack != "") then {
		_capacity = getNumber(configFile >> "CfgVehicles" >> _backpack >> "maximumLoad");
	};
	_currentWeight = 0;
	{
		_currentWeight = _currentWeight + (_x call ASORGS_fnc_GetItemMass);
	} forEach (ASORGS_CurrentInventory select GSVI_BackpackItems);
	ASORGS_BackpackCapacity = _capacity;
	ASORGS_BackpackFilled = _currentWeight;
	ASORGS_BackpackCapacityChanged = false;
};

if(ASORGS_VestCapacityChanged) then {
	_capacity = 0;
	_vest = (ASORGS_CurrentInventory select GSVI_Vest);
	if(_vest != "") then {
		_containerClass = getText (configFile >> "cfgWeapons" >> _vest >> "ItemInfo" >> "ContainerClass");
		_capacity = getNumber(configFile >> "CfgVehicles" >> _containerClass >> "maximumLoad");
	};
	_currentWeight = 0;
	{
		_currentWeight = _currentWeight + (_x call ASORGS_fnc_GetItemMass);
	} forEach (ASORGS_CurrentInventory select GSVI_VestItems);
	ASORGS_VestCapacity = _capacity;
	ASORGS_VestFilled = _currentWeight;
	ASORGS_VestCapacityChanged = false;
};

if(ASORGS_UniformCapacityChanged) then {
	_capacity = 0;
	_uniform = (ASORGS_CurrentInventory select GSVI_Uniform);
	if(_uniform != "") then {
		_containerClass = getText (configFile >> "cfgWeapons" >> _uniform >> "ItemInfo" >> "ContainerClass");
		_capacity = getNumber(configFile >> "CfgVehicles" >> _containerClass >> "maximumLoad");
	};
	_currentWeight = 0;
	{
		_currentWeight = _currentWeight + (_x call ASORGS_fnc_GetItemMass);
	} forEach (ASORGS_CurrentInventory select GSVI_UniformItems);
	ASORGS_UniformCapacity = _capacity;
	ASORGS_UniformFilled = _currentWeight;
	ASORGS_UniformCapacityChanged = false;
};

if (ASORGS_WeightChanged) then {
	_weight = ASORGS_UniformFilled + ASORGS_VestFilled + ASORGS_BackpackFilled;
	for [{_i = 1}, {_i < GSVI_Insignia}, {_i = _i + 1}] do {
		if((_i != GSVI_VestItems) && (_i != GSVI_BackpackItems) && (_i != GSVI_UniformItems)) then {
			_items = ASORGS_CurrentInventory select _i;
			switch(typeName _items) do {
				case "ARRAY" : {
					{ _weight = _weight + (_x call ASORGS_fnc_GetItemMass); } forEach _items;
				};
				case "STRING" : {
					 _weight = _weight + (_items call ASORGS_fnc_GetItemMass); 
				};
				default {
					format ["Error - item in ASORGS_CurrentInventory select %1 isn't a string or array"] spawn ASORGS_fnc_Log;
				};
			};
		};
	};
	// http://play.withsix.com/arma-3/mods/bw-loadcalc/readme
	ASORGS_Weight = _weight;// * 0.1 / 2.2; max = 1200
	ASORGS_WeightChanged = false;
};