#include "macro.sqf"
ASORGS_Rotating = false;
ASORGS_MovingY = false;
_distancex = .7;
_distancey = 5;
_height = 3;
_fov = .3;
_bgTexture = "#(rgb,8,8,3)color(0,0,0,1)";
_heightInAir = 50;
_platformOffset =2;
ASORGS_Position = [(random -1400), (random -1400), 0];


_seaHeight =  0 max ((ASLtoATL ASORGS_Position) select 2);
ASORGS_Platform = "FlagChecked_F" createVehicleLocal ASORGS_Position;
ASORGS_Platform setPosATL [ASORGS_Position select 0, (ASORGS_Position select 1), _seaHeight + _heightInAir - 20];
//hideObject ASORGS_Platform;

_logo = ASORGS_BackgroundLogo;
_playerinsignia = (ASORGS_Player call BIS_fnc_getUnitInsignia);
if(ASORGS_UnitInsigniaAsBackground && (_playerinsignia != "")) then {
	_logo = getText (configFile >> "CfgUnitInsignia" >> _playerinsignia >> "texture");
};

ASORGS_Background = "UserTexture10m_F" createVehicleLocal [0,0,0];
ASORGS_Background setPosATL [(ASORGS_Position select 0) + .55, (ASORGS_Position select 1) - 18.9, _seaHeight + 3  + _heightInAir];
ASORGS_Background setDir 180;
ASORGS_Background setObjectTexture [0, _logo];
//hideObject ASORGS_Floor;

_bgCountX = 9;
_bgCountY = 3;
_bgLeft = -(_bgCountX * 0.5) * 10;
_bgTop = -(_bgCountY * 0.5) * 10;
ASORGS_Backgrounds = [];
for[{_bgX = 0}, {_bgX < _bgCountX}, {_bgX = _bgX + 1}] do {
	for[{_bgY = 0}, {_bgY < _bgCountY}, {_bgY = _bgY + 1}] do {
		_bg = "UserTexture10m_F" createVehicleLocal [0,0,0];
		_bg setPosATL [(ASORGS_Position select 0) + _bgLeft + (_bgX * 10), (ASORGS_Position select 1) -19, _seaHeight + _heightInAir  + _bgTop + (_bgY * 10)];
		_bg setDir 180;
		_bg setObjectTexture [0,_bgTexture];
		_bg enableSimulation false;
		ASORGS_Backgrounds set [count ASORGS_Backgrounds, _bg];
	};
};
for[{_bgX = 0}, {_bgX < _bgCountX}, {_bgX = _bgX + 1}] do {
	for[{_bgY = 0}, {_bgY < _bgCountY}, {_bgY = _bgY + 1}] do {
		_bg = "UserTexture10m_F" createVehicleLocal [0,0,0];
		_bg setPosATL [(ASORGS_Position select 0) + _bgLeft + (_bgX * 10), (ASORGS_Position select 1) -18.95, _seaHeight + _heightInAir  + _bgTop + (_bgY * 10)];
		_bg setDir 180;
		_bg setObjectTexture [0,ASORGS_BackgroundTile];
		_bg enableSimulation false;
		ASORGS_Backgrounds set [count ASORGS_Backgrounds, _bg];
	};
};

ASORGS_Group = createGroup side ASORGS_Player;
_clonepos = [ASORGS_Position select 0, ASORGS_Position select 1, _seaHeight+2 + _heightInAir];
ASORGS_Clone = ASORGS_Group createUnit [typeOf ASORGS_Player, _clonepos, [], 0, "CAN_COLLIDE"];
ASORGS_Clone setFace face ASORGS_Player;
ASORGS_Clone setPosATL _clonepos;
ASORGS_Clone disableAI "MOVE";
removeAllAssignedItems ASORGS_Clone;
ASORGS_Clone attachTo [ASORGS_Platform, [0,0,21]];
ASORGS_Group setBehaviour "CARELESS";
[] spawn ASORGS_fnc_ResetClone;
//ASORGS_Clone enableSimulation false;
_pos = ASORGS_Position; 
/*
ASORGS_OriginalPos = position ASORGS_Player;

"BlockConcrete_F" createVehicleLocal  _pos;
ASORGS_Player setPos [_pos select 0, _pos select 1, 3]; 
ASORGS_Player setDir 0; 
ASORGS_Player action ["WeaponOnBack", ASORGS_Player];  
*/
_cameraTarget = [(_pos select 0) + _distancex, (_pos select 1) , _seaHeight+3 + _heightInAir];
_cameraPos = [(_pos select 0) + _distancex, (_pos select 1)+ _distancey, _seaHeight+3 + _heightInAir];
ASORGS_CameraTarget = "LOGIC" createVehicleLocal _cameraTarget;
ASORGS_CameraTarget setPosATL _cameraTarget;

sleep 0.1;
ASORGS_Camera = "camera" camCreate _cameraPos;
 ASORGS_Camera cameraEffect ["internal", "back"];
ASORGS_Camera camPrepareTarget ASORGS_CameraTarget;
//ASORGS_Camera camPrepareRelPos [0,  -_distancey, 0 ];
ASORGS_Camera camPrepareFOV _fov;
showCinemaBorder false;
ASORGS_Camera setPosATL _cameraPos;
ASORGS_Camera camCommitPrepared 0;


ASORGS_CameraPosMinZoom = _cameraPos;
ASORGS_CameraPosMaxZoom = [_cameraPos, ASORGS_Position, 0.7] call ASORGS_fnc_vectorLerp;
ASORGS_CameraTargetMinZoom = _cameraTarget;
ASORGS_CameraTargetMaxZoom = _cameraTarget vectorAdd (ASORGS_CameraPosMaxZoom vectorDiff ASORGS_CameraPosMinZoom );
ASORGS_CameraMinY = _seaHeight+ 2.5 + _heightInAir;
ASORGS_CameraMaxY = _seaHeight+3.5 + _heightInAir;
ASORGS_CurrentZoom = 0;
ASORGS_CurrentY = ((_cameraPos select 2) - ASORGS_CameraMinY) / (ASORGS_CameraMaxY - ASORGS_CameraMinY);
ASORGS_Light = "#lightpoint" createVehicleLocal _cameraPos;
ASORGS_Light setPosATL _cameraPos;
_brightness = 1;
if(worldName in ASORGS_brightMaps) then {
	_brightness = 0.3; };
	
ASORGS_Light setLightBrightness _brightness;
ASORGS_Light setLightAmbient[1,1,1];
ASORGS_Light setLightColor[1,1,1];
BIS_DEBUG_CAM = true;

ASORGS_RotateDirection = 0;
/*
while {ASORGS_Open} do {
	if(ASORGS_RotateDirection != 0) then {
		ASORGS_Clone setDir (getDir ASORGS_Clone + ASORGS_RotateDirection); 
	};
	sleep 0.05;
};*/