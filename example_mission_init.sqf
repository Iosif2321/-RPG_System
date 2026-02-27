/*
    Пример миссии для тестирования RPG System
    
    Установка:
    1. Скопируйте этот файл в вашу миссию
    2. Измените пути при необходимости
*/

// initServer.sqf
// ============================================

// Инициализация RPG системы
[] call compile preprocessFileLineNumbers "\RPG_System\initServer.sqf";

// Ваш код инициализации сервера...
diag_log "Server initialized";


// initPlayerLocal.sqf
// ============================================

// Инициализация RPG системы для игрока
[] call compile preprocessFileLineNumbers "\RPG_System\initPlayerLocal.sqf";

// Ваш код инициализации клиента...
diag_log "Player initialized";


// description.ext (опционально)
// ============================================
/*
// Добавляем действие в меню действий
class RscTitles {
    // Ваши заголовки
};
*/


// Для открытия меню RPG используйте:
// [] call RPG_fnc_openRPGMenu;

// Для добавления тестового XP:
// [player, 1000, "Тест"] call RPG_fnc_addXP;

// Для проверки данных:
// hint str ([getPlayerUID player] call RPG_fnc_getPlayerData);
