/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the config of the component
 *
 */
#define CBA_OFF
#include "script_component.hpp"

class DOUBLES(CfgComponent,ADDON) {
    class preinit {};
    class postInitClient {server=0;};
    class dependencies {
        CfgPatches[] = {"acre_main"};
        CfgComponents[] = {"common","gui","gui_main"};
    };
};

#include "config\dialog.hpp"
