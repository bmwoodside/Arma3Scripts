// Create the info stand terminal dynamically - otherwise place manually in Eden Editor
_terminal = "Land_InfoStand_V2_F" createVehicle [position player select 0, (position player select 1) + 2, 0];

// scrollwheel actions for the terminal/spawner's "init" field:
this addAction ["<t color='#4CAF50'>Spawn Helicopter</t>", { 
    _terminal = _this select 0; 
 
    _allHelipads = nearestObjects [_terminal, ["Land_HelipadEmpty_F"], 100]; 
 
    if (count _allHelipads == 0) then { 
        hint "No helipad found within 100m!"; 
    } else { 
        _helipad = _allHelipads select 0; 
 
        _pos = getPosATL _helipad; 
        _exactPos = [_pos select 0, _pos select 1, _pos select 2];
        _dir = getDir _helipad;
 
        _nearbyVehicles = nearestObjects [_pos, ["Air", "LandVehicle", "Ship"], 10]; 
         
        if (count _nearbyVehicles > 0) then {
            _canClear = false;
            _emptyCraft = objNull;
            
            // Check if there's an empty aircraft
            {
                if (_x isKindOf "Air" && {count crew _x == 0}) then {
                    _canClear = true;
                    _emptyCraft = _x;
                };
            } forEach _nearbyVehicles;
            
            if (_canClear && !isNull _emptyCraft) then {
                // Delete the empty aircraft
                deleteVehicle _emptyCraft;
                
                // Slight delay for engine to process deletion
                [_exactPos, _dir] spawn {
                    params ["_spawnPos", "_spawnDir"];
                    sleep 0.1;
                    
                    // Force exact position and prevent collision detection during spawn
                    _heli = createVehicle ["B_Heli_Transport_01_F", [0,0,0], [], 0, "CAN_COLLIDE"];
                    _heli setPosATL _spawnPos;
                    _heli setDir _spawnDir;
                };
                
                hint "Removed empty aircraft and spawned new helicopter at helipad.";
            } else {
                hint "Cannot spawn helicopter! Landing zone is not clear.";
            };
        } else { 
            // No nearby vehicles, direct spawn
            _heli = createVehicle ["B_Heli_Transport_01_F", _exactPos, [], 0, "CAN_COLLIDE"];
            _heli setDir _dir;
            
            hint "Helicopter spawned at helipad."; 
        }; 
    };
}, nil, 6, true, true, "", "(_this distance _target < 3) && {cursorObject == _target}"];

//without comments (so you can save the object in-game!)
this addAction ["<t color='#4CAF50'>Spawn Helicopter</t>", {  
    _terminal = _this select 0;  
  
    _allHelipads = nearestObjects [_terminal, ["Land_HelipadEmpty_F"], 100];  
  
    if (count _allHelipads == 0) then {  
        hint "No helipad found within 100m!";  
    } else {  
        _helipad = _allHelipads select 0;  
  
        _pos = getPosATL _helipad;  
        _exactPos = [_pos select 0, _pos select 1, _pos select 2]; 
        _dir = getDir _helipad; 
  
        _nearbyVehicles = nearestObjects [_pos, ["Air", "LandVehicle", "Ship"], 10];  
          
        if (count _nearbyVehicles > 0) then { 
            _canClear = false; 
            _emptyCraft = objNull; 
             
            { 
                if (_x isKindOf "Air" && {count crew _x == 0}) then { 
                    _canClear = true; 
                    _emptyCraft = _x; 
                }; 
            } forEach _nearbyVehicles; 
             
            if (_canClear && !isNull _emptyCraft) then { 
                deleteVehicle _emptyCraft; 
                 
                [_exactPos, _dir] spawn { 
                    params ["_spawnPos", "_spawnDir"]; 
                    sleep 0.1; 
                     
                    _heli = createVehicle ["B_Heli_Transport_01_F", [0,0,0], [], 0, "CAN_COLLIDE"]; 
                    _heli setPosATL _spawnPos; 
                    _heli setDir _spawnDir; 
                }; 
                 
                hint "Removed empty aircraft and spawned new helicopter at helipad."; 
            } else { 
                hint "Cannot spawn helicopter! Landing zone is not clear."; 
            }; 
        } else {  
            _heli = createVehicle ["B_Heli_Transport_01_F", _exactPos, [], 0, "CAN_COLLIDE"]; 
            _heli setDir _dir; 
             
            hint "Helicopter spawned at helipad.";  
        };  
    }; 
}, nil, 6, true, true, "", "(_this distance _target < 3) && {cursorObject == _target}"];


// other action menus to use for colors later
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