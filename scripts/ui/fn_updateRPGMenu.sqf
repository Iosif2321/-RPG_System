/*
    RPG System - Update RPG Menu
    Обновляет данные в меню RPG
*/

private _display = uiNamespace getVariable ["RPG_Menu_Display", displayNull];
if (isNull _display) exitWith {};

private _player = uiNamespace getVariable ["RPG_CurrentPlayer", player];
if (isNull _player) exitWith {};

// Получаем данные игрока
private _playerID = getPlayerUID _player;
private _data = [_playerID] call RPG_fnc_getPlayerData;

// Обновляем элементы UI
private _xpText = _display displayCtrl 1001;
private _levelText = _display displayCtrl 1002;
private _progressBar = _display displayCtrl 1003;
private _statsText = _display displayCtrl 1004;
private _skillsText = _display displayCtrl 1005;

if (!isNull _xpText) then {
    private _currentXP = _data get "xp";
    private _nextXP = [_data get "level"] call RPG_fnc_getNextLevelXP;
    _xpText ctrlSetText format ["XP: %1 / %2", _currentXP, _nextXP];
};

if (!isNull _levelText) then {
    _levelText ctrlSetText format ["Уровень: %1", _data get "level"];
};

if (!isNull _progressBar) then {
    private _progress = [_player] call RPG_fnc_getProgressToNextLevel;
    _progressBar progressSetPosition _progress;
};

if (!isNull _statsText) then {
    private _stats = _data get "stats";
    
    private _statsString = "=== СТАТИСТИКА ===\n";
    _statsString = _statsString + format ["Убийства: %1\n", _stats getOrDefault ["kills", 0]];
    _statsString = _statsString + format ["Смерти: %1\n", _stats getOrDefault ["deaths", 0]];
    _statsString = _statsString + format ["Воскрешений: %1\n", _stats getOrDefault ["revives", 0]];
    _statsString = _statsString + format ["Ремонтов: %1\n", _stats getOrDefault ["repairs", 0]];
    _statsString = _statsString + format ["Уничтожено техники: %1\n", _stats getOrDefault ["vehiclesDestroyed", 0]];
    _statsString = _statsString + format ["Время в игре: %1 ч\n", round ((_stats getOrDefault ["playtime", 0]) / 3600)];
    
    _statsText ctrlSetText _statsString;
};

if (!isNull _skillsText) then {
    private _skills = _data get "skills";
    
    private _skillsString = "=== КАТЕГОРИИ XP ===\n";
    _skillsString = _skillsString + format ["Медицина: %1 XP\n", _skills getOrDefault ["medical", 0]];
    _skillsString = _skillsString + format ["Ремонт: %1 XP\n", _skills getOrDefault ["repair", 0]];
    _skillsString = _skillsString + format ["Бой: %1 XP\n", _skills getOrDefault ["combat", 0]];
    _skillsString = _skillsString + format ["Поддержка: %1 XP\n", _skills getOrDefault ["support", 0]];
    _skillsString = _skillsString + format ["Инженерия: %1 XP\n", _skills getOrDefault ["engineering", 0]];
    
    _skillsText ctrlSetText _skillsString;
};
