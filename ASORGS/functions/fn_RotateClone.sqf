if(ASORGS_Rotating) then {
	ASORGS_Clone setDir ((getDir ASORGS_Clone) +  (_this select 1) * 10);
};
if(ASORGS_MovingY) then {
	ASORGS_CurrentY = ASORGS_CurrentY + ((_this select 2)* 0.01);
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

};