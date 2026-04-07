/*
    RPG System - RscDialogs (v2.0 — Cyberpunk 2077 Skill Tree)
    Диалоги и GUI
*/

class RPG_Menu_Display {
    idd = 7700;
    movingEnable = 1;
    enableSimulation = 1;

    class controlsBackground {
        class RscTitleBackground: RPG_RscText {
            idc = -1;
            x = 0.25;
            y = 0.18;
            w = 0.5;
            h = 0.05;
            colorBackground[] = RPG_COLOR_PRIMARY;
        };

        class RscBackground: RPG_RscText {
            idc = -1;
            x = 0.25;
            y = 0.23;
            w = 0.5;
            h = 0.52;
            colorBackground[] = RPG_COLOR_SECONDARY;
        };
    };

    class controls {
        class RscTitle: RPG_RscText {
            idc = -1;
            text = "RPG Система";
            x = 0.25;
            y = 0.18;
            w = 0.5;
            h = 0.05;
            sizeEx = RPG_TITLE_SIZE;
            colorText[] = RPG_COLOR_TEXT;
        };

        class RscXPText: RPG_RscText {
            idc = 1001;
            text = "XP: 0 / 1000";
            x = 0.26;
            y = 0.24;
            w = 0.48;
            h = 0.04;
            sizeEx = RPG_TEXT_SIZE;
            colorText[] = RPG_COLOR_TEXT;
        };

        class RscLevelText: RPG_RscText {
            idc = 1002;
            text = "Уровень: 1";
            x = 0.26;
            y = 0.28;
            w = 0.48;
            h = 0.04;
            sizeEx = RPG_TEXT_SIZE;
            colorText[] = RPG_COLOR_TEXT;
        };

        class RscProgressBar: RPG_RscProgress {
            idc = 1003;
            x = 0.26;
            y = 0.32;
            w = 0.48;
            h = 0.03;
            texture = "#(argb,8,8,3)color(1,1,1,1)";
            colorFrame[] = RPG_COLOR_PRIMARY;
        };

        class RscStatsText: RPG_RscStructuredText {
            idc = 1004;
            x = 0.26;
            y = 0.36;
            w = 0.48;
            h = 0.12;
            size = RPG_TEXT_SIZE;
        };

        class RscSkillsText: RPG_RscStructuredText {
            idc = 1005;
            x = 0.26;
            y = 0.47;
            w = 0.48;
            h = 0.15;
            size = RPG_TEXT_SIZE;
        };

        class RscRefreshButton: RPG_RscButtonMenu {
            idc = 1007;
            text = "Обновить";
            x = 0.25;
            y = 0.66;
            w = 0.15;
            h = 0.04;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_updateRPGMenu;";
        };

        class RscSkillTreeButton: RPG_RscButtonMenu {
            idc = 1008;
            text = "Древо навыков";
            x = 0.40;
            y = 0.66;
            w = 0.19;
            h = 0.04;
            sizeEx = RPG_BUTTON_SIZE;
            action = "[] call RPG_fnc_openSkillTree;";
        };

        class RscCloseButton: RPG_RscButtonMenu {
            idc = 1006;
            text = "Закрыть";
            x = 0.60;
            y = 0.66;
            w = 0.15;
            h = 0.04;
            sizeEx = RPG_BUTTON_SIZE;
            action = "closeDialog 0;";
        };
    };
};

// ─── Древо навыков (IDD 7701) — 5 колонок атрибутов ──────────────
class RPG_SkillTree_Display {
    idd = 7701;
    movingEnable = 1;
    enableSimulation = 1;

    class controlsBackground {
        class ST_TitleBg: RPG_RscText {
            idc = -1;
            x = 0.05;
            y = 0.1;
            w = 0.9;
            h = 0.05;
            colorBackground[] = RPG_COLOR_PRIMARY;
        };

        class ST_Bg: RPG_RscText {
            idc = -1;
            x = 0.05;
            y = 0.15;
            w = 0.9;
            h = 0.70;
            colorBackground[] = RPG_COLOR_SECONDARY;
        };
    };

    class controls {
        class ST_Title: RPG_RscText {
            idc = -1;
            text = "Древо навыков";
            x = 0.05;
            y = 0.1;
            w = 0.9;
            h = 0.05;
            sizeEx = RPG_TITLE_SIZE;
            colorText[] = RPG_COLOR_TEXT;
        };

        // ─── Подсказка ─────────────────────────────────────────
        class ST_Hint: RPG_RscText {
            idc = -1;
            text = "Каждые 1000 XP атрибута = +1 уровень. На уровнях 3/7 доступны специализации.";
            x = 0.06;
            y = 0.155;
            w = 0.88;
            h = 0.03;
            sizeEx = 0.028;
            colorText[] = {0.7, 0.7, 0.7, 1};
        };

        // ═══ CONSTITUTION ═══
        class ST_ConstBg: RPG_RscText {
            idc = -1;
            x = 0.06;
            y = 0.19;
            w = 0.17;
            h = 0.55;
            colorBackground[] = {0.08, 0.02, 0.02, 0.6};
        };
        class ST_ConstTitle: RPG_RscStructuredText {
            idc = 3000;
            x = 0.06;
            y = 0.19;
            w = 0.17;
            h = 0.06;
        };
        class ST_ConstLevel: RPG_RscStructuredText {
            idc = 3001;
            x = 0.06;
            y = 0.25;
            w = 0.17;
            h = 0.04;
        };
        class ST_ConstBranch1: RPG_RscStructuredText {
            idc = 3002;
            x = 0.06;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_ConstBranch2: RPG_RscStructuredText {
            idc = 3003;
            x = 0.15;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_ConstBonus: RPG_RscStructuredText {
            idc = 3004;
            x = 0.06;
            y = 0.61;
            w = 0.17;
            h = 0.04;
        };

        // ═══ REFLEXES ═══
        class ST_RefBg: RPG_RscText {
            idc = -1;
            x = 0.24;
            y = 0.19;
            w = 0.17;
            h = 0.55;
            colorBackground[] = {0.06, 0.05, 0.01, 0.6};
        };
        class ST_RefTitle: RPG_RscStructuredText {
            idc = 3005;
            x = 0.24;
            y = 0.19;
            w = 0.17;
            h = 0.06;
        };
        class ST_RefLevel: RPG_RscStructuredText {
            idc = 3006;
            x = 0.24;
            y = 0.25;
            w = 0.17;
            h = 0.04;
        };
        class ST_RefBranch1: RPG_RscStructuredText {
            idc = 3007;
            x = 0.24;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_RefBranch2: RPG_RscStructuredText {
            idc = 3008;
            x = 0.33;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_RefBonus: RPG_RscStructuredText {
            idc = 3009;
            x = 0.24;
            y = 0.61;
            w = 0.17;
            h = 0.04;
        };

        // ═══ TECHNICAL ═══
        class ST_TechBg: RPG_RscText {
            idc = -1;
            x = 0.42;
            y = 0.19;
            w = 0.17;
            h = 0.55;
            colorBackground[] = {0.06, 0.03, 0.01, 0.6};
        };
        class ST_TechTitle: RPG_RscStructuredText {
            idc = 3010;
            x = 0.42;
            y = 0.19;
            w = 0.17;
            h = 0.06;
        };
        class ST_TechLevel: RPG_RscStructuredText {
            idc = 3011;
            x = 0.42;
            y = 0.25;
            w = 0.17;
            h = 0.04;
        };
        class ST_TechBranch1: RPG_RscStructuredText {
            idc = 3012;
            x = 0.42;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_TechBranch2: RPG_RscStructuredText {
            idc = 3013;
            x = 0.51;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_TechBonus: RPG_RscStructuredText {
            idc = 3014;
            x = 0.42;
            y = 0.61;
            w = 0.17;
            h = 0.04;
        };

        // ═══ INTELLIGENCE ═══
        class ST_IntelBg: RPG_RscText {
            idc = -1;
            x = 0.60;
            y = 0.19;
            w = 0.17;
            h = 0.55;
            colorBackground[] = {0.01, 0.03, 0.06, 0.6};
        };
        class ST_IntelTitle: RPG_RscStructuredText {
            idc = 3015;
            x = 0.60;
            y = 0.19;
            w = 0.17;
            h = 0.06;
        };
        class ST_IntelLevel: RPG_RscStructuredText {
            idc = 3016;
            x = 0.60;
            y = 0.25;
            w = 0.17;
            h = 0.04;
        };
        class ST_IntelBranch1: RPG_RscStructuredText {
            idc = 3017;
            x = 0.60;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_IntelBranch2: RPG_RscStructuredText {
            idc = 3018;
            x = 0.69;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_IntelBonus: RPG_RscStructuredText {
            idc = 3019;
            x = 0.60;
            y = 0.61;
            w = 0.17;
            h = 0.04;
        };

        // ═══ COOL ═══
        class ST_CoolBg: RPG_RscText {
            idc = -1;
            x = 0.78;
            y = 0.19;
            w = 0.17;
            h = 0.55;
            colorBackground[] = {0.03, 0.01, 0.06, 0.6};
        };
        class ST_CoolTitle: RPG_RscStructuredText {
            idc = 3020;
            x = 0.78;
            y = 0.19;
            w = 0.17;
            h = 0.06;
        };
        class ST_CoolLevel: RPG_RscStructuredText {
            idc = 3021;
            x = 0.78;
            y = 0.25;
            w = 0.17;
            h = 0.04;
        };
        class ST_CoolBranch1: RPG_RscStructuredText {
            idc = 3022;
            x = 0.78;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_CoolBranch2: RPG_RscStructuredText {
            idc = 3023;
            x = 0.87;
            y = 0.29;
            w = 0.08;
            h = 0.30;
        };
        class ST_CoolBonus: RPG_RscStructuredText {
            idc = 3024;
            x = 0.78;
            y = 0.61;
            w = 0.17;
            h = 0.04;
        };

        // ─── Кнопка закрытия ───────────────────────────────────
        class ST_CloseButton: RPG_RscButtonMenu {
            idc = 3025;
            text = "Закрыть";
            x = 0.75;
            y = 0.76;
            w = 0.20;
            h = 0.04;
            sizeEx = RPG_BUTTON_SIZE;
            action = "closeDialog 0;";
        };
    };
};
