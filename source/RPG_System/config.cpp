#include "ui\RscDefines.hpp"

class RscTitles {
    #include "ui\RscDialogs.hpp"
};

// createDialog looks up display classes at config root.
#include "ui\RscDialogs.hpp"

class CfgPatches {
    class RPG_System {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"A3_Data_F", "A3_UI_F", "cba_main", "ace_main", "ace_common", "ace_medical", "ace_refuel", "ace_explosives"};
        author = "Server Admin";
        version = "2.0.0";
    };
};

class CfgFunctions {
    class RPG {
        // preInit = 1 запускает функцию на всех машинах до старта миссии
        // Используем для компиляции и инициализации серверных систем
        class Database {
            file = "\RPG_System\scripts\database";
            class preInit { preInit = 1; };  // точка входа — запускает все системы на сервере
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
            class checkLevelUp {};
            class initLoadXP {};  // клиент: XP за переноску груза
        };

        class Skills {
            file = "\RPG_System\scripts\skills";
            class initSkills {};
            class getSkill {};
            class setSkill {};
            class addSkillXP {};
            class getSkillLevel {};
            class getSkillBonus {};
            class getPerkPoints {};
            class getPerkCost {};
            class getTreeLevelCost {};
            class getTreeLevelTotalCost {};
            class syncPlayerPerks {};
            class hasPerk {};
            class investSkillPoint {};
            class unlockPerk {};
            class onSkillLevelUp {};
            class showSkillLevelUpClient {};
            class openSkillTree {};
            class updateSkillTree {};
            class selectSkillTree {};
            class selectPerk {};
            class buySelectedPerk {};
            class investSelectedTree {};
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
            class onACEFortify {};
        };

        class Perks {
            file = "\RPG_System\scripts\perks";
            class initPerks {};
        };

        class PerksConstitution {
            file = "\RPG_System\scripts\perks\constitution";
            class initConstitutionPerks {};
            class initConstitutionServer {};
        };

        class PerksReflexes {
            file = "\RPG_System\scripts\perks\reflexes";
            class initReflexesPerks {};
        };

        class PerksTechnical {
            file = "\RPG_System\scripts\perks\technical";
            class initTechnicalPerks {};
        };

        class PerksIntelligence {
            file = "\RPG_System\scripts\perks\intelligence";
            class initIntelligencePerks {};
        };

        class PerksCool {
            file = "\RPG_System\scripts\perks\cool";
            class initCoolPerks {};
        };

        class Admin {
            file = "\RPG_System\scripts\admin";
            class isAdminAuthorized {};
            class requestAdminLogin {};
            class grantAdminXP {};
            class grantAdminSkillPoints {};
            class setAdminSkillPoints {};
            class openAdminLogin {};
            class submitAdminLogin {};
            class openAdminMenu {};
            class updateAdminMenu {};
            class adminGrantXP {};
            class adminGrantSkillPoints {};
            class adminSetSkillPoints {};
            class showAdminMessage {};
        };

        class UI {
            file = "\RPG_System\scripts\ui";
            class clientInit { postInit = 1; };  // инициализация UI на клиенте после миссии
            class initUI {};
            class openRPGMenu {};
            class closeRPGMenu {};
            class updateRPGMenu {};
            class getUITheme {};
            class setUITheme {};
            class applyUITheme {};
            class scaleDisplay {};
            class createXPNotification {};
            class showXPNotificationClient {};
            class showLevelUpNotification {};
            class showLevelUpNotificationClient {};
        };
    };
};

class CfgRemoteExec {
    class Functions {
        mode = 1;  // whitelist mode
        // Server-side functions called from clients (execute on server only)
        class RPG_fnc_addXP           { allowedTargets = 1; };  // client -> server
        class RPG_fnc_addSkillXP      { allowedTargets = 1; };  // client -> server
        class RPG_fnc_syncPlayerPerks { allowedTargets = 1; };  // client -> server
        class RPG_fnc_investSkillPoint { allowedTargets = 1; }; // client -> server
        class RPG_fnc_unlockPerk      { allowedTargets = 1; };  // client -> server
        class RPG_fnc_requestAdminLogin { allowedTargets = 1; }; // client -> server
        class RPG_fnc_grantAdminXP { allowedTargets = 1; }; // client -> server
        class RPG_fnc_grantAdminSkillPoints { allowedTargets = 1; }; // client -> server
        class RPG_fnc_setAdminSkillPoints { allowedTargets = 1; }; // client -> server
        // Client-side functions called from server (execute on any machine)
        class RPG_fnc_showXPNotificationClient       { allowedTargets = 0; };
        class RPG_fnc_showLevelUpNotificationClient   { allowedTargets = 0; };
        class RPG_fnc_showSkillLevelUpClient          { allowedTargets = 0; };
        class RPG_fnc_openRPGMenu                     { allowedTargets = 0; };
        class RPG_fnc_openAdminMenu                   { allowedTargets = 0; };
        class RPG_fnc_showAdminMessage                { allowedTargets = 0; };
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
