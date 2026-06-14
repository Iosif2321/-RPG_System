/*
    RPG System - RscDefines (DnD Card Style)
    Определения GUI элементов
*/

// === Цветовая палитра пергамента DnD ===
#define RPG_COLOR_PARCHMENT    {0.035, 0.040, 0.045, 0.97}
#define RPG_COLOR_DARK_FRAME   {0.005, 0.007, 0.009, 1.00}
#define RPG_COLOR_DARK_BANNER  {0.075, 0.045, 0.022, 0.98}
#define RPG_COLOR_ATTR_BOX     {0.060, 0.066, 0.072, 0.96}
#define RPG_COLOR_GOLD         {0.78, 0.62, 0.18, 1.00}
#define RPG_COLOR_DARK_TEXT    {0.94, 0.89, 0.76, 1.00}
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
#define RPG_TITLE_SIZE   0.046
#define RPG_NAME_SIZE    0.076
#define RPG_SECTION_SIZE 0.039
#define RPG_TEXT_SIZE    0.034
#define RPG_SMALL_SIZE   0.029
#define RPG_BUTTON_SIZE  0.034

// Forward-declaration базовых классов A3_UI_F
class RscText;
class RscStructuredText;
class RscProgress;
class RscButtonMenu;
class RscEdit;
class RscListbox;

class RPG_RscText: RscText {
    font = RPG_FONT;
    sizeEx = RPG_TEXT_SIZE;
    shadow = 1;
    colorText[] = RPG_COLOR_LIGHT_TEXT;
    colorBackground[] = {0, 0, 0, 0};
};

class RPG_RscStructuredText: RscStructuredText {
    font = RPG_FONT;
    size = RPG_TEXT_SIZE;
    shadow = 1;
    colorText[] = RPG_COLOR_LIGHT_TEXT;
};

class RPG_RscProgress: RscProgress {
    colorBackground[] = {0.10, 0.11, 0.12, 1.0};
    colorFrame[] = RPG_COLOR_RED_HEADER;
    texture = "#(argb,8,8,3)color(0.55,0.12,0.12,1)";
};

class RPG_RscButtonMenu: RscButtonMenu {
    font = RPG_FONT;
    sizeEx = RPG_BUTTON_SIZE;
    shadow = 1;
    colorBackground[] = RPG_COLOR_DARK_BANNER;
    colorBackgroundActive[] = {0.35, 0.08, 0.08, 1.00};
    colorBackgroundDisabled[] = {0.10, 0.10, 0.10, 1.00};
    colorText[] = RPG_COLOR_LIGHT_TEXT;
    colorTextActive[] = RPG_COLOR_GOLD;
    colorTextDisabled[] = {0.5, 0.5, 0.5, 1};
};

class RPG_RscEdit: RscEdit {
    font = RPG_FONT;
    sizeEx = RPG_TEXT_SIZE;
    shadow = 1;
    colorText[] = RPG_COLOR_LIGHT_TEXT;
    colorBackground[] = {0.04, 0.04, 0.04, 0.92};
    colorSelection[] = RPG_COLOR_GOLD;
    autocomplete = "";
};

class RPG_RscListBox: RscListbox {
    font = RPG_FONT;
    sizeEx = RPG_TEXT_SIZE;
    rowHeight = 0.055;
    shadow = 1;
    colorText[] = RPG_COLOR_LIGHT_TEXT;
    colorSelect[] = {1, 1, 1, 1};
    colorSelect2[] = {1, 1, 1, 1};
    colorDisabled[] = {0.45, 0.45, 0.45, 1};
    colorBackground[] = {0, 0, 0, 0};
    colorSelectBackground[] = {0.78, 0.62, 0.18, 0.38};
    colorSelectBackground2[] = {0.78, 0.62, 0.18, 0.55};
    colorScrollbar[] = RPG_COLOR_GOLD;
    soundSelect[] = {"", 0.1, 1};
    period = 1;
    maxHistoryDelay = 1;
    class ListScrollBar {
        color[] = RPG_COLOR_GOLD;
        autoScrollEnabled = 0;
    };
};
