/*
    RPG System - RscDefines (DnD Card Style)
    Определения GUI элементов
*/

// === Цветовая палитра пергамента DnD ===
#define RPG_COLOR_PARCHMENT    {0.87, 0.80, 0.64, 0.97}
#define RPG_COLOR_DARK_FRAME   {0.14, 0.09, 0.04, 1.00}
#define RPG_COLOR_DARK_BANNER  {0.18, 0.11, 0.05, 1.00}
#define RPG_COLOR_ATTR_BOX     {0.93, 0.87, 0.73, 1.00}
#define RPG_COLOR_GOLD         {0.78, 0.62, 0.18, 1.00}
#define RPG_COLOR_DARK_TEXT    {0.12, 0.07, 0.02, 1.00}
#define RPG_COLOR_LIGHT_TEXT   {0.94, 0.89, 0.76, 1.00}
#define RPG_COLOR_RED_HEADER   {0.55, 0.12, 0.12, 1.00}

// Совместимость со старым кодом
#define RPG_COLOR_PRIMARY      {0.55, 0.12, 0.12, 1.00}
#define RPG_COLOR_SECONDARY    {0.87, 0.80, 0.64, 0.97}
#define RPG_COLOR_TEXT         {0.12, 0.07, 0.02, 1.00}
#define RPG_COLOR_SUCCESS      {0.20, 0.55, 0.20, 1.00}
#define RPG_COLOR_WARNING      {0.78, 0.62, 0.18, 1.00}

// === Шрифт ===
#define RPG_FONT "RobotoCondensed"

// === Размеры ===
#define RPG_TITLE_SIZE   0.030
#define RPG_NAME_SIZE    0.050
#define RPG_SECTION_SIZE 0.026
#define RPG_TEXT_SIZE    0.024
#define RPG_SMALL_SIZE   0.020
#define RPG_BUTTON_SIZE  0.026

// Forward-declaration базовых классов A3_UI_F
class RscText;
class RscStructuredText;
class RscProgress;
class RscButtonMenu;

class RPG_RscText: RscText {
    font = RPG_FONT;
    sizeEx = RPG_TEXT_SIZE;
    colorBackground[] = {0, 0, 0, 0};
};

class RPG_RscStructuredText: RscStructuredText {
    font = RPG_FONT;
    size = RPG_TEXT_SIZE;
};

class RPG_RscProgress: RscProgress {
    colorBackground[] = {0.82, 0.75, 0.58, 1.0};
    colorFrame[] = RPG_COLOR_RED_HEADER;
    texture = "#(argb,8,8,3)color(0.55,0.12,0.12,1)";
};

class RPG_RscButtonMenu: RscButtonMenu {
    font = RPG_FONT;
    sizeEx = RPG_BUTTON_SIZE;
    colorBackground[] = RPG_COLOR_DARK_BANNER;
    colorBackgroundActive[] = {0.35, 0.08, 0.08, 1.00};
    colorBackgroundDisabled[] = {0.10, 0.10, 0.10, 1.00};
    colorText[] = RPG_COLOR_LIGHT_TEXT;
    colorTextActive[] = RPG_COLOR_GOLD;
    colorTextDisabled[] = {0.5, 0.5, 0.5, 1};
};
