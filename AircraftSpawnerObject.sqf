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






// -- from ClaudeAI
// Create the info stand terminal
_terminal = "Land_InfoStand_V2_F" createVehicle [position player select 0, (position player select 1) + 2, 0];

// Add action menu items when in proximity and looking at terminal
_actionID1 = _terminal addAction ["<t color='#4CAF50'>Menu_item_1</t>", {
    hint "Menu item 1 selected";
}, nil, 6, true, true, "", "(_this distance _target < 3) && {cursorObject == _target}"]; 

_actionID2 = _terminal addAction ["<t color='#2196F3'>Menu_item_2</t>", {
    hint "Menu item 2 selected";
}, nil, 5, true, true, "", "(_this distance _target < 3) && {cursorObject == _target}"];

_actionID3 = _terminal addAction ["<t color='#FFC107'>Menu_item_3</t>", {
    hint "Menu item 3 selected";
}, nil, 4, true, true, "", "(_this distance _target < 3) && {cursorObject == _target}"];

_actionID4 = _terminal addAction ["<t color='#9C27B0'>Menu_item_4</t>", {
    hint "Menu item 4 selected";
}, nil, 3, true, true, "", "(_this distance _target < 3) && {cursorObject == _target}"];

// Key parts of this code ^^ ^^:

// We create a Land_InfoStand_V2_F object 2 meters in front of the player
// We use the addAction command to add scroll-wheel menu items

// Each item has:
//  - A display name (with color for better visibility)
//  - A simple script to execute when selected (currently just a hint)
//  - Priority values (6,5,4,3) that determine the order of menu items
//  - A condition string that makes the action only appear when:
//  - - The player is within 3 meters of the terminal
//  - - The player is looking directly at the terminal (cursorObject check)

// To use this in your mission, you could:
//  - Put this in an init.sqf file
//  - Use it in a trigger's activation field
//  - Place it in a script file that's executed when needed

// You can replace the hint commands with whatever functionality you want each menu item to perform once you're ready to implement the actual features.