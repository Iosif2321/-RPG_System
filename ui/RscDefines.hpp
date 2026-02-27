/*
    RPG System - RscDefines
    Определения GUI элементов
*/

// Цвета
#define RPG_COLOR_PRIMARY [0.2, 0.6, 0.8, 1]
#define RPG_COLOR_SECONDARY [0.1, 0.3, 0.4, 0.8]
#define RPG_COLOR_TEXT [1, 1, 1, 1]
#define RPG_COLOR_SUCCESS [0.2, 0.8, 0.2, 1]
#define RPG_COLOR_WARNING [1, 0.8, 0.2, 1]

// Шрифты
#define RPG_FONT "RobotoCondensed"

// Размеры
#define RPG_TITLE_SIZE 0.05
#define RPG_TEXT_SIZE 0.04
#define RPG_BUTTON_SIZE 0.04

// Базовые классы
class RscText {
    idc = -1;
    type = 0;
    style = 0;
    colorBackground[] = {0, 0, 0, 0};
    colorText[] = {1, 1, 1, 1};
    font = RPG_FONT;
    sizeEx = 0.04;
    h = 0.04;
    text = "";
};

class RscStructuredText {
    idc = -1;
    type = 13;
    style = 0;
    colorText[] = {1, 1, 1, 1};
    font = RPG_FONT;
    size = 0.04;
    text = "";
    
    class Attributes {
        font = RPG_FONT;
        color = "#ffffff";
        align = "left";
        shadow = 1;
    };
};

class RscProgress {
    idc = -1;
    type = 8;
    style = 0;
    colorBackground[] = {0, 0, 0, 0.5};
    colorFrame[] = {1, 1, 1, 1};
    texture = "#(argb,8,8,3)color(1,1,1,1)";
};

class RscButtonMenu {
    idc = -1;
    type = 16;
    style = "0x02 + 0xC0";
    default = 0;
    shadow = 1;
    font = RPG_FONT;
    sizeEx = 0.04;
    colorBackground[] = {0.2, 0.6, 0.8, 1};
    colorBackgroundActive[] = {0.3, 0.7, 0.9, 1};
    colorBackgroundDisabled[] = {0.1, 0.1, 0.1, 1};
    colorText[] = {1, 1, 1, 1};
    colorTextActive[] = {1, 1, 1, 1};
    colorTextDisabled[] = {0.5, 0.5, 0.5, 1};
    colorShadow[] = {0, 0, 0, 0};
    colorBorder[] = {0, 0, 0, 0};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter", 0.09, 1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush", 0.09, 1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick", 0.09, 1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape", 0.09, 1};
    text = "";
    action = "";
};
