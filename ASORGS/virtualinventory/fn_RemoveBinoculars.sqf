#include "macro.sqf"
_binocs = call ASORGS_fnc_GetBinoculars;
_items = (ASORGS_CurrentInventory select GSVI_Items) - [_binocs];
ASORGS_CurrentInventory set [GSVI_Items, _items];
ASORGS_WeightChanged = true;