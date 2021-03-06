/*
    Author: Dorbedo
    v1.0
*/
class strategy {

    class groundattack {
        condition = "true";

        value = 100;
        strength[] = {1,1,0};
        defence[] = {0,0,0};
        type = 1;

        function = QFUNC(strategy_groundattack);

        timeout = 1800;
        finishcondition = "(({alive _x} count (units (_this select 1)))<=((_this select 0)*0.3))";
        parameter[] = {};
    };

    class helicopter {
        condition = QUOTE(['helicopter'] call FUNC(ressources_canUseCallIn));

        value = 4000;
        strength[] = {0.8,0.7,0.3};
        defence[] = {0.3,0.3,0.3};
        type = 2;

        function = QFUNC(strategy_offmap);

        timeout = 1000;
        finishcondition = "(!(alive (_this select 0)))";
        parameter[] = {"helicopter"};

        onFinish = "";

    };

    class airinterception {
        condition = QUOTE(['airinterception'] call FUNC(ressources_canUseCallIn));

        value = 5000;
        strength[] = {0,0,1};
        defence[] = {0.5,0.5,0.5};
        type = 2;

        function = QFUNC(strategy_offmap);

        timeout = 1000;
        finishcondition = "(!(alive (_this select 0)))";
        parameter[] = {"airinterception"};

        onFinish = "";
    };

    class cas : airinterception {
        condition = QUOTE(['cas'] call FUNC(ressources_canUseCallIn));

        value = 3000;
        strength[] = {0.6,0.2,0};
        defence[] = {0.5,0.5,0};
        type = 2;

        parameter[] = {"gunrun"};

    };

    class missiles : cas {
        value = 4500;
        strength[] = {0.4,0.6,0};
        parameter[] = {"missiles"};
    };

    class bombdrop : cas {
        value = 6000;
        strength[] = {1,0.5,0};
        parameter[] = {"cluster"};
    };

    class drones {
        condition = QUOTE(['drones'] call FUNC(ressources_canUseCallIn));

        value = 4000;
        strength[] = {0.4,1,0};
        defence[] = {0.5,0.5,0.5};
        type = 2;

        function = QFUNC(strategy_offmap);

        timeout = 1000;
        finishcondition = "";
        parameter[] = {"dronestrike"};
    };

    class artillery {
        condition = QUOTE('artillery' call EFUNC(headquarter,fdc_ready));

        value = 2500;
        strength[] = {0.7,0.3,0};
        defence[] = {1,0.8,0};
        type = 2;

        function = QFUNC(strategy_artillery);

        timeout = 180;
        finishcondition = "";
        parameter[] = {};
    };

    class rocket {
        condition = QUOTE('rocket' call EFUNC(headquarter,fdc_ready));

        value = 3000;
        strength[] = {0.4,0.5,0};
        defence[] = {1,0.8,0};
        type = 2;

        function = QFUNC(strategy_rocket);

        timeout = 180;
        finishcondition = "";
        parameter[] = {};
    };

    class mortar {
        condition = QUOTE('mortar' call EFUNC(headquarter,fdc_ready));

        value = 2000;
        strength[] = {0.7,0,0};
        defence[] = {1,0.8,0};
        type = 2;

        function = QFUNC(strategy_mortar);

        timeout = 180;
        finishcondition = "";
        parameter[] = {};
    };

};
