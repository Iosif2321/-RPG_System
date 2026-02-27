/*
    RPG System - On Vehicle Destroyed
    Обработка уничтожения техники
*/

params ["_killer", "_vehicle"];

if (!isServer) exitWith {0};

if (isNil "_killer" || {isNull _killer} || {!isPlayer _killer}) exitWith {0};

private _killerID = getPlayerUID _killer;
private _data = [_killerID] call RPG_fnc_getPlayerData;

// Определяем тип техники и начисляем XP
private _xpAmount = 0;
private _source = "";

if (_vehicle isKindOf "Tank") then {
    _xpAmount = RPG_XP_CONFIG getOrDefault ["vehicle_destroy_heavy", 200];
    _source = "Уничтожение танка";
} else {
    if (_vehicle isKindOf "Air") then {
        _xpAmount = RPG_XP_CONFIG getOrDefault ["vehicle_destroy_air", 250];
        _source = "Уничтожение авиации";
    } else {
        if (_vehicle isKindOf "Car") then {
            _xpAmount = RPG_XP_CONFIG getOrDefault ["vehicle_destroy_light", 100];
            _source = "Уничтожение техники";
        };
    };
};

if (_xpAmount > 0) then {
    // Обновляем статистику
    private _stats = _data get "stats";
    private _vehiclesDestroyed = _stats getOrDefault ["vehiclesDestroyed", 0];
    _stats set ["vehiclesDestroyed", _vehiclesDestroyed + 1];
    
    [_killer, _xpAmount, _source] call RPG_fnc_addXP;
    
    diag_log format ["[RPG] %1 destroyed %2 for %3 XP", name _killer, _source, _xpAmount];
};

_xpAmount
