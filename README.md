# RPG System для ARMA 3

Серверный мод с системой опыта, уровней и базой данных на основе HashMap с сохранением в ProfileNamespace.

## Особенности

- **Полностью серверный** - не требует установки у клиентов
- **База данных на HashMap** - быстрое хранение данных
- **Сохранение в ProfileNamespace** - данные сохраняются между сессиями
- **Система XP и уровней** - прогрессия игрока
- **Статистика по категориям** - медицина, ремонт, бой, поддержка, инженерия
- **ACE3 интеграция** - поддержка ACE медицины и ремонта
- **UI интерфейс** - меню статистики игрока

> **Примечание:** Навыки носят информационный характер и не влияют на геймплей. За действия начисляются только XP.

## Установка

### Требования
- ARMA 3 Server
- CBA_A3 (опционально, для ACE интеграции)
- ACE3 (опционально)

### Шаги установки

1. Скопируйте папку `@RPG_System` в директорию сервера
2. Добавьте `@RPG_System` в список модов сервера
3. В файле `initServer.sqf` вашей миссии добавьте:
   ```sqf
   [] call compile preprocessFileLineNumbers "\RPG_System\initServer.sqf";
   ```

4. В файле `initPlayerLocal.sqf` добавьте (опционально):
   ```sqf
   [] call compile preprocessFileLineNumbers "\RPG_System\initPlayerLocal.sqf";
   ```

## Система XP

### Начисление XP за действия

| Действие | XP | Описание |
|----------|-----|----------|
| Убийство пехоты | 50 | За уничтожение вражеского солдата |
| Убийство офицера | 100 | За уничтожение офицера/командира |
| Уничтожение легкой техники | 100 | Автомобили, джипы, багги |
| Уничтожение тяжелой техники | 200 | Танки, БМП, БТР |
| Уничтожение авиации | 250 | Вертолеты, самолеты, БПЛА |
| Воскрешение союзника | 75 | Возвращение к жизни после смерти |
| Лечение союзника | 25 | Обработка повреждений |
| Ремонт техники | 50 | Восстановление повреждений ТС |
| Заправка техники | 30 | Заправка ТС топливом |
| Перезарядка техники | 40 | Пополнение боекомплекта ТС |

> **Примечание:** За все действия начисляются только XP. Статистика по категориям (Медицина, Ремонт, Бой и т.д.) носит информационный характер.

### Формула уровней

```
XP для уровня = baseXP * (level ^ exponent)
```

По умолчанию:
- baseXP = 1000
- exponent = 1.5
- Максимальный уровень = 100

## Статистика по категориям

Система отслеживает XP по 5 категориям (информационно):
- **Медицина** — XP за лечение и воскрешение
- **Ремонт** — XP за ремонт техники
- **Бой** — XP за убийства и уничтожение техники
- **Поддержка** — XP за снабжение и заправку
- **Инженерия** — XP за инженерные действия

> **Важно:** Категории не влияют на геймплей, а только отображают статистику действий игрока.

## API Функции

### Работа с XP

```sqf
// Добавить XP игроку
[player, 100, "Причина"] call RPG_fnc_addXP;

// Получить XP игрока
[player, "xp"] call RPG_fnc_getXP;

// Получить уровень игрока
[player] call RPG_fnc_getLevel;

// Получить XP до следующего уровня
[level] call RPG_fnc_getNextLevelXP;

// Получить прогресс до следующего уровня (0-1)
[player] call RPG_fnc_getProgressToNextLevel;
```

### Статистика

```sqf
// Получить данные игрока
[getPlayerUID player] call RPG_fnc_getPlayerData;

// Получить статистику по категории
private _data = [getPlayerUID player] call RPG_fnc_getPlayerData;
private _skills = _data get "skills";
_skills get "medical";  // XP за медицину
```

### UI

```sqf
// Открыть меню RPG
[] call RPG_fnc_openRPGMenu;

// Закрыть меню RPG
[] call RPG_fnc_closeRPGMenu;

// Обновить данные в меню
[] call RPG_fnc_updateRPGMenu;
```

### База данных

```sqf
// Инициализировать базу данных
[] call RPG_fnc_initDatabase;

// Получить данные игрока
[playerID] call RPG_fnc_getPlayerData;

// Установить данные игрока
[playerID, data] call RPG_fnc_setPlayerData;

// Сохранить базу данных
[] call RPG_fnc_saveDatabase;
```

## Конфигурация

### Настройка XP

Отредактируйте `scripts\xp\fn_initXPSystem.sqf`:

```sqf
RPG_XP_CONFIG set ["kill_infantry", 50];  // Изменить XP за убийство
RPG_XP_CONFIG set ["skill_medical", 1.5]; // Изменить множитель навыка
```

### Настройка уровней

```sqf
RPG_LEVEL_CONFIG set ["baseXP", 1000];      // Базовый XP
RPG_LEVEL_CONFIG set ["exponent", 1.5];     // Экспонента роста
RPG_LEVEL_CONFIG set ["maxLevel", 100];     // Максимальный уровень
RPG_LEVEL_CONFIG set ["xpRate", 1.0];       // Множитель XP
```

## Структура файлов

```
@RPG_System/
├── config.cpp                 # Конфигурация мода
├── meta.cpp                   # Метаданные мода
├── mod.cpp                    # Описание мода
├── init.sqf                   # Главный файл инициализации
├── initServer.sqf             # Инициализация сервера
├── initPlayerLocal.sqf        # Инициализация клиента
├── scripts/
│   ├── database/              # База данных
│   │   └── fn_initDatabase.sqf
│   ├── xp/                    # Система XP
│   │   ├── fn_initXPSystem.sqf
│   │   ├── fn_addXP.sqf
│   │   ├── fn_getXP.sqf
│   │   ├── fn_getLevel.sqf
│   │   ├── fn_getNextLevelXP.sqf
│   │   └── fn_getProgressToNextLevel.sqf
│   ├── skills/                # Навыки
│   │   ├── fn_initSkills.sqf
│   │   ├── fn_getSkill.sqf
│   │   ├── fn_setSkill.sqf
│   │   ├── fn_addSkillXP.sqf
│   │   └── fn_getSkillLevel.sqf
│   ├── events/                # События
│   │   ├── fn_initEventHandlers.sqf
│   │   ├── fn_onPlayerKilled.sqf
│   │   ├── fn_onPlayerRespawn.sqf
│   │   ├── fn_onVehicleDestroyed.sqf
│   │   └── fn_onEntityKilled.sqf
│   ├── ace/                   # ACE интеграция
│   │   ├── fn_initACEIntegration.sqf
│   │   ├── fn_onACEMedical.sqf
│   │   ├── fn_onACERepair.sqf
│   │   └── fn_onACEReload.sqf
│   └── ui/                    # Интерфейс
│       ├── fn_initUI.sqf
│       ├── fn_openRPGMenu.sqf
│       ├── fn_closeRPGMenu.sqf
│       └── fn_updateRPGMenu.sqf
└── ui/
    ├── RscDefines.hpp         # Определения GUI
    └── RscDialogs.hpp         # Диалоги GUI
```

## Хранение данных

Данные хранятся в `ProfileNamespace` под ключом `RPG_System_PlayerData`.

Формат хранения:
```sqf
HashMap [
    ["playerUID1", HashMap [
        ["xp", 1500],
        ["level", 3],
        ["totalXP", 2500],
        ["skills", HashMap [
            ["medical", 500],
            ["combat", 1000],
            ...
        ]],
        ["stats", HashMap [
            ["kills", 25],
            ["deaths", 10],
            ...
        ]]
    ]],
    ...
]
```

## Команды чата

- `/rpg` - открыть меню RPG (требует настройки)
- `/xp` - показать текущий XP
- `/level` - показать текущий уровень

## Отладка

### Включить логирование

Все действия логируются в RPT файл сервера.

### Проверка данных игрока

```sqf
[getPlayerUID player] call RPG_fnc_getPlayerData;
```

### Принудительное сохранение

```sqf
[] call RPG_fnc_saveDatabase;
```

## Лицензия

Свободное использование. Указание автора желательно.

## Поддержка

При возникновении проблем проверяйте:
1. RPT лог сервера
2. Корректность установки мода
3. Наличие зависимостей (CBA, ACE)

## Changelog

### v1.0.0
- Первая версия
- База данных на HashMap
- Система XP и уровней
- Статистика по 5 категориям (информационно)
- ACE интеграция
- UI меню

> **Примечание:** Навыки были переработаны в систему статистики. За действия начисляются только XP без бонусов.
