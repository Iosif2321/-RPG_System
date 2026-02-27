/*
    RPG System - Debug Commands
    Команды для отладки и тестирования
    
    Выполнять в консоли отладки (F10) или в чате (если включено)
*/

// ============================================
// ОТЛАДКА И ТЕСТИРОВАНИЕ
// ============================================

// Получить данные игрока
hint str ([getPlayerUID player] call RPG_fnc_getPlayerData);

// Добавить 1000 XP
[player, 1000, "Отладка"] call RPG_fnc_addXP;

// Добавить 500 XP к навыку медицины
[player, "medical", 500] call RPG_fnc_addSkillXP;

// Получить текущий XP
hint str ([player, "xp"] call RPG_fnc_getXP);

// Получить уровень
hint str ([player] call RPG_fnc_getLevel);

// Получить прогресс до следующего уровня
hint str ([player] call RPG_fnc_getProgressToNextLevel);

// Открыть меню RPG
[] call RPG_fnc_openRPGMenu;

// Принудительно сохранить базу данных
[] call RPG_fnc_saveDatabase;

// ============================================
// СБРОС ДАННЫХ
// ============================================

// Удалить данные игрока из базы
RPG_DB_PLAYERS deleteAt (getPlayerUID player);

// Полностью очистить базу данных
RPG_DB_PLAYERS clear;

// Сбросить все данные и пересоздать базу
profileNamespace setVariable ["RPG_System_PlayerData", nil];
saveProfileNamespace;
[] call RPG_fnc_initDatabase;

// ============================================
// ТЕСТИРОВАНИЕ СОБЫТИЙ
// ============================================

// Симулировать убийство врага
private _enemy = createGroup [east, true] createUnit ["O_Soldier_F", getPos player, [], 0, "NONE"];
[player, _enemy] call RPG_fnc_onEntityKilled;

// Симулировать уничтожение техники
private _vehicle = createVehicle ["O_APC_Wheeled_02_rcws_v2_mg_F", getPos player, [], 0, "NONE"];
[player, _vehicle] call RPG_fnc_onVehicleDestroyed;

// ============================================
// ПРОВЕРКА БАЗЫ ДАННЫХ
// ============================================

// Показать количество игроков в базе
hint str format ["Игроков в базе: %1", RPG_DB_PLAYERS size()];

// Показать всех игроков
{
    diag_log format ["Player: %1, Data: %2", _x, RPG_DB_PLAYERS get _x];
} forEach allKeys RPG_DB_PLAYERS;

// Проверить наличие данных в профиле
hint str (profileNamespace getVariable "RPG_System_PlayerData");

// ============================================
| КОНФИГУРАЦИЯ
// ============================================

// Показать конфигурацию XP
hint str RPG_XP_CONFIG;

// Показать конфигурацию уровней
hint str RPG_LEVEL_CONFIG;

// Изменить XP за убийство (временно)
RPG_XP_CONFIG set ["kill_infantry", 100];

// Изменить базовый XP для уровней
RPG_LEVEL_CONFIG set ["baseXP", 500];

// ============================================
// НАВЫКИ
// ============================================

// Получить уровень навыка медицины
hint str ([player, "medical"] call RPG_fnc_getSkillLevel);

// Получить бонус навыка
hint str ([player, "medical"] call RPG_fnc_getSkillBonus);

// Установить максимальный уровень навыка
[player, "medical", 10000] call RPG_fnc_setSkill;

// ============================================
// UI ТЕСТЫ
// ============================================

// Обновить UI меню
[] call RPG_fnc_updateRPGMenu;

// Закрыть меню
[] call RPG_fnc_closeRPGMenu;

// Показать уведомление об XP
[player, 500, "Тест"] call RPG_fnc_createXPNotification;

// Показать уведомление о повышении уровня
[player, 5, 1] call RPG_fnc_showLevelUpNotification;
