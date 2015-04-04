private ["_side","_ammobox"];

_side = _this select 0;
if !([player,_side] call PO3_fnc_checkObjCondition) exitWith {};

_ammobox = _this select 2;
/* Commented out to prevent removal of TEI weapons.
clearMagazineCargo _ammobox;
clearWeaponCargo _ammobox;
clearItemCargo _ammobox;
clearBackpackCargo _ammobox;
*/
[_ammobox] spawn PO3_fnc_fillSupplybox;