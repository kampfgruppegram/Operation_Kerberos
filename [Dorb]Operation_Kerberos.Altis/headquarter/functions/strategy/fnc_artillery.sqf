/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Attacks a position with mortar
 *
 *  Parameter(s):
 *      0 : LOCATION - Attacklocation
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params ["_attackLoc"];
TRACEV_1(_attackLoc);
private _pos = locationPosition _attackLoc;

private _nearPlayers = allPlayers select { ((_x distance pos)<300) && ((GVARMAIN(side) knowsAbout _x)>1) && (!((vehicle _x) isKindOf "Air")) };

private _amount = floor((_nearPlayers) max 10);

private _target = (selectRandom _nearPlayers);
private _targetDir = getDir _target;
private _targetPos = getPosATL _target;

[_targetPos,0,_amount] call FUNC(fdc_placeOrder);

_target;