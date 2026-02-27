/*
    RPG System - RscDialogs
    Диалоги и GUI
*/

#include "RscDefines.hpp"

class RPG_Menu_Display {
    idd = 7700;
    movingEnable = 1;
    enableSimulation = 1;
    
    class controlsBackground {
        class RscTitleBackground: RscText {
            idc = -1;
            x = 0.3;
            y = 0.2;
            w = 0.4;
            h = 0.05;
            colorBackground[] = RPG_COLOR_PRIMARY;
        };
        
        class RscBackground: RscText {
            idc = -1;
            x = 0.3;
            y = 0.25;
            w = 0.4;
            h = 0.55;
            colorBackground[] = RPG_COLOR_SECONDARY;
        };
    };
    
    class controls {
        class RscTitle: RscText {
            idc = -1;
            text = "RPG Система";
            x = 0.3;
            y = 0.2;
            w = 0.4;
            h = 0.05;
            sizeEx = RPG_TITLE_SIZE;
            colorText[] = RPG_COLOR_TEXT;
        };
        
        class RscXPText: RscText {
            idc = 1001;
            text = "XP: 0 / 1000";
            x = 0.31;
            y = 0.26;
            w = 0.38;
            h = 0.04;
            sizeEx = RPG_TEXT_SIZE;
            colorText[] = RPG_COLOR_TEXT;
        };
        
        class RscLevelText: RscText {
            idc = 1002;
            text = "Уровень: 1";
            x = 0.31;
            y = 0.30;
            w = 0.38;
            h = 0.04;
            sizeEx = RPG_TEXT_SIZE;
            colorText[] = RPG_COLOR_TEXT;
        };
        
        class RscProgressBar: RscProgress {
            idc = 1003;
            x = 0.31;
            y = 0.34;
            w = 0.38;
            h = 0.03;
            texture = "#(argb,8,8,3)color(1,1,1,1)";
            colorFrame[] = RPG_COLOR_PRIMARY;
        };
        
        class RscStatsText: RscStructuredText {
            idc = 1004;
            x = 0.31;
            y = 0.38;
            w = 0.38;
            h = 0.15;
            size = RPG_TEXT_SIZE;
        };
        
        class RscSkillsText: RscStructuredText {
            idc = 1005;
            x = 0.31;
            y = 0.53;
            w = 0.38;
            h = 0.15;
            size = RPG_TEXT_SIZE;
        };
        
        class RscCloseButton: RscButtonMenu {
            idc = 1006;
            text = "Закрыть";
            x = 0.5;
            y = 0.72;
            w = 0.2;
            h = 0.04;
            sizeEx = RPG_BUTTON_SIZE;
            action = "closeDialog 0;";
        };
        
        class RscRefreshButton: RscButtonMenu {
            idc = 1007;
            text = "Обновить";
            x = 0.3;
            y = 0.72;
            w = 0.2;
            h = 0.04;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_updateRPGMenu;";
        };
    };
};
