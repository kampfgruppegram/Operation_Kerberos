/**
 * Author: Dorbedo
 * interface for vehiclelist
 *
 * Arguments:
 * 0: <STRING> vehiclelist preset
 *
 * Return Value:
 * <ARRAY> array with classnames
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_presetName","",[""]]];

private _return = [];

switch (_presetName) do {
    case "vehicles_west" : {
        _blacklist = [
            "B_Static_Designator_01_F",
            "B_Radar_System_01_F",
            "RHS_Stinger_AA_pod_D",
            "B_G_Offroad_01_repair_F",
            "I_G_Offroad_01_AT_F",
            "RHS_M119_D",
            "RHS_M252_D",
            "RHS_M2StaticMG_D",
            "RHS_M2StaticMG_MiniTripod_D",
            "RHS_TOW_TriPod_D",
            "Redd_Milan_Static",
            "B_SAM_System_03_F",
            "B_static_AT_F",
            "B_static_AA_F",
            "RHS_MK19_TriPod_D",
            "B_SAM_System_02_F",
            "B_Ship_MRLS_01_F",
            "B_Ship_Gun_01_F",
            "B_SAM_System_01_F",
            "B_Mortar_01_F",
            "B_AAA_System_01_F",
            "ACE_B_SpottingScope",
            "C_Van_01_fuel_F",
            "C_Van_02_vehicle_F",
            "C_Van_02_transport_F",
            "C_Van_01_transport_F"
        ];
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==1}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = (_return select { !((configName _x) in _blacklist) }) apply {configName _x};
    };
    case "vehicles_west_public" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==1}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Car')})", true];
        _return = _return apply {configName _x};
        _return append ["I_MRAP_03_F","I_MRAP_03_gmg_F","I_MRAP_03_hmg_F","I_LT_01_AT_F","I_LT_01_scout_F","I_LT_01_AA_F","I_LT_01_cannon_F"];
        _return = _return select {!((toLower _x) in ["b_sam_system_01_f","b_sam_system_02_f","b_aaa_system_01_f"])};
    };
    case "air_west" : {
        _blacklist = [
            "B_UAV_06_F",
            "B_UAV_06_medical_F",
            "B_UAV_01_F"
        ];
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==1}&&{((configName _x) isKindOf 'Air')})", true];
        _return = (_return select { !((configName _x) in _blacklist) }) apply {configName _x};
    };
    case "carrier_west" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==1}&&{((configName _x) isKindOf 'Air')})", true];
        _return = _return apply {configName _x};
        //_return = _return select {!((toLower _x) in ["rhs_a10","rhs_c130j","rhsusf_f22"])};
        _return pushBack "B_Quadbike_01_F";
        _return pushBack "O_Heli_Transport_04_black_F";
    };
    case "naval_west" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==1}&&{((configName _x) isKindOf 'Ship')})", true];
        _return = _return apply {configName _x};
    };
    case "logistic_1_west" : {
        _blacklist = [
            "C_Van_01_transport_F",
            "C_Van_01_fuel_F",
            "C_Van_02_vehicle_F",
            "C_Van_02_transport_F",
            "B_Truck_01_mover_F",
            "rhsusf_M1078A1P2_WD_fmtv_usarmy",
            "rhsusf_M1083A1P2_WD_fmtv_usarmy",
            "rhsusf_M1084A1P2_WD_fmtv_usarmy",
            "rhsusf_M1078A1P2_D_fmtv_usarmy",
            "rhsusf_M1083A1P2_D_fmtv_usarmy",
            "rhsusf_M1084A1P2_D_fmtv_usarmy",
            "rhsusf_M1220_usarmy_d",
            "rhsusf_M1230_M2_usarmy_d",
            "rhsusf_M977A4_usarmy_wd",
            "rhsusf_M978A4_usarmy_wd",
            "rhsusf_M977A4_usarmy_d",
            "rhsusf_M978A4_usarmy_d"
        ];
        _return = (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{(configName _x) isKindOf 'StaticWeapon'}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})", true])
                + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})", true])
                + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Slingload_01_Base_F')||{((configName _x) isKindOf 'Pod_Heli_Transport_04_base_F')}})", true]);
        _return = (_return select { !((configName _x) in _blacklist) }) apply {configName _x};
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
        _return append ["Box_NATO_AmmoVeh_F"];
        _return arrayIntersect _return;
    };

    case "logistic_2_west" : {
        _blacklist = [
            "C_Van_01_transport_F",
            "C_Van_01_fuel_F",
            "C_Van_02_vehicle_F",
            "C_Van_02_transport_F",
            "B_Truck_01_mover_F",
            "rhsusf_M1078A1P2_WD_fmtv_usarmy",
            "rhsusf_M1083A1P2_WD_fmtv_usarmy",
            "rhsusf_M1084A1P2_WD_fmtv_usarmy",
            "rhsusf_M1078A1P2_D_fmtv_usarmy",
            "rhsusf_M1083A1P2_D_fmtv_usarmy",
            "rhsusf_M1084A1P2_D_fmtv_usarmy",
            "rhsusf_M1220_usarmy_d",
            "rhsusf_M1230_M2_usarmy_d",
            "rhsusf_M977A4_usarmy_wd",
            "rhsusf_M978A4_usarmy_wd",
            "rhsusf_M977A4_usarmy_d",
            "rhsusf_M978A4_usarmy_d"
        ];
        _return = (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{(configName _x) isKindOf 'StaticWeapon'}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})", true])
                + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==1}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})", true])
                + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Slingload_01_Base_F')||{((configName _x) isKindOf 'Pod_Heli_Transport_04_base_F')}})", true]);
        _return = (_return select { !((configName _x) in _blacklist) }) apply {configName _x};
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
        _return append ["Box_NATO_AmmoVeh_F"];
        _return arrayIntersect _return;
    };

    case "vehicles_east" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==0}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = _return apply {configName _x};
        _return = _return select {!((toLower _x) in ["rhs_9k79_b"])};
    };
    case "air_east" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==0}&&{((configName _x) isKindOf 'Air')})", true];
        _return = _return apply {configName _x};
    };
    case "naval_east" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==0}&&{((configName _x) isKindOf 'Ship')})", true];
        _return = _return apply {configName _x};
    };
    case "logistic_east" : {
        _return = (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{(getText(_x>>'vehicleClass')=='Static')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})", true])
                + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})", true])
                + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==0}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Slingload_01_Base_F')||{((configName _x) isKindOf 'Pod_Heli_Transport_04_base_F')}})", true]);
        _return = _return apply {configName _x};
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
        _return append ["Box_East_AmmoVeh_F"];
        _return = _return select {!((toLower _x) in ["rhs_9k79_b"])};
        _return arrayIntersect _return;
    };

    case "vehicles_resistance" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==2}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = _return apply {configName _x};
    };
    case "air_resistance" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==2}&&{((configName _x) isKindOf 'Air')})", true];
        _return = _return apply {configName _x};
    };
    case "air_resistance_public" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==2}&&{((configName _x) isKindOf 'Air')})", true];
        _return = _return apply {configName _x};
        //_return = _return select {!((toLower _x) in ["rhsgref_cdf_su25","rhs_l159_cdf","rhs_l39_cdf","rhs_an2","rhsgref_cdf_mig29s"])};
    };
    case "naval_resistance" : {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{getNumber(_x>>'side')==2}&&{((configName _x) isKindOf 'Ship')})", true];
        _return = _return apply {configName _x};
    };
    case "logistic_resistance" : {
        _return = (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{(getText(_x>>'vehicleClass')=='Static')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})", true])
                + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Truck_F')}&&{!(getText(_x>>'vehicleClass')=='Autonomous')})", true])
                + (configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'side')==2}&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Slingload_01_Base_F')||{((configName _x) isKindOf 'Pod_Heli_Transport_04_base_F')}})", true]);
        _return = _return apply {configName _x};
        private _ace = ["ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced","ACE_Box_Misc","ACE_Box_Ammo","ACE_Track","ACE_Wheel","ACE_Box_82mm_Mo_Combo","ACE_Box_82mm_Mo_HE","ACE_Box_82mm_Mo_Illum","ACE_Box_82mm_Mo_Smoke"] select {isClass(configFile >> "CfgVehicles" >> _x)};
        _return append _ace;
        _return append ["Box_IND_AmmoVeh_F"];
        _return arrayIntersect _return;
    };


    default {
        _return = configProperties [configfile>>"CfgVehicles","((isClass _x)&&{getNumber(_x>>'scope')>1}&&{((configName _x) isKindOf 'Tank_F')||((configName _x) isKindOf 'Air')||((configName _x) isKindOf 'Car')||((configName _x) isKindOf 'StaticWeapon')})", true];
        _return = _return apply {configName _x};
        #ifdef DEBUG_MODE_FULL
            _return pushBack "Land_VR_Block_05_F";
        #endif
        _return = _return select {!((toLower _x) in ["rhs_9k79_b"])};
    };
};

If ((getMissionConfigValue ["isKerberos", 0]) > 0) then {
    _return pushBack "Land_DataTerminal_01_F";
};


_return = _return apply {
    [
        [configfile >> "CfgVehicles" >> _x] call EFUNC(common,getModPicture),
        [configfile >> "CfgVehicles" >> _x] call EFUNC(common,getModName),
        [configfile >> "CfgVehicles" >> _x] call FUNC(getVehicleIcon),
        [_x,"displayName",""] call EFUNC(common,getCfgVehicles),
        _x
    ]
};

_return;
