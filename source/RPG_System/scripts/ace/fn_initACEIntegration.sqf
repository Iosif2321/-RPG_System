/*
    RPG System - ACE Integration
    Интеграция с ACE3 модом

    Автор: Server Admin
    Версия: 2.0.0
*/

RPG_ACE_Initialized = false;

if (RPG_ACE_Initialized) exitWith {};
if (!isServer) exitWith {};

if (!isNil "ace_medical_isEnabled") then {
    diag_log "[RPG] ACE3 detected, integrating...";

    ["ace_treatmentSucceded", {
        params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem", "_createLitter"];

        if (isNil "_caller" || {isNull _caller} || {!isPlayer _caller}) exitWith {};

        // Применяем бонус навыка intelligence
        private _bonus = [_caller, "intelligence"] call RPG_fnc_getSkillBonus;

        private _classLower = toLower _className;

        if (_classLower in ["ace_suture", "ace_suture_basic"]) exitWith {
            private _baseXP = 40;
            private _actualXP = floor (_baseXP * (1 + _bonus));
            [_caller, _actualXP, "Наложение швов"] call RPG_fnc_addXP;
            [_caller, "intelligence", floor (_actualXP / 2)] call RPG_fnc_addSkillXP;
        };
        if (_classLower in ["ace_tourniquet", "ace_tourniquet_cat"]) exitWith {
            private _baseXP = 20;
            private _actualXP = floor (_baseXP * (1 + _bonus));
            [_caller, _actualXP, "Наложение жгута"] call RPG_fnc_addXP;
            [_caller, "intelligence", floor (_actualXP / 2)] call RPG_fnc_addSkillXP;
        };
        if (_classLower find "morphine" >= 0
            || {_classLower find "epinephrine" >= 0}
            || {_classLower find "adenosine" >= 0}) exitWith {
            private _baseXP = 30;
            private _actualXP = floor (_baseXP * (1 + _bonus));
            [_caller, _actualXP, "Введение препарата"] call RPG_fnc_addXP;
            [_caller, "intelligence", floor (_actualXP / 2)] call RPG_fnc_addSkillXP;
        };
        if (_classLower find "bandage" >= 0 || {_classLower find "packing" >= 0}) exitWith {
            private _baseXP = 15;
            private _actualXP = floor (_baseXP * (1 + _bonus));
            [_caller, _actualXP, "Наложение бинта"] call RPG_fnc_addXP;
            [_caller, "intelligence", floor (_actualXP / 2)] call RPG_fnc_addSkillXP;
        };

        private _baseXP = 10;
        private _actualXP = floor (_baseXP * (1 + _bonus));
        [_caller, _actualXP, format ["Лечение ACE (%1)", _className]] call RPG_fnc_addXP;
        [_caller, "intelligence", floor (_actualXP / 2)] call RPG_fnc_addSkillXP;
    }] call CBA_fnc_addEventHandler;

    ["ace_medical_revived", {
        params ["_patient", "_medic"];

        if (isNil "_medic" || {isNull _medic} || {!isPlayer _medic}) exitWith {};

        // Применяем бонус навыка intelligence
        private _bonus = [_medic, "intelligence"] call RPG_fnc_getSkillBonus;
        private _baseXP = 75;
        private _actualXP = floor (_baseXP * (1 + _bonus));

        [_medic, _actualXP, "Воскрешение ACE"] call RPG_fnc_addXP;
        [_medic, "intelligence", floor (_actualXP / 2)] call RPG_fnc_addSkillXP;

        private _medicID = getPlayerUID _medic;
        private _data = [_medicID] call RPG_fnc_getPlayerData;
        private _stats = _data get "stats";
        _stats set ["revives", (_stats getOrDefault ["revives", 0]) + 1];
        [_medicID, _data] call RPG_fnc_setPlayerData;

        diag_log format ["[RPG] %1 revived %2 for %3 XP (bonus: %.0f%%)", name _medic, name _patient, _actualXP, _bonus * 100];
    }] call CBA_fnc_addEventHandler;

    RPG_ACE_Initialized = true;
    diag_log "[RPG] ACE3 integration complete";
} else {
    diag_log "[RPG] ACE3 not detected, skipping integration";
};
