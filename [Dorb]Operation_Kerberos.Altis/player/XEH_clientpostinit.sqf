/*
    Author: Dorbedo
    
    Description:
        postinit client
*/
#include "script_component.hpp"

[] call FUNC(playeraddaction);
[] call FUNC(addbriefing);
[] call FUNC(halo_addaction);
[] call FUNC(backpack_init);
[] call FUNC(EH_respawn);

["init"] spawn FUNC(grouptracker);