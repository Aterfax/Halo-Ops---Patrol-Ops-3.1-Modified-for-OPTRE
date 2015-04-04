disableSerialization;
if(isNil '_this') then {
	ASORGS_Player = player;
 } else {
	ASORGS_Player = [_this, 0, player, [objNull]] call BIS_fnc_Param;
	_isclass = isClass (configFile >> "cfgVehicles" >> (typeOf ASORGS_Player));
	if (_isClass) then {
		_type = getText(configFile >> "cfgVehicles" >> (typeOf ASORGS_Player) >> "vehicleClass");
		if(_type != "Men") then {ASORGS_Player = player; };
	} else {
		ASORGS_Player = player;
	};
};
if(!isNil 'ASORGS_loading_preset' ) exitWith {hint "Still applying gear. Please wait before reopening Gear Selector.";};

ASORGS_FirstLoad = true;
ASORGS_CurrentInventory = call ASORGS_fnc_getGearArray;
ASORGS_BackpackCapacityChanged = true;
ASORGS_VestCapacityChanged = true;
ASORGS_UniformCapacityChanged = true;
ASORGS_WeightChanged = true;
ASORGS_UniformCapacity = 0;
ASORGS_BackpackCapacity = 0;
ASORGS_VestCapacity = 0;
ASORGS_UniformFilled = 0;
ASORGS_BackpackFilled = 0;
ASORGS_VestFilled = 0;
[] call ASORGS_fnc_CameraStart;
createDialog "ASORGS_Main_Dialog";


