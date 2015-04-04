 
ASORGS_Player cameraEffect ["terminate","back"];
camDestroy ASORGS_Camera;
BIS_DEBUG_CAM = nil;
detach ASORGS_Clone;
deleteVehicle ASORGS_Clone;
deleteVehicle ASORGS_Platform;
deleteVehicle ASORGS_Background;
deleteVehicle ASORGS_Light;
{ deleteVehicle _x;  } forEach ASORGS_Backgrounds;

deleteGroup ASORGS_Group;
deleteVehicle ASORGS_CameraTarget;
