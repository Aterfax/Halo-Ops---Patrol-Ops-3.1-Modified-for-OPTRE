#include "macro.sqf"
_itemMass = _this select 0;
_backpackFitCount = 0;
_vestFitCount = 0;
_uniformFitCount = 0;
//check how many more will fit in uniform
_uniformSpace = ASORGS_UniformCapacity - ASORGS_UniformFilled;
if(_uniformSpace > 0) then {
_uniformFitCount = floor (_uniformSpace / _itemMass); };

_vestSpace = ASORGS_VestCapacity - ASORGS_VestFilled;
if(_vestSpace > 0) then {
_vestFitCount = floor (_vestSpace / _itemMass); };

_backpackSpace = ASORGS_BackpackCapacity - ASORGS_BackpackFilled;
if(_backpackSpace > 0) then {
_backpackFitCount = floor (_backpackSpace / _itemMass); };

//hint format["%1, %2, %3", _uniformSpace, _backpackSpace, _vestSpace];
(_vestFitCount + _backpackFitCount + _uniformFitCount)

