/*
    RPG System - On Entity Killed
    Обработка убийства сущности (пехота)
*/

params ["_killer", "_killed"];

if (!isServer) exitWith {0};

if (isNil "_killer" || {isNull _killer} || {!isPlayer _killer}) exitWith {0};

private _killerID = getPlayerUID _killer;
private _data = [_killerID] call RPG_fnc_getPlayerData;

// Определяем тип цели и начисляем XP
private _xpAmount = 0;
private _source = "";

if (_killed isKindOf "Man") then {
    // Убийство пехоты
    if (side _killed in [east, west, independent]) then {
        _xpAmount = RPG_XP_CONFIG getOrDefault ["kill_infantry", 50];
        _source = "Убийство";
        
        // Обновляем статистику
        private _stats = _data get "stats";
        private _kills = _stats getOrDefault ["kills", 0];
        _stats set ["kills", _kills + 1];
    };
};

if (_xpAmount > 0) then {
    [_killer, _xpAmount, _source] call RPG_fnc_addXP;
    
    diag_log format ["[RPG] %1 killed enemy for %2 XP", name _killer, _xpAmount];
};

_xpAmount
