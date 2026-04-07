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
            idc = -1;
            x = 0.200; y = 0.075; w = 0.600; h = 0.855;
            colorBackground[] = RPG_COLOR_DARK_FRAME;
        };
        // Пергаментный фон
        class BgParchment: RPG_RscText {
            idc = -1;
            x = 0.203; y = 0.078; w = 0.594; h = 0.849;
            colorBackground[] = RPG_COLOR_PARCHMENT;
        };

        // ╔══════════════════════════════════════╗
        //   ВЕРХНИЙ БАННЕР (свиток)
        // ╚══════════════════════════════════════╝
        class BgBanner: RPG_RscText {
            idc = -1;
            x = 0.203; y = 0.078; w = 0.594; h = 0.094;
            colorBackground[] = RPG_COLOR_DARK_BANNER;
        };
        class BgGoldTop: RPG_RscText {
            idc = -1;
            x = 0.203; y = 0.172; w = 0.594; h = 0.004;
            colorBackground[] = RPG_COLOR_GOLD;
        };

        // Полоска с уровнем и XP (светлая)
        class BgInfoStrip: RPG_RscText {
            idc = -1;
            x = 0.203; y = 0.176; w = 0.594; h = 0.058;
            colorBackground[] = {0.80, 0.73, 0.56, 0.85};
        };

        // ╔══════════════════════════════════════╗
        //   ВЕРТИКАЛЬНЫЙ РАЗДЕЛИТЕЛЬ КОЛОНОК
        // ╚══════════════════════════════════════╝
        class BgColDivider: RPG_RscText {
            idc = -1;
            x = 0.392; y = 0.237; w = 0.004; h = 0.596;
            colorBackground[] = RPG_COLOR_RED_HEADER;
        };

        // ╔══════════════════════════════════════╗
        //   ЛЕВАЯ КОЛОНКА — ХАРАКТЕРИСТИКИ
        // ╚══════════════════════════════════════╝

        // Шапка левой колонки
        class BgAttrHeader: RPG_RscText {
            idc = -1;
            x = 0.203; y = 0.237; w = 0.189; h = 0.028;
            colorBackground[] = RPG_COLOR_RED_HEADER;
        };

        // Блок атрибута 1 — БОЙ (y=0.267)
        class BgAB1: RPG_RscText { idc=-1; x=0.205; y=0.267; w=0.185; h=0.110; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF1: RPG_RscText { idc=-1; x=0.207; y=0.269; w=0.181; h=0.106; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // Блок атрибута 2 — МЕДИЦИНА (y=0.381)
        class BgAB2: RPG_RscText { idc=-1; x=0.205; y=0.381; w=0.185; h=0.110; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF2: RPG_RscText { idc=-1; x=0.207; y=0.383; w=0.181; h=0.106; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // Блок атрибута 3 — РЕМОНТ (y=0.495)
        class BgAB3: RPG_RscText { idc=-1; x=0.205; y=0.495; w=0.185; h=0.110; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF3: RPG_RscText { idc=-1; x=0.207; y=0.497; w=0.181; h=0.106; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // Блок атрибута 4 — ПОДДЕРЖКА (y=0.609)
        class BgAB4: RPG_RscText { idc=-1; x=0.205; y=0.609; w=0.185; h=0.110; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF4: RPG_RscText { idc=-1; x=0.207; y=0.611; w=0.181; h=0.106; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // Блок атрибута 5 — ИНЖЕНЕРИЯ (y=0.723)
        class BgAB5: RPG_RscText { idc=-1; x=0.205; y=0.723; w=0.185; h=0.110; colorBackground[] = RPG_COLOR_RED_HEADER; };
        class BgAF5: RPG_RscText { idc=-1; x=0.207; y=0.725; w=0.181; h=0.106; colorBackground[] = RPG_COLOR_ATTR_BOX; };

        // ╔══════════════════════════════════════╗
        //   ПРАВАЯ КОЛОНКА — БОЕВОЙ ПРОФИЛЬ
        // ╚══════════════════════════════════════╝

        // Шапка правой колонки
        class BgRightHeader: RPG_RscText {
            idc = -1;
            x = 0.398; y = 0.237; w = 0.396; h = 0.028;
            colorBackground[] = {0.20, 0.12, 0.06, 0.95};
        };

        // — СЕКЦИЯ 1: Боевая статистика (красная) —
        class BgS1Header: RPG_RscText {
            idc=-1; x=0.398; y=0.267; w=0.396; h=0.028;
            colorBackground[] = {0.52, 0.10, 0.10, 0.95};
        };
        // 3 ячейки: Убийства | Смерти | K/D
        // ширина ячейки=0.122, зазор=0.013
        class BgS1B1: RPG_RscText { idc=-1; x=0.400; y=0.297; w=0.122; h=0.080; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS1F1: RPG_RscText { idc=-1; x=0.402; y=0.299; w=0.118; h=0.076; colorBackground[] = RPG_COLOR_PARCHMENT; };
        class BgS1B2: RPG_RscText { idc=-1; x=0.535; y=0.297; w=0.122; h=0.080; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS1F2: RPG_RscText { idc=-1; x=0.537; y=0.299; w=0.118; h=0.076; colorBackground[] = RPG_COLOR_PARCHMENT; };
        class BgS1B3: RPG_RscText { idc=-1; x=0.670; y=0.297; w=0.122; h=0.080; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS1F3: RPG_RscText { idc=-1; x=0.672; y=0.299; w=0.118; h=0.076; colorBackground[] = RPG_COLOR_PARCHMENT; };

        // — СЕКЦИЯ 2: Боевые действия (оранжевая) —
        class BgS2Header: RPG_RscText {
            idc=-1; x=0.398; y=0.383; w=0.396; h=0.028;
            colorBackground[] = {0.58, 0.32, 0.07, 0.95};
        };
        // 3 ячейки: Воскрешения | Ремонты | Часов
        class BgS2B1: RPG_RscText { idc=-1; x=0.400; y=0.413; w=0.122; h=0.080; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS2F1: RPG_RscText { idc=-1; x=0.402; y=0.415; w=0.118; h=0.076; colorBackground[] = RPG_COLOR_PARCHMENT; };
        class BgS2B2: RPG_RscText { idc=-1; x=0.535; y=0.413; w=0.122; h=0.080; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS2F2: RPG_RscText { idc=-1; x=0.537; y=0.415; w=0.118; h=0.076; colorBackground[] = RPG_COLOR_PARCHMENT; };
        class BgS2B3: RPG_RscText { idc=-1; x=0.670; y=0.413; w=0.122; h=0.080; colorBackground[] = RPG_COLOR_DARK_TEXT; };
        class BgS2F3: RPG_RscText { idc=-1; x=0.672; y=0.415; w=0.118; h=0.076; colorBackground[] = RPG_COLOR_PARCHMENT; };

        // — СЕКЦИЯ 3: Опыт по категориям (синяя) —
        class BgS3Header: RPG_RscText {
            idc=-1; x=0.398; y=0.499; w=0.396; h=0.028;
            colorBackground[] = {0.10, 0.22, 0.42, 0.95};
        };
        class BgS3Content: RPG_RscText {
            idc=-1; x=0.398; y=0.527; w=0.396; h=0.306;
            colorBackground[] = {0.81, 0.74, 0.57, 0.70};
        };

        // ╔══════════════════════════════════════╗
        //   НИЖНЯЯ ПАНЕЛЬ С КНОПКАМИ
        // ╚══════════════════════════════════════╝
        class BgGoldBot1: RPG_RscText { idc=-1; x=0.203; y=0.838; w=0.594; h=0.004; colorBackground[] = RPG_COLOR_GOLD; };
        class BgBannerBot: RPG_RscText { idc=-1; x=0.203; y=0.842; w=0.594; h=0.038; colorBackground[] = RPG_COLOR_DARK_BANNER; };
        class BgGoldBot2: RPG_RscText { idc=-1; x=0.203; y=0.880; w=0.594; h=0.004; colorBackground[] = RPG_COLOR_GOLD; };
    };

    class controls {

        // ╔══════════════════════════════════════╗
        //   ВЕРХНИЙ БАННЕР
        // ╚══════════════════════════════════════╝
        class TitleLabel: RPG_RscText {
            idc = -1;
            text = "ЛИСТ ПЕРСОНАЖА";
            x = 0.203; y = 0.082; w = 0.594; h = 0.028;
            sizeEx = RPG_TITLE_SIZE;
            style = 2;
            colorText[] = RPG_COLOR_LIGHT_TEXT;
        };
        // Имя игрока — большое, золотом
        class PlayerName: RPG_RscText {
            idc = 1000;
            text = "ИГРОК";
            x = 0.203; y = 0.112; w = 0.594; h = 0.052;
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
            x = 0.208; y = 0.181; w = 0.280; h = 0.024;
            sizeEx = RPG_TEXT_SIZE;
            colorText[] = RPG_COLOR_DARK_TEXT;
        };
        class XPText: RPG_RscText {
            idc = 1001;
            text = "ОПЫТ: 0 / 1000";
            x = 0.500; y = 0.181; w = 0.292; h = 0.024;
            sizeEx = RPG_TEXT_SIZE;
            style = 1;
            colorText[] = RPG_COLOR_DARK_TEXT;
        };
        class XPBar: RPG_RscProgress {
            idc = 1003;
            x = 0.208; y = 0.208; w = 0.585; h = 0.020;
        };

        // ╔══════════════════════════════════════╗
        //   ЛЕВАЯ КОЛОНКА — ХАРАКТЕРИСТИКИ
        // ╚══════════════════════════════════════╝
        class AttrColTitle: RPG_RscText {
            idc = -1;
            text = "ХАРАКТЕРИСТИКИ";
            x = 0.203; y = 0.237; w = 0.189; h = 0.028;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = {1, 1, 1, 1};
        };

        // Блоки атрибутов (IDC 1010-1014)
        // Каждый: большое число-очки + модификатор + название
        class AttrCombat: RPG_RscStructuredText {
            idc = 1010;
            x = 0.207; y = 0.269; w = 0.181; h = 0.106;
            size = RPG_TEXT_SIZE;
        };
        class AttrMedical: RPG_RscStructuredText {
            idc = 1011;
            x = 0.207; y = 0.383; w = 0.181; h = 0.106;
            size = RPG_TEXT_SIZE;
        };
        class AttrRepair: RPG_RscStructuredText {
            idc = 1012;
            x = 0.207; y = 0.497; w = 0.181; h = 0.106;
            size = RPG_TEXT_SIZE;
        };
        class AttrSupport: RPG_RscStructuredText {
            idc = 1013;
            x = 0.207; y = 0.611; w = 0.181; h = 0.106;
            size = RPG_TEXT_SIZE;
        };
        class AttrEngineering: RPG_RscStructuredText {
            idc = 1014;
            x = 0.207; y = 0.725; w = 0.181; h = 0.106;
            size = RPG_TEXT_SIZE;
        };

        // ╔══════════════════════════════════════╗
        //   ПРАВАЯ КОЛОНКА — БОЕВОЙ ПРОФИЛЬ
        // ╚══════════════════════════════════════╝
        class RightColTitle: RPG_RscText {
            idc = -1;
            text = "БОЕВОЙ ПРОФИЛЬ";
            x = 0.398; y = 0.237; w = 0.396; h = 0.028;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = RPG_COLOR_LIGHT_TEXT;
        };

        // — СЕКЦИЯ 1: Боевая статистика (красная) —
        class S1Title: RPG_RscText {
            idc = -1;
            text = "БОЕВАЯ СТАТИСТИКА";
            x = 0.398; y = 0.267; w = 0.396; h = 0.028;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = {1, 1, 1, 1};
        };
        // Подписи ячеек (статичные)
        class S1L1: RPG_RscText { idc=-1; text="УБИЙСТВА";  x=0.402; y=0.300; w=0.118; h=0.020; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.52,0.10,0.10,1}; };
        class S1L2: RPG_RscText { idc=-1; text="СМЕРТИ";    x=0.537; y=0.300; w=0.118; h=0.020; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.52,0.10,0.10,1}; };
        class S1L3: RPG_RscText { idc=-1; text="K / D";     x=0.672; y=0.300; w=0.118; h=0.020; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.52,0.10,0.10,1}; };
        // Значения ячеек (динамические)
        class S1V1: RPG_RscText { idc=1020; text="0"; x=0.402; y=0.322; w=0.118; h=0.050; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };
        class S1V2: RPG_RscText { idc=1021; text="0"; x=0.537; y=0.322; w=0.118; h=0.050; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };
        class S1V3: RPG_RscText { idc=1022; text="0"; x=0.672; y=0.322; w=0.118; h=0.050; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };

        // — СЕКЦИЯ 2: Боевые действия (оранжевая) —
        class S2Title: RPG_RscText {
            idc = -1;
            text = "БОЕВЫЕ ДЕЙСТВИЯ";
            x = 0.398; y = 0.383; w = 0.396; h = 0.028;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = {1, 1, 1, 1};
        };
        class S2L1: RPG_RscText { idc=-1; text="ВОСКРЕШЕНИЙ"; x=0.402; y=0.415; w=0.118; h=0.020; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.58,0.32,0.07,1}; };
        class S2L2: RPG_RscText { idc=-1; text="РЕМОНТОВ";    x=0.537; y=0.415; w=0.118; h=0.020; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.58,0.32,0.07,1}; };
        class S2L3: RPG_RscText { idc=-1; text="ЧАСОВ В ИГРЕ"; x=0.672; y=0.415; w=0.118; h=0.020; sizeEx=RPG_SMALL_SIZE; style=2; colorText[]={0.58,0.32,0.07,1}; };
        class S2V1: RPG_RscText { idc=1023; text="0"; x=0.402; y=0.438; w=0.118; h=0.050; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };
        class S2V2: RPG_RscText { idc=1024; text="0"; x=0.537; y=0.438; w=0.118; h=0.050; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };
        class S2V3: RPG_RscText { idc=1025; text="0"; x=0.672; y=0.438; w=0.118; h=0.050; sizeEx=0.042; style=2; colorText[]=RPG_COLOR_DARK_TEXT; };

        // — СЕКЦИЯ 3: Опыт по категориям (синяя) —
        class S3Title: RPG_RscText {
            idc = -1;
            text = "ОПЫТ ПО КАТЕГОРИЯМ";
            x = 0.398; y = 0.499; w = 0.396; h = 0.028;
            sizeEx = RPG_SECTION_SIZE;
            style = 2;
            colorText[] = {1, 1, 1, 1};
        };
        class SkillsText: RPG_RscStructuredText {
            idc = 1005;
            x = 0.402; y = 0.530; w = 0.390; h = 0.300;
            size = RPG_TEXT_SIZE;
        };

        // ╔══════════════════════════════════════╗
        //   КНОПКИ В НИЖНЕМ БАННЕРЕ
        // ╚══════════════════════════════════════╝
        class RefreshButton: RPG_RscButtonMenu {
            idc = 1007;
            text = "ОБНОВИТЬ";
            x = 0.208; y = 0.848; w = 0.175; h = 0.026;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_updateRPGMenu;";
        };
        class CloseButton: RPG_RscButtonMenu {
            idc = 1006;
            text = "ЗАКРЫТЬ";
            x = 0.617; y = 0.848; w = 0.175; h = 0.026;
            sizeEx = RPG_BUTTON_SIZE;
            action = "closeDialog 0;";
        };
    };
};
