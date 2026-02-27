#include "ui\RscDefines.hpp"
#include "ui\RscDialogs.hpp"

class CfgPatches {
    class RPG_System {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"A3_Common", "A3_UI_F"};
        author = "Server Admin";
        version = "1.0.0";
    };
};

class CfgFunctions {
    class RPG {
        class Database {
            file = "\RPG_System\scripts\database";
            class initDatabase {};
            class savePlayerData {};
            class loadPlayerData {};
            class getPlayerData {};
            class setPlayerData {};
            class updateXP {};
        };
        
        class XP {
            file = "\RPG_System\scripts\xp";
            class initXPSystem {};
            class addXP {};
            class getXP {};
            class getLevel {};
            class getNextLevelXP {};
            class getProgressToNextLevel {};
        };
        
        class Events {
            file = "\RPG_System\scripts\events";
            class initEventHandlers {};
            class onPlayerKilled {};
            class onPlayerRespawn {};
            class onVehicleDestroyed {};
            class onEntityKilled {};
        };
        
        class ACE {
            file = "\RPG_System\scripts\ace";
            class initACEIntegration {};
            class onACEMedical {};
            class onACERepair {};
            class onACEReload {};
        };
        
        class UI {
            file = "\RPG_System\scripts\ui";
            class initUI {};
            class openRPGMenu {};
            class closeRPGMenu {};
            class updateRPGMenu {};
            class createXPNotification {};
        };
        
        class Skills {
            file = "\RPG_System\scripts\skills";
            class initSkills {};
            class getSkill {};
            class setSkill {};
            class addSkillXP {};
            class getSkillLevel {};
        };
    };
};

class CfgVehicles {
    class Module_F;
    class RPG_System_Module: Module_F {
        scope = 2;
        displayName = "RPG System Module";
        function = "RPG_fnc_initDatabase";
        isGlobal = 1;
        isTriggerActivated = 0;
        class Arguments {
            class saveInterval {
                displayName = "Save Interval (seconds)";
                description = "How often to auto-save player data";
                typeName = "NUMBER";
                defaultValue = 300;
            };
        };
    };
};
