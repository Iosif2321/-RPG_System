/*
    RPG System - ACE Integration
    Интеграция с ACE3 модом
    
    Автор: Server Admin
    Версия: 1.0.0
*/

// Глобальные переменные
RPG_ACE_Initialized = false;

// Инициализация ACE интеграции
RPG_fnc_initACEIntegration = {
    if (RPG_ACE_Initialized) exitWith {};
    if (!isServer) exitWith {};
    
    // Проверяем наличие ACE
    if (!isNil "ace_medical_isEnabled") then {
        diag_log "[RPG] ACE3 detected, integrating...";

        // ace_medical_treated, ace_medical_bandaged и др. не являются публичными событиями ACE3.
        // Официальные события: ace_treatmentSucceded / ace_treatmentFailed / ace_treatmentStarted
        // Параметры ace_treatmentSucceded: [_caller, _target, _selectionName, _className, _itemUser, _usedItem, _createLitter]

        // Единый обработчик успешного лечения — фильтруем по className
        ["ace_treatmentSucceded", {
            params ["_caller", "_target", "_selectionName", "_className", "_itemUser", "_usedItem", "_createLitter"];

            if (isNil "_caller" || {isNull _caller} || {!isPlayer _caller}) exitWith {};

            // Определяем XP и источник по типу лечения
            private _xpAmount = 0;
            private _source = "";
            private _classLower = toLower _className;

            // Хирургические швы
            if (_classLower in ["ace_suture", "ace_suture_basic"]) exitWith {
                _xpAmount = 40;
                _source = "Наложение швов";
            };
            // Жгуты
            if (_classLower in ["ace_tourniquet", "ace_tourniquet_cat"]) exitWith {
                _xpAmount = 20;
                _source = "Наложение жгута";
            };
            // Инъекции / препараты
            if (_classLower find "morphine" >= 0
                || {_classLower find "epinephrine" >= 0}
                || {_classLower find "adenosine" >= 0}) exitWith {
                _xpAmount = 30;
                _source = "Введение препарата";
            };
            // Бинты (bandage)
            if (_classLower find "bandage" >= 0 || {_classLower find "packing" >= 0}) exitWith {
                _xpAmount = 15;
                _source = "Наложение бинта";
            };
            // Прочие действия
            _xpAmount = 10;
            _source = format ["Лечение ACE (%1)", _className];

            if (_xpAmount > 0) then {
                [_caller, _xpAmount, _source, "skill_medical"] call RPG_fnc_addXP;
                [_caller, "medical", floor (_xpAmount / 2)] call RPG_fnc_addSkillXP;

                // Обновляем статистику
                private _callerID = getPlayerUID _caller;
                private _data = [_callerID] call RPG_fnc_getPlayerData;
                private _stats = _data get "stats";
                _stats set ["revives", (_stats getOrDefault ["revives", 0])];
                [_callerID, _data] call RPG_fnc_setPlayerData;
            };
        }] call CBA_fnc_addEventHandler;

        // Воскрешение — ace_medical_revived подтверждено в большинстве версий ACE3
        // Параметры: [_patient, _medic]
        ["ace_medical_revived", {
            params ["_patient", "_medic"];

            if (isNil "_medic" || {isNull _medic} || {!isPlayer _medic}) exitWith {};

            [_medic, 75, "Воскрешение ACE", "skill_medical"] call RPG_fnc_addXP;
            [_medic, "medical", 50] call RPG_fnc_addSkillXP;

            // Обновляем статистику
            private _medicID = getPlayerUID _medic;
            private _data = [_medicID] call RPG_fnc_getPlayerData;
            private _stats = _data get "stats";
            _stats set ["revives", (_stats getOrDefault ["revives", 0]) + 1];
            [_medicID, _data] call RPG_fnc_setPlayerData;

            diag_log format ["[RPG] %1 revived %2 for 75 XP", name _medic, name _patient];
        }] call CBA_fnc_addEventHandler;

        RPG_ACE_Initialized = true;
        diag_log "[RPG] ACE3 integration complete";
    } else {
        diag_log "[RPG] ACE3 not detected, skipping integration";
    };
};

// Обработчик ACE медицины (вызывается из events)
RPG_fnc_onACEMedical = {
    params ["_healer", "_target", "_action"];
    
    private _xpAmount = switch (_action) do {
        case "bandage": {15};
        case "tourniquet": {20};
        case "inject": {30};
        case "suture": {40};
        case "revive": {75};
        default {10};
    };
    
    [_healer, _xpAmount, format ["ACE %1", _action], "skill_medical"] call RPG_fnc_addXP;
};

