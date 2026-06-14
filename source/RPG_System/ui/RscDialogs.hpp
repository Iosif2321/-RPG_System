/*
    RPG System - RscDialogs (DnD Character Card Style)
    Двухколоночный макет: атрибуты слева, боевой профиль справа
*/

class RPG_Menu_Display {
    idd = 7700;
    movingEnable = 1;
    enableSimulation = 1;

    class controlsBackground {

        // ╔══════════════════════════════════════╗
        //   ОСНОВНОЙ ФОН КАРТОЧКИ
        // ╚══════════════════════════════════════╝

        // Тёмная внешняя рамка (имитирует кожаный переплёт)
        class BgFrame: RPG_RscText {
            idc = 7000;
            x = 0.150; y = 0.045; w = 0.700; h = 0.905;
            colorBackground[] = RPG_COLOR_DARK_FRAME;
        };
        // Пергаментный фон
        class BgParchment: RPG_RscText {
            idc = 7001;
            x = 0.154; y = 0.050; w = 0.692; h = 0.895;
            colorBackground[] = RPG_COLOR_PARCHMENT;
        };

        // ╔══════════════════════════════════════╗
        //   ВЕРХНИЙ БАННЕР (свиток)
        // ╚══════════════════════════════════════╝
        class BgBanner: RPG_RscText {
            idc = 7002;
            x = 0.154; y = 0.050; w = 0.692; h = 0.100;
            colorBackground[] = RPG_COLOR_DARK_BANNER;
        };
        class BgGoldTop: RPG_RscText {
            idc = 7003;
            x = 0.154; y = 0.150; w = 0.692; h = 0.004;
            colorBackground[] = RPG_COLOR_GOLD;
        };

        // Полоска с уровнем и XP (светлая)
        class BgInfoStrip: RPG_RscText {
            idc = 7004;
            x = 0.154; y = 0.154; w = 0.692; h = 0.060;
            colorBackground[] = {0.030, 0.034, 0.038, 0.95};
        };

        // ╔══════════════════════════════════════╗
        //   ВЕРТИКАЛЬНЫЙ РАЗДЕЛИТЕЛЬ КОЛОНОК
        // ╚══════════════════════════════════════╝
        class BgColDivider: RPG_RscText {
            idc = 7005;
            x = 0.380; y = 0.222; w = 0.004; h = 0.628;
            colorBackground[] = RPG_COLOR_RED_HEADER;
        };

        // ╔══════════════════════════════════════╗
        //   ЛЕВАЯ КОЛОНКА — ХАРАКТЕРИСТИКИ
        // ╚══════════════════════════════════════╝

        // Шапка левой колонки
        class BgAttrHeader: RPG_RscText {
            idc = 7006;
            x = 0.158; y = 0.222; w = 0.218; h = 0.032;
            colorBackground[] = RPG_COLOR_RED_HEADER;
        };

        // Блок атрибута 1 — БОЙ (y=0.267)
        class BgAB1: RPG_RscText { idc=7020; x=0.158; y=0.260; w=0.218; h=0.112; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF1: RPG_RscText { idc=7030; x=0.161; y=0.263; w=0.212; h=0.106; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // Блок атрибута 2 — МЕДИЦИНА (y=0.381)
        class BgAB2: RPG_RscText { idc=7021; x=0.158; y=0.380; w=0.218; h=0.112; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF2: RPG_RscText { idc=7031; x=0.161; y=0.383; w=0.212; h=0.106; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // Блок атрибута 3 — РЕМОНТ (y=0.495)
        class BgAB3: RPG_RscText { idc=7022; x=0.158; y=0.500; w=0.218; h=0.112; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF3: RPG_RscText { idc=7032; x=0.161; y=0.503; w=0.212; h=0.106; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // Блок атрибута 4 — ПОДДЕРЖКА (y=0.609)
        class BgAB4: RPG_RscText { idc=7023; x=0.158; y=0.620; w=0.218; h=0.112; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF4: RPG_RscText { idc=7033; x=0.161; y=0.623; w=0.212; h=0.106; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // Блок атрибута 5 — ИНЖЕНЕРИЯ (y=0.723)
        class BgAB5: RPG_RscText { idc=7024; x=0.158; y=0.740; w=0.218; h=0.110; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF5: RPG_RscText { idc=7034; x=0.161; y=0.743; w=0.212; h=0.104; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // ╔══════════════════════════════════════╗
        //   ПРАВАЯ КОЛОНКА — БОЕВОЙ ПРОФИЛЬ
        // ╚══════════════════════════════════════╝

        // Шапка правой колонки
        class BgRightHeader: RPG_RscText {
            idc = 7007;
            x = 0.388; y = 0.222; w = 0.454; h = 0.032;
            colorBackground[] = {0.20, 0.12, 0.06, 0.95};
        };

        // — СЕКЦИЯ 1: Боевая статистика (красная) —
        class BgS1Header: RPG_RscText {
            idc=7008; x=0.388; y=0.260; w=0.454; h=0.032;
            colorBackground[] = {0.52, 0.10, 0.10, 0.95};
        };
        // 3 ячейки: Убийства | Смерти | K/D
        // ширина ячейки=0.122, зазор=0.013
        class BgS1B1: RPG_RscText { idc=7040; x=0.392; y=0.300; w=0.138; h=0.085; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS1F1: RPG_RscText { idc=7050; x=0.395; y=0.303; w=0.132; h=0.079; colorBackground[] = RPG_COLOR_PARCHMENT; };
        class BgS1B2: RPG_RscText { idc=7041; x=0.546; y=0.300; w=0.138; h=0.085; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS1F2: RPG_RscText { idc=7051; x=0.549; y=0.303; w=0.132; h=0.079; colorBackground[] = RPG_COLOR_PARCHMENT; };
        class BgS1B3: RPG_RscText { idc=7042; x=0.700; y=0.300; w=0.138; h=0.085; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS1F3: RPG_RscText { idc=7052; x=0.703; y=0.303; w=0.132; h=0.079; colorBackground[] = RPG_COLOR_PARCHMENT; };

        // — СЕКЦИЯ 2: Боевые действия (оранжевая) —
        class BgS2Header: RPG_RscText {
            idc=7009; x=0.388; y=0.402; w=0.454; h=0.032;
            colorBackground[] = {0.58, 0.32, 0.07, 0.95};
        };
        // 3 ячейки: Воскрешения | Ремонты | Часов
        class BgS2B1: RPG_RscText { idc=7043; x=0.392; y=0.442; w=0.138; h=0.085; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS2F1: RPG_RscText { idc=7053; x=0.395; y=0.445; w=0.132; h=0.079; colorBackground[] = RPG_COLOR_PARCHMENT; };
        class BgS2B2: RPG_RscText { idc=7044; x=0.546; y=0.442; w=0.138; h=0.085; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS2F2: RPG_RscText { idc=7054; x=0.549; y=0.445; w=0.132; h=0.079; colorBackground[] = RPG_COLOR_PARCHMENT; };
        class BgS2B3: RPG_RscText { idc=7045; x=0.700; y=0.442; w=0.138; h=0.085; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS2F3: RPG_RscText { idc=7055; x=0.703; y=0.445; w=0.132; h=0.079; colorBackground[] = RPG_COLOR_PARCHMENT; };

        // — СЕКЦИЯ 3: Опыт по категориям (синяя) —
        class BgS3Header: RPG_RscText {
            idc=7010; x=0.388; y=0.544; w=0.454; h=0.032;
            colorBackground[] = {0.10, 0.22, 0.42, 0.95};
        };
        class BgS3Content: RPG_RscText {
            idc=7011; x=0.388; y=0.576; w=0.454; h=0.274;
            colorBackground[] = {0.040, 0.045, 0.050, 0.82};
        };

        // ╔══════════════════════════════════════╗
        //   НИЖНЯЯ ПАНЕЛЬ С КНОПКАМИ
        // ╚══════════════════════════════════════╝
        class BgGoldBot1: RPG_RscText { idc=7012; x=0.154; y=0.865; w=0.692; h=0.004; colorBackground[] = RPG_COLOR_GOLD; };
        class BgBannerBot: RPG_RscText { idc=7013; x=0.154; y=0.869; w=0.692; h=0.052; colorBackground[] = RPG_COLOR_DARK_BANNER; };
        class BgGoldBot2: RPG_RscText { idc=7014; x=0.154; y=0.921; w=0.692; h=0.004; colorBackground[] = RPG_COLOR_GOLD; };
    };

    class controls {

        // ╔══════════════════════════════════════╗
        //   ВЕРХНИЙ БАННЕР
        // ╚══════════════════════════════════════╝
        class TitleLabel: RPG_RscText {
            idc = -1;
            text = "ЛИСТ ПЕРСОНАЖА";
            x = 0.154; y = 0.058; w = 0.692; h = 0.032;
            sizeEx = RPG_TITLE_SIZE;
            style = 2;
            colorText[] = RPG_COLOR_LIGHT_TEXT;
        };
        // Имя игрока — большое, золотом
        class PlayerName: RPG_RscText {
            idc = 1000;
            text = "ИГРОК";
            x = 0.154; y = 0.092; w = 0.692; h = 0.054;
            sizeEx = RPG_NAME_SIZE;
            style = 2;
            colorText[] = RPG_COLOR_GOLD;
        };

        // ╔══════════════════════════════════════╗
        //   ПОЛОСКА УРОВНЯ / XP
        // ╚══════════════════════════════════════╝
        class LevelText: RPG_RscText {
            idc = 1002;
            text = "УРОВЕНЬ 1    НОВОБРАНЕЦ";
            x = 0.162; y = 0.162; w = 0.330; h = 0.028;
            sizeEx = RPG_TEXT_SIZE;
            colorText[] = RPG_COLOR_DARK_TEXT;
        };
        class XPText: RPG_RscText {
            idc = 1001;
            text = "ОПЫТ: 0 / 1000";
            x = 0.500; y = 0.162; w = 0.338; h = 0.028;
            sizeEx = RPG_TEXT_SIZE;
            style = 1;
            colorText[] = RPG_COLOR_DARK_TEXT;
        };
        class XPBar: RPG_RscProgress {
            idc = 1003;
            x = 0.162; y = 0.192; w = 0.676; h = 0.016;
        };

        // ╔══════════════════════════════════════╗
        //   ЛЕВАЯ КОЛОНКА — ХАРАКТЕРИСТИКИ
        // ╚══════════════════════════════════════╝
        class AttrColTitle: RPG_RscText {
            idc = -1;
            text = "ХАРАКТЕРИСТИКИ";
            x = 0.158; y = 0.222; w = 0.218; h = 0.032;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = {1, 1, 1, 1};
        };

        // Блоки атрибутов (IDC 1010-1014)
        // Каждый: большое число-очки + модификатор + название
        class AttrCombat: RPG_RscStructuredText {
            idc = 1010;
            x = 0.161; y = 0.263; w = 0.212; h = 0.106;
            size = RPG_TEXT_SIZE;
        };
        class AttrMedical: RPG_RscStructuredText {
            idc = 1011;
            x = 0.161; y = 0.383; w = 0.212; h = 0.106;
            size = RPG_TEXT_SIZE;
        };
        class AttrRepair: RPG_RscStructuredText {
            idc = 1012;
            x = 0.161; y = 0.503; w = 0.212; h = 0.106;
            size = RPG_TEXT_SIZE;
        };
        class AttrSupport: RPG_RscStructuredText {
            idc = 1013;
            x = 0.161; y = 0.623; w = 0.212; h = 0.106;
            size = RPG_TEXT_SIZE;
        };
        class AttrEngineering: RPG_RscStructuredText {
            idc = 1014;
            x = 0.161; y = 0.743; w = 0.212; h = 0.104;
            size = RPG_TEXT_SIZE;
        };

        // ╔══════════════════════════════════════╗
        //   ПРАВАЯ КОЛОНКА — БОЕВОЙ ПРОФИЛЬ
        // ╚══════════════════════════════════════╝
        class RightColTitle: RPG_RscText {
            idc = -1;
            text = "БОЕВОЙ ПРОФИЛЬ";
            x = 0.388; y = 0.222; w = 0.454; h = 0.032;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = RPG_COLOR_LIGHT_TEXT;
        };

        // — СЕКЦИЯ 1: Боевая статистика (красная) —
        class S1Title: RPG_RscText {
            idc = -1;
            text = "БОЕВАЯ СТАТИСТИКА";
            x = 0.388; y = 0.260; w = 0.454; h = 0.032;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = {1, 1, 1, 1};
        };
        // Подписи ячеек (статичные)
        class S1L1: RPG_RscText { idc=-1; text="УБИЙСТВА";  x=0.395; y=0.305; w=0.132; h=0.022; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.52,0.10,0.10,1}; };
        class S1L2: RPG_RscText { idc=-1; text="СМЕРТИ";    x=0.549; y=0.305; w=0.132; h=0.022; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.52,0.10,0.10,1}; };
        class S1L3: RPG_RscText { idc=-1; text="K / D";     x=0.703; y=0.305; w=0.132; h=0.022; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.52,0.10,0.10,1}; };
        // Значения ячеек (динамические)
        class S1V1: RPG_RscText { idc=1020; text="0"; x=0.395; y=0.330; w=0.132; h=0.048; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };
        class S1V2: RPG_RscText { idc=1021; text="0"; x=0.549; y=0.330; w=0.132; h=0.048; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };
        class S1V3: RPG_RscText { idc=1022; text="0"; x=0.703; y=0.330; w=0.132; h=0.048; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };

        // — СЕКЦИЯ 2: Боевые действия (оранжевая) —
        class S2Title: RPG_RscText {
            idc = -1;
            text = "БОЕВЫЕ ДЕЙСТВИЯ";
            x = 0.388; y = 0.402; w = 0.454; h = 0.032;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = {1, 1, 1, 1};
        };
        class S2L1: RPG_RscText { idc=-1; text="ВОСКРЕШЕНИЙ"; x=0.395; y=0.447; w=0.132; h=0.022; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.58,0.32,0.07,1}; };
        class S2L2: RPG_RscText { idc=-1; text="РЕМОНТОВ";    x=0.549; y=0.447; w=0.132; h=0.022; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.58,0.32,0.07,1}; };
        class S2L3: RPG_RscText { idc=-1; text="ЧАСОВ В ИГРЕ"; x=0.703; y=0.447; w=0.132; h=0.022; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.58,0.32,0.07,1}; };
        class S2V1: RPG_RscText { idc=1023; text="0"; x=0.395; y=0.472; w=0.132; h=0.048; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };
        class S2V2: RPG_RscText { idc=1024; text="0"; x=0.549; y=0.472; w=0.132; h=0.048; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };
        class S2V3: RPG_RscText { idc=1025; text="0"; x=0.703; y=0.472; w=0.132; h=0.048; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };

        // — СЕКЦИЯ 3: Опыт по категориям (синяя) —
        class S3Title: RPG_RscText {
            idc = -1;
            text = "ОПЫТ ПО КАТЕГОРИЯМ";
            x = 0.388; y = 0.544; w = 0.454; h = 0.032;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = {1, 1, 1, 1};
        };
        class SkillsText: RPG_RscStructuredText {
            idc = 1005;
            x = 0.396; y = 0.584; w = 0.438; h = 0.252;
            size = RPG_TEXT_SIZE;
        };

        // ╔══════════════════════════════════════╗
        //   КНОПКИ В НИЖНЕМ БАННЕРЕ
        // ╚══════════════════════════════════════╝
        class RefreshButton: RPG_RscButtonMenu {
            idc = 1007;
            text = "ОБНОВИТЬ";
            x = 0.162; y = 0.882; w = 0.128; h = 0.032;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_updateRPGMenu;";
        };
        class PerksButton: RPG_RscButtonMenu {
            idc = 1008;
            text = "ПЕРКИ";
            x = 0.300; y = 0.882; w = 0.120; h = 0.032;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_openSkillTree;";
        };
        class AdminButton: RPG_RscButtonMenu {
            idc = 1009;
            text = "АДМИН";
            x = 0.430; y = 0.882; w = 0.120; h = 0.032;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_openAdminLogin;";
        };
        class CloseButton: RPG_RscButtonMenu {
            idc = 1006;
            text = "ЗАКРЫТЬ";
            x = 0.560; y = 0.882; w = 0.140; h = 0.032;
            sizeEx = RPG_BUTTON_SIZE;
            action = "closeDialog 0;";
        };
        class ThemeAmberButton: RPG_RscButtonMenu {
            idc = 1090;
            text = "o";
            tooltip = "RPG UI theme: amber";
            x = 0.725; y = 0.883; w = 0.022; h = 0.030;
            colorBackground[] = {0.78,0.62,0.18,1};
            action = "[""amber""] call RPG_fnc_setUITheme;";
        };
        class ThemeRedButton: ThemeAmberButton {
            idc = 1091;
            tooltip = "RPG UI theme: red";
            x = 0.752;
            colorBackground[] = {0.88,0.16,0.22,1};
            action = "[""red""] call RPG_fnc_setUITheme;";
        };
        class ThemeBlueButton: ThemeAmberButton {
            idc = 1092;
            tooltip = "RPG UI theme: blue";
            x = 0.779;
            colorBackground[] = {0.14,0.54,0.86,1};
            action = "[""blue""] call RPG_fnc_setUITheme;";
        };
        class ThemeGreenButton: ThemeAmberButton {
            idc = 1093;
            tooltip = "RPG UI theme: green";
            x = 0.806;
            colorBackground[] = {0.22,0.68,0.36,1};
            action = "[""green""] call RPG_fnc_setUITheme;";
        };
        class ThemeVioletButton: ThemeAmberButton {
            idc = 1094;
            tooltip = "RPG UI theme: violet";
            x = 0.833;
            colorBackground[] = {0.50,0.34,0.82,1};
            action = "[""violet""] call RPG_fnc_setUITheme;";
        };
    };
};

class RPG_AdminLogin_Display {
    idd = 7702;
    movingEnable = 1;
    enableSimulation = 1;

    class controlsBackground {
        class BgFrame: RPG_RscText {
            idc = 7200;
            x = 0.270; y = 0.265; w = 0.460; h = 0.410;
            colorBackground[] = RPG_COLOR_DARK_FRAME;
        };
        class BgPanel: RPG_RscText {
            idc = 7201;
            x = 0.278; y = 0.273; w = 0.444; h = 0.394;
            colorBackground[] = {0.08, 0.06, 0.045, 0.97};
        };
        class BgHeader: RPG_RscText {
            idc = 7202;
            x = 0.278; y = 0.273; w = 0.444; h = 0.062;
            colorBackground[] = RPG_COLOR_DARK_BANNER;
        };
    };

    class controls {
        class Title: RPG_RscText {
            idc = -1;
            text = "RPG ADMIN";
            x = 0.294; y = 0.290; w = 0.412; h = 0.038;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = RPG_COLOR_GOLD;
        };
        class Hint: RPG_RscStructuredText {
            idc = -1;
            x = 0.294; y = 0.365; w = 0.412; h = 0.085;
            size = RPG_TEXT_SIZE;
            text = "Введите пароль, заданный в серверной CBA-настройке RPG Admin Password.";
        };
        class PasswordEdit: RPG_RscEdit {
            idc = 4001;
            text = "";
            x = 0.294; y = 0.468; w = 0.412; h = 0.044;
            sizeEx = RPG_TEXT_SIZE;
        };
        class ThemeAmberButton: RPG_RscButtonMenu {
            idc = 4090;
            text = "o";
            tooltip = "RPG UI theme: amber";
            x = 0.294; y = 0.532; w = 0.026; h = 0.034;
            colorBackground[] = {0.78,0.62,0.18,1};
            action = "[""amber""] call RPG_fnc_setUITheme;";
        };
        class ThemeRedButton: ThemeAmberButton {
            idc = 4091;
            tooltip = "RPG UI theme: red";
            x = 0.326;
            colorBackground[] = {0.88,0.16,0.22,1};
            action = "[""red""] call RPG_fnc_setUITheme;";
        };
        class ThemeBlueButton: ThemeAmberButton {
            idc = 4092;
            tooltip = "RPG UI theme: blue";
            x = 0.358;
            colorBackground[] = {0.14,0.54,0.86,1};
            action = "[""blue""] call RPG_fnc_setUITheme;";
        };
        class ThemeGreenButton: ThemeAmberButton {
            idc = 4093;
            tooltip = "RPG UI theme: green";
            x = 0.390;
            colorBackground[] = {0.22,0.68,0.36,1};
            action = "[""green""] call RPG_fnc_setUITheme;";
        };
        class ThemeVioletButton: ThemeAmberButton {
            idc = 4094;
            tooltip = "RPG UI theme: violet";
            x = 0.422;
            colorBackground[] = {0.50,0.34,0.82,1};
            action = "[""violet""] call RPG_fnc_setUITheme;";
        };
        class SubmitButton: RPG_RscButtonMenu {
            idc = 4002;
            text = "ВОЙТИ";
            x = 0.294; y = 0.595; w = 0.190; h = 0.044;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_submitAdminLogin;";
        };
        class CancelButton: RPG_RscButtonMenu {
            idc = 4003;
            text = "ОТМЕНА";
            x = 0.516; y = 0.595; w = 0.190; h = 0.044;
            sizeEx = RPG_BUTTON_SIZE;
            action = "closeDialog 0;";
        };
    };
};

class RPG_AdminMenu_Display {
    idd = 7703;
    movingEnable = 1;
    enableSimulation = 1;

    class controlsBackground {
        class BgFrame: RPG_RscText {
            idc = 7300;
            x = 0.145; y = 0.075; w = 0.710; h = 0.835;
            colorBackground[] = RPG_COLOR_DARK_FRAME;
        };
        class BgPanel: RPG_RscText {
            idc = 7301;
            x = 0.153; y = 0.083; w = 0.694; h = 0.819;
            colorBackground[] = {0.055, 0.060, 0.065, 0.97};
        };
        class BgHeader: RPG_RscText {
            idc = 7302;
            x = 0.153; y = 0.083; w = 0.694; h = 0.070;
            colorBackground[] = RPG_COLOR_DARK_BANNER;
        };
    };

    class controls {
        class Title: RPG_RscText {
            idc = -1;
            text = "RPG ADMIN MENU";
            x = 0.180; y = 0.103; w = 0.640; h = 0.042;
            sizeEx = RPG_TITLE_SIZE;
            style = 2;
            colorText[] = RPG_COLOR_GOLD;
        };
        class Status: RPG_RscStructuredText {
            idc = 5000;
            x = 0.180; y = 0.195; w = 0.640; h = 0.220;
            size = 0.036;
        };
        class XPLabel: RPG_RscText {
            idc = -1;
            text = "XP AMOUNT";
            x = 0.180; y = 0.452; w = 0.210; h = 0.034;
            sizeEx = RPG_SMALL_SIZE;
            colorText[] = RPG_COLOR_LIGHT_TEXT;
        };
        class XPEdit: RPG_RscEdit {
            idc = 5001;
            text = "1000";
            x = 0.420; y = 0.446; w = 0.400; h = 0.046;
            sizeEx = RPG_TEXT_SIZE;
        };
        class PointsLabel: RPG_RscText {
            idc = -1;
            text = "SKILL POINTS";
            x = 0.180; y = 0.512; w = 0.210; h = 0.034;
            sizeEx = RPG_SMALL_SIZE;
            colorText[] = RPG_COLOR_LIGHT_TEXT;
        };
        class PointsEdit: RPG_RscEdit {
            idc = 5002;
            text = "1";
            x = 0.420; y = 0.506; w = 0.400; h = 0.046;
            sizeEx = RPG_TEXT_SIZE;
        };
        class ReasonLabel: RPG_RscText {
            idc = -1;
            text = "REASON";
            x = 0.180; y = 0.572; w = 0.210; h = 0.034;
            sizeEx = RPG_SMALL_SIZE;
            colorText[] = RPG_COLOR_LIGHT_TEXT;
        };
        class ReasonEdit: RPG_RscEdit {
            idc = 5003;
            text = "Admin grant";
            x = 0.420; y = 0.566; w = 0.400; h = 0.046;
            sizeEx = RPG_TEXT_SIZE;
        };
        class GrantXPButton: RPG_RscButtonMenu {
            idc = 5010;
            text = "ВЫДАТЬ XP";
            x = 0.180; y = 0.660; w = 0.190; h = 0.046;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_adminGrantXP;";
        };
        class AddPointsButton: RPG_RscButtonMenu {
            idc = 5011;
            text = "ДОБАВИТЬ ОЧКИ";
            x = 0.395; y = 0.660; w = 0.200; h = 0.046;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_adminGrantSkillPoints;";
        };
        class SetPointsButton: RPG_RscButtonMenu {
            idc = 5012;
            text = "УСТАНОВИТЬ БОНУС";
            x = 0.620; y = 0.660; w = 0.200; h = 0.046;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_adminSetSkillPoints;";
        };
        class RefreshButton: RPG_RscButtonMenu {
            idc = 5013;
            text = "ОБНОВИТЬ";
            x = 0.180; y = 0.750; w = 0.305; h = 0.046;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[player] remoteExecCall [""RPG_fnc_syncPlayerPerks"", 2, false]; [{[] call RPG_fnc_updateAdminMenu;}, [], 0.5] call CBA_fnc_waitAndExecute;";
        };
        class CloseButton: RPG_RscButtonMenu {
            idc = 5014;
            text = "ЗАКРЫТЬ";
            x = 0.515; y = 0.750; w = 0.305; h = 0.046;
            sizeEx = RPG_BUTTON_SIZE;
            action = "closeDialog 0;";
        };
        class ThemeAmberButton: RPG_RscButtonMenu {
            idc = 5090;
            text = "o";
            tooltip = "RPG UI theme: amber";
            x = 0.180; y = 0.825; w = 0.026; h = 0.034;
            colorBackground[] = {0.78,0.62,0.18,1};
            action = "[""amber""] call RPG_fnc_setUITheme;";
        };
        class ThemeRedButton: ThemeAmberButton {
            idc = 5091;
            tooltip = "RPG UI theme: red";
            x = 0.212;
            colorBackground[] = {0.88,0.16,0.22,1};
            action = "[""red""] call RPG_fnc_setUITheme;";
        };
        class ThemeBlueButton: ThemeAmberButton {
            idc = 5092;
            tooltip = "RPG UI theme: blue";
            x = 0.244;
            colorBackground[] = {0.14,0.54,0.86,1};
            action = "[""blue""] call RPG_fnc_setUITheme;";
        };
        class ThemeGreenButton: ThemeAmberButton {
            idc = 5093;
            tooltip = "RPG UI theme: green";
            x = 0.276;
            colorBackground[] = {0.22,0.68,0.36,1};
            action = "[""green""] call RPG_fnc_setUITheme;";
        };
        class ThemeVioletButton: ThemeAmberButton {
            idc = 5094;
            tooltip = "RPG UI theme: violet";
            x = 0.308;
            colorBackground[] = {0.50,0.34,0.82,1};
            action = "[""violet""] call RPG_fnc_setUITheme;";
        };
    };
};

class RPG_SkillTree_Display {
    idd = 7701;
    movingEnable = 1;
    enableSimulation = 1;

    class controlsBackground {
        class BgFrame: RPG_RscText {
            idc = 7100;
            x = 0.035; y = 0.030; w = 0.930; h = 0.925;
            colorBackground[] = {0.015, 0.020, 0.024, 0.96};
        };
        class BgTop: RPG_RscText {
            idc = 7101;
            x = 0.040; y = 0.035; w = 0.920; h = 0.085;
            colorBackground[] = {0.10, 0.025, 0.025, 0.92};
        };
        class BgTreePanel: RPG_RscText {
            idc = 7102;
            x = 0.050; y = 0.145; w = 0.255; h = 0.690;
            colorBackground[] = {0.035, 0.045, 0.050, 0.92};
        };
        class BgPerkPanel: RPG_RscText {
            idc = 7103;
            x = 0.318; y = 0.145; w = 0.325; h = 0.690;
            colorBackground[] = {0.025, 0.030, 0.034, 0.92};
        };
        class BgDetailPanel: RPG_RscText {
            idc = 7104;
            x = 0.656; y = 0.145; w = 0.294; h = 0.690;
            colorBackground[] = {0.040, 0.032, 0.020, 0.92};
        };
        class LineTop: RPG_RscText {
            idc = 7105;
            x = 0.040; y = 0.124; w = 0.920; h = 0.003;
            colorBackground[] = {0.80, 0.20, 0.20, 0.75};
        };
        class LineBottom: RPG_RscText {
            idc = 7106;
            x = 0.040; y = 0.848; w = 0.920; h = 0.003;
            colorBackground[] = {0.78, 0.62, 0.18, 0.75};
        };
    };

    class controls {
        class Title: RPG_RscStructuredText {
            idc = 3000;
            x = 0.052; y = 0.056; w = 0.535; h = 0.060;
            size = 0.040;
        };
        class Points: RPG_RscStructuredText {
            idc = 3001;
            x = 0.602; y = 0.056; w = 0.340; h = 0.060;
            size = 0.030;
        };
        class TreeList: RPG_RscListBox {
            idc = 3002;
            x = 0.062; y = 0.160; w = 0.231; h = 0.660;
            sizeEx = 0.033;
            rowHeight = 0.072;
            onLBSelChanged = "_this call RPG_fnc_selectSkillTree;";
        };
        class PerkList: RPG_RscListBox {
            idc = 3003;
            x = 0.332; y = 0.160; w = 0.298; h = 0.660;
            sizeEx = 0.031;
            rowHeight = 0.053;
            onLBSelChanged = "_this call RPG_fnc_selectPerk;";
        };
        class PerkDetail: RPG_RscStructuredText {
            idc = 3004;
            x = 0.670; y = 0.165; w = 0.264; h = 0.650;
            size = 0.035;
        };

        class InvestTreeButton: RPG_RscButtonMenu {
            idc = 3012;
            text = "УРОВЕНЬ +";
            x = 0.050; y = 0.866; w = 0.185; h = 0.038;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_investSelectedTree;";
        };
        class BuyPerkButton: RPG_RscButtonMenu {
            idc = 3015;
            text = "КУПИТЬ";
            x = 0.250; y = 0.866; w = 0.170; h = 0.038;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_buySelectedPerk;";
        };
        class RefreshButton: RPG_RscButtonMenu {
            idc = 3016;
            text = "ОБНОВИТЬ";
            x = 0.435; y = 0.866; w = 0.190; h = 0.038;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[player] remoteExecCall [""RPG_fnc_syncPlayerPerks"", 2, false]; [] call RPG_fnc_updateSkillTree;";
        };
        class CloseButton: RPG_RscButtonMenu {
            idc = 3017;
            text = "X";
            x = 0.913; y = 0.866; w = 0.037; h = 0.038;
            sizeEx = RPG_BUTTON_SIZE;
            action = "closeDialog 0;";
        };
        class ThemeAmberButton: RPG_RscButtonMenu {
            idc = 3090;
            text = "o";
            tooltip = "RPG UI theme: amber";
            x = 0.050; y = 0.913; w = 0.022; h = 0.030;
            colorBackground[] = {0.78,0.62,0.18,1};
            action = "[""amber""] call RPG_fnc_setUITheme;";
        };
        class ThemeRedButton: ThemeAmberButton {
            idc = 3091;
            tooltip = "RPG UI theme: red";
            x = 0.077;
            colorBackground[] = {0.88,0.16,0.22,1};
            action = "[""red""] call RPG_fnc_setUITheme;";
        };
        class ThemeBlueButton: ThemeAmberButton {
            idc = 3092;
            tooltip = "RPG UI theme: blue";
            x = 0.104;
            colorBackground[] = {0.14,0.54,0.86,1};
            action = "[""blue""] call RPG_fnc_setUITheme;";
        };
        class ThemeGreenButton: ThemeAmberButton {
            idc = 3093;
            tooltip = "RPG UI theme: green";
            x = 0.131;
            colorBackground[] = {0.22,0.68,0.36,1};
            action = "[""green""] call RPG_fnc_setUITheme;";
        };
        class ThemeVioletButton: ThemeAmberButton {
            idc = 3094;
            tooltip = "RPG UI theme: violet";
            x = 0.158;
            colorBackground[] = {0.50,0.34,0.82,1};
            action = "[""violet""] call RPG_fnc_setUITheme;";
        };
    };
};
