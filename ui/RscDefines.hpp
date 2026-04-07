/*
    RPG System - RscDefines
    Определения GUI элементов
*/

// Цвета (фигурные скобки для использования в config)
#define RPG_COLOR_PRIMARY {0.2, 0.6, 0.8, 1}
#define RPG_COLOR_SECONDARY {0.1, 0.3, 0.4, 0.8}
#define RPG_COLOR_TEXT {1, 1, 1, 1}
#define RPG_COLOR_SUCCESS {0.2, 0.8, 0.2, 1}
#define RPG_COLOR_WARNING {1, 0.8, 0.2, 1}

// Шрифты
#define RPG_FONT "RobotoCondensed"

// Размеры
#define RPG_TITLE_SIZE 0.05
#define RPG_TEXT_SIZE 0.04
#define RPG_BUTTON_SIZE 0.04

// Forward-declaration базовых классов A3_UI_F
class RscText;
class RscStructuredText;
class RscProgress;
class RscButtonMenu;

class RPG_RscText: RscText {
    font = RPG_FONT;
    sizeEx = 0.04;
};

class RPG_RscStructuredText: RscStructuredText {
    font = RPG_FONT;
    size = 0.04;
};

class RPG_RscProgress: RscProgress {
    colorBackground[] = {0, 0, 0, 0.5};
    colorFrame[] = {1, 1, 1, 1};
    texture = "#(argb,8,8,3)color(1,1,1,1)";
};

class RPG_RscButtonMenu: RscButtonMenu {
    font = RPG_FONT;
    sizeEx = 0.04;
    colorBackground[] = {0.2, 0.6, 0.8, 1};
    colorBackgroundActive[] = {0.3, 0.7, 0.9, 1};
    colorBackgroundDisabled[] = {0.1, 0.1, 0.1, 1};
    colorText[] = {1, 1, 1, 1};
    colorTextActive[] = {1, 1, 1, 1};
    colorTextDisabled[] = {0.5, 0.5, 0.5, 1};
};
