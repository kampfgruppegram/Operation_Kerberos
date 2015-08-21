/*
	Author: Dorbedo
	
	Description:
		initServer
*/
#include "script_component.hpp"
/*
[] call FM(userconfig);

If (DORB_RESERVED) then {
	["Pilots", "onPlayerConnected", {
		_this call FM(reserved_pilot);
	}] call BIS_fnc_addStackedEventHandler;
};
*/
waituntil{!isNil "DORB_RESPAWNMARKER"};

DORB_HEADLESS_EVENTHANDLER = [{ [] call dorb_fnc_headless } , 30, [] ] call CBA_fnc_addPerFrameHandler;

[] spawn FM(core);
[] spawn FM(ui_spawn_createlist);

_Krankenhaus = "Land_Medevac_HQ_V1_F" createVehicle (getMarkerPos "krankenhaus");
_Krankenhaus setDir (MarkerDir "Krankenhaus");
_Krankenhaus enableSimulation false;
SETPVAR(_Krankenhaus,ace_medical_isMedicalFacility, true);

#ifdef DORB_PILOT_WHITELIST_ENABLED
	[] call DORB_fnc_userconfig;
#endif
