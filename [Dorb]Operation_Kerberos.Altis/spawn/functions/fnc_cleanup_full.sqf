/*
    Author: Dorbedo

    Description:
    Big Cleanup

*/
#include "script_component.hpp"
_this params ["_pos","_rad"];
TRACEV_2(_pos,_rad);
[] call FUNC(cleanup_base);

private _objectsToDelete = [];

{
    _objectsToDelete pushBackUnique _x;
} foreach (_pos nearObjects ["ALL", _rad]);

{
    _objectsToDelete pushBackUnique _x;
} forEach allMines;

{
    if (side _x != GVARMAIN(playerside) ) then {
        _objectsToDelete pushBackUnique _x;
    };
} foreach allunits;

{
    if (!(alive _x)) then {
        _objectsToDelete pushBackUnique _x;
    };
} foreach vehicles;

{
    _objectsToDelete pushBackUnique _x;
} forEach allDead;

{
    _x call EFUNC(common,delete);
} foreach allGroups;

{
    _x call EFUNC(common,delete);
} foreach (missionNamespace getVariable [QGVAR(cleanUpDump),[]]);
GVAR(cleanUpDump) = [];

[
    {
        _this call EFUNC(common,delete);
    },
    [_objectsToDelete],
    10
] call CBA_fnc_waitAndExecute;

[] call EFUNC(common,debug_marker_clean);

ISNILS(EGVAR(mission,markerdump),[]);
EGVAR(mission,markerdump) TILGE;