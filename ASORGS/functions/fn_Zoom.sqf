ASORGS_CurrentZoom = ASORGS_CurrentZoom + ((_this select 1)* 0.05);
ASORGS_CurrentZoom = 0 max ASORGS_CurrentZoom;
ASORGS_CurrentZoom = 1 min ASORGS_CurrentZoom;

ASORGS_CurrentY = (0.5 - ASORGS_CurrentZoom*0.5) max ASORGS_CurrentY;
ASORGS_CurrentY = (0.5 + ASORGS_CurrentZoom*0.5) min ASORGS_CurrentY;
	
_cameraPos = [ASORGS_CameraPosMinZoom, ASORGS_CameraPosMaxZoom, ASORGS_CurrentZoom] call ASORGS_fnc_vectorLerp;

_y = ASORGS_CameraMinY + ((ASORGS_CameraMaxY - ASORGS_CameraMinY) * ASORGS_CurrentY);
_cameraPos set [2, _y];
_cameraTarget = [ASORGS_CameraTargetMinZoom, ASORGS_CameraTargetMaxZoom, ASORGS_CurrentZoom]  call ASORGS_fnc_vectorLerp;
_cameraTarget set [2, _y];

ASORGS_Camera setPosATL _cameraPos;
ASORGS_CameraTarget setPosATL _cameraTarget;
ASORGS_Camera camCommitPrepared 0.2;

 