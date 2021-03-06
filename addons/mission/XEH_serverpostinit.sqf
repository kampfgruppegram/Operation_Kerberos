/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      Server Post-Init
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

// initialize rescuemarker
If ((getMarkerPos GVARMAIN(rescuemarker)) isEqualTo [0,0,0]) then {
    ERROR("No Rescue-Marker Found")
} else {
    [LINKFUNC(handleRescuePoint), 30, []] call CBA_fnc_addPerFrameHandler;
};

GVAR(allRespawnMarkerLocations) = [
    ([east] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x},
    ([west] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x},
    ([resistance] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x},
    ([civilian] call BIS_fnc_getRespawnMarkers)apply {getMarkerPos _x}
];

// events
[QEGVAR(mission,start_server),{
    GVAR(allRespawnMarkerLocations) = [
        ([east] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x},
        ([west] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x},
        ([resistance] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x},
        ([civilian] call BIS_fnc_getRespawnMarkers)apply {getMarkerPos _x}
    ];
}] call CBA_fnc_addEventHandler;


// rescue point events
[QFUNC(statemachine_increaseCounter), { _this call FUNC(statemachine_increaseCounter); deleteVehicle (_this select 0); }] call CBA_fnc_addEventHandler;
[QFUNC(statemachine_increaseCounterOne), { _this call FUNC(statemachine_increaseCounterOne); deleteVehicle (_this select 0); }] call CBA_fnc_addEventHandler;
[QFUNC(statemachine_increaseCounterTwo), { _this call FUNC(statemachine_increaseCounterTwo); deleteVehicle (_this select 0); }] call CBA_fnc_addEventHandler;
[QFUNC(mainmission_prototype_rescued), { _this call FUNC(mainmission_prototype_rescued); deleteVehicle (_this select 0); }] call CBA_fnc_addEventHandler;

// initialize missions
If ((getMissionConfigValue ["isKerberos", 0]) > 0) then {
    [] spawn {
        SCRIPTIN(XEH_SERVERPOSTINIT,mission_init);
        waitUntil {!isNil QEGVAR(worlds,isInitialized)};
        GVAR(taskCounter) = 0;
        [ConfigFile >> "CfgKerberos" >> QGVAR(statemachine_Taskmanager)] call CBA_statemachine_fnc_createFromConfig;
        uiSleep 30;
        //uiSleep 5;
        [] call EFUNC(spawn,army_set);
        TRACEV_1(GVARMAIN(side_type));
        GVAR(missions) = [HASH_CREATE];
    };
};
