// references: 
// https://community.bistudio.com/wiki/Object;
// https://community.bistudio.com/wiki/createVehicle
// https://community.bistudio.com/wiki/setVehiclePosition
// https://community.bistudio.com/wiki/Arma_3:_Simple_Objects
// https://community.bistudio.com/wiki/createSimpleObject
// https://community.bistudio.com/wiki/BIS_fnc_spawnObjects
// https://github.com/MisterHLunaticwraith/MRHMilsimTools/tree/master/Addons/MRHVehicleSpawner - to reference for deleting objects within the spawner location;

// ex. introduction to board:
// board1 addAction ["Spawn Vehicle","scripts\veh.sqf"]
// _veh = "vehicle_classname" createVehicle getMarkerPos "marker_name";  // "marker_name" replace with named location variable (i.e. "helipad_01" - use an invisible helipad marker)

// ex. generic SIMPLE spawn of a vehicle (CAUTION: SIMPLE OBJECT!!):
// _pos = player getRelPos [10, 0];
// createSimpleObject ["B_APC_Tracked_01_CRV_F", AGLToASL _pos];

// may be worth checking "Land_HelipadEmpty_F";

// ex. generic spawn of a vehicle:
// To avoid vehicle randomisation in Arma 3, set the BIS_enableRandomization variable immediately after creating the vehicle:
	// private _vehicle;
	// isNil { // run unscheduled
	// 	_vehicle = "C_Offroad_01_F" createVehicle getPosATL player;
	// 	_vehicle setVariable ["BIS_enableRandomization", false];
	// };
// // the _vehicle variable is available after that


private _helipadSpawnMarker = "Land_HelipadEmpty_F" createVehicle position player; 
private _helipadPos = getPosATL _helipadSpawnMarker;

// Now, spawn the vehicle at the position of the helipad
private _vehicle = "C_Offroad_01_F" createVehicle _helipadPos;\

// ----------

private _helipadSpawnMarker = "Land_HelipadEmpty_F" createVehicle position player;  
private _helipadPos = getPosATL _helipadSpawnMarker; 
 
hint format ["Helipad position: %1", _helipadPos];

// --- try this object instead:
"Land_HelipadEmpty_F"

// --- this correctly spawns a truck on the "helipad01" point that was pre-created in the mission-file:
"C_Offroad_01_F" createVehicle getPosATL helipad01;
"B_Heli_Transport_01_F" createVehicle getPosATL helipad01;

//these in the "init" block of the spawnerObject is causing an error (because it is getting code in [1] instead of the expected "string" of an abstraction "path"):
// testing adding scrollwheel item (object VariableName "computerSpawner"):
// computerSpawner addAction ["Spawn GhostHawk", "B_Heli_Transport_01_F" createVehicle getPosATL helipad01]

// also valid:
// computerSpawner addAction ["Spawn GhostHawk", ("B_Heli_Transport_01_F" createVehicle getPosATL helipad01)];