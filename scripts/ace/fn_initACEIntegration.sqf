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
        
        // Обработчик лечения ACE
        ["ace_medical_treated", {
            params ["_target", "_healer", "_success", "_amountHealed"];
            
            if (_success && {!isNil "_healer" && {isPlayer _healer}}) then {
                [_healer, 25, "Лечение ACE"] call RPG_fnc_addXP;
                
                // Обновляем статистику
                private _healerID = getPlayerUID _healer;
                private _data = [_healerID] call RPG_fnc_getPlayerData;
                private _stats = _data get "stats";
                private _heals = _stats getOrDefault ["heals", 0];
                _stats set ["heals", _heals + 1];
                [_healerID, _data] call RPG_fnc_setPlayerData;
            };
        }] call CBA_fnc_addEventHandler;
        
        // Обработчик воскрешения ACE
        ["ace_medical_revived", {
            params ["_revived", "_reviver"];
            
            if (!isNil "_reviver" && {isPlayer _reviver}) then {
                [_reviver, 75, "Воскрешение ACE"] call RPG_fnc_addXP;
                
                // Обновляем статистику
                private _reviverID = getPlayerUID _reviver;
                private _data = [_reviverID] call RPG_fnc_getPlayerData;
                private _stats = _data get "stats";
                private _revives = _stats getOrDefault ["revives", 0];
                _stats set ["revives", _revives + 1];
                [_reviverID, _data] call RPG_fnc_setPlayerData;
                
                diag_log format ["[RPG] %1 revived %2 for 75 XP", name _reviver, name _revived];
            };
        }] call CBA_fnc_addEventHandler;
        
        // Обработчик использования бинтов
        ["ace_medical_bandaged", {
            params ["_target", "_healer", "_success", "_type"];
            
            if (_success && {!isNil "_healer" && {isPlayer _healer}}) then {
                [_healer, 15, "Наложение бинта"] call RPG_fnc_addXP;
            };
        }] call CBA_fnc_addEventHandler;
        
        // Обработчик использования жгутов
        ["ace_medical_tourniqueted", {
            params ["_target", "_healer", "_success", "_type"];
            
            if (_success && {!isNil "_healer" && {isPlayer _healer}}) then {
                [_healer, 20, "Наложение жгута"] call RPG_fnc_addXP;
            };
        }] call CBA_fnc_addEventHandler;
        
        // Обработчик использования шприцов
        ["ace_medical_injected", {
            params ["_target", "_healer", "_success", "_item"];
            
            if (_success && {!isNil "_healer" && {isPlayer _healer}}) then {
                [_healer, 30, "Введение препарата"] call RPG_fnc_addXP;
            };
        }] call CBA_fnc_addEventHandler;
        
        // Обработчик хирургии
        ["ace_medical_sutured", {
            params ["_target", "_healer", "_success"];
            
            if (_success && {!isNil "_healer" && {isPlayer _healer}}) then {
                [_healer, 40, "Наложение швов"] call RPG_fnc_addXP;
            };
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
