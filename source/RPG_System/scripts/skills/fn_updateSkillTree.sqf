/*
    RPG System - Update Skill Tree Display
    Рендерит древо навыков в стиле Cyberpunk 2077
    5 колонок атрибутов, каждая с 2 ветками по 3 перка
*/

private _display = uiNamespace getVariable ["RPG_SkillTree_Display", displayNull];
if (isNull _display) exitWith {};

private _player = uiNamespace getVariable ["RPG_CurrentPlayer", player];
if (isNull _player) exitWith {};

private _playerID = getPlayerUID _player;
private _data = [_playerID] call RPG_fnc_getPlayerData;
if (isNil "_data") exitWith {};

private _skills = _data get "skills";
private _specializations = _data get "specializations";

// ─── Определение атрибутов и их перков ─────────────
// Формат ветки: [ключ_ветки, имя_ветки, [[perk_name, perk_desc, icon, req_level, type], ...]]
private _attrDefs = [
    ["constitution", "ФИЗИОЛОГИЯ", "#e05555",
        ["athlete", "Атлетика", [
            ["Вьючный мул", "Переносимый вес +15%", "🎒", 1, "full"],
            ["Второе дыхание", "Выносливость +20%", "💨", 3, "full"],
            ["Мастер препятствий", "Быстрое преодоление", "🧗", 5, "visual"]
        ]],
        ["vitality", "Живучесть", [
            ["Адреналиновый шок", "3 сек без замедления", "⚡", 1, "visual"],
            ["Своих не бросаем", "Скорость drag +30%", "🤝", 3, "full"],
            ["Крепкий орешек", "Снижение потери сознания", "🛡️", 5, "visual"]
        ]]
    ],
    ["reflexes", "РЕФЛЕКСЫ", "#ffcc44",
        ["assault", "Штурмовик", [
            ["Мышечная память", "Смена оружия -25%", "🔁", 1, "visual"],
            ["Тактическая перезарядка", "Быстрая перезарядка", "📦", 3, "visual"],
            ["Контроль ствола", "Меньше разброс", "🎯", 5, "visual"]
        ]],
        ["marksman", "Марксман", [
            ["Контроль дыхания", "Дольше задержка", "🌬️", 1, "visual"],
            ["Холодный расчёт", "Быстрая стабилизация", "🧊", 3, "visual"],
            ["Пристрелка", "Мгновенная пристрелка", "🔭", 5, "visual"]
        ]]
    ],
    ["technical", "ТЕХНИКА", "#ff8833",
        ["engineering", "Инженерия", [
            ["Полевой ремонт", "Ремонт ×2 быстрее", "🔧", 1, "xp"],
            ["Фортификатор", "Быстрые заграждения", "🏗️", 3, "xp"],
            ["Механик-водитель", "Меньше урона технике", "🚗", 5, "visual"]
        ]],
        ["sapper", "Сапёр", [
            ["Сапёрная лопатка", "Быстрая установка мин", "💣", 1, "xp"],
            ["Наметанный глаз", "Обнаружение мин", "👁️", 3, "visual"],
            ["Ювелирная работа", "Безопасное разминирование", "💎", 5, "xp"]
        ]]
    ],
    ["intelligence", "ИНТЕЛЛЕКТ", "#44aaff",
        ["medic", "Медик", [
            ["Жгут и бинт", "Наложение -30%", "🩹", 1, "full"],
            ["Фармацевт", "Эффективность препаратов", "💊", 3, "full"],
            ["Реаниматолог", "Повышенный шанс СЛР", "❤️", 5, "full"]
        ]],
        ["operator", "Оператор", [
            ["Аккумулятор БПЛА", "Время дронов +50%", "🔋", 1, "visual"],
            ["Целеуказатель", "Дальняя подсветка", "🔴", 3, "visual"],
            ["РЭБ", "Глушение GPS/радио", "📡", 5, "visual"]
        ]]
    ],
    ["cool", "ВЫДЕРЖКА", "#aa55ff",
        ["ghost", "Призрак", [
            ["Мягкий шаг", "Тише шаги", "👣", 1, "visual"],
            ["Слияние с местностью", "Замечают медленнее", "🌿", 3, "visual"],
            ["Ночной охотник", "Меньше ослепления ПНВ", "🌙", 5, "visual"]
        ]],
        ["steel_nerves", "Стальные нервы", [
            ["Подавление подавления", "Эффект подавления -50%", "🧠", 1, "full"],
            ["Ясный ум", "Быстрое восстановление слуха", "🔔", 3, "visual"],
            ["Ледяное спокойствие", "Нет потери точности", "❄️", 5, "visual"]
        ]]
    ]
];

// ─── Базовые IDC для каждого атрибута ─────────────
// 3000-3004: constitution
// 3005-3009: reflexes
// 3010-3014: technical
// 3015-3019: intelligence
// 3020-3024: cool
private _idcOffsets = [3000, 3005, 3010, 3015, 3020];
// 0=Title, 1=Level, 2=Branch1, 3=Branch2, 4=Bonus

{
    _x params ["_attrKey", "_attrName", "_attrColor",
        "_branch1Key", "_branch1Name", "_branch1Perks",
        "_branch2Key", "_branch2Name", "_branch2Perks"
    ];

    private _baseIdc = _idcOffsets select _forEachIndex;
    private _skillXP = _skills getOrDefault [_attrKey, 0];
    private _attrLevel = floor (_skillXP / 1000) max 0;

    // Заголовок
    private _ctrlTitle = _display displayCtrl (_baseIdc + 0);
    if (!isNull _ctrlTitle) then {
        _ctrlTitle ctrlSetStructuredText parseText format [
            "<t size='1.1' color='%1' align='center'>%2</t>", _attrColor, _attrName
        ];
    };

    // Уровень
    private _ctrlLevel = _display displayCtrl (_baseIdc + 1);
    if (!isNull _ctrlLevel) then {
        private _nextLevelXP = (_attrLevel + 1) * 1000;
        _ctrlLevel ctrlSetStructuredText parseText format [
            "<t size='0.85' align='center'>Уровень %1 (XP: %2 / %3)</t>",
            _attrLevel, _skillXP, _nextLevelXP
        ];
    };

    // ─── Функция рендера ветки ───────────────────────────
    private _fnRenderBranch = {
        params ["_branchName", "_perks", "_level", "_color"];
        private _html = format ["<t size='0.75' align='center' color='%1'>%2</t><br/>", _color, _branchName];
        _html = _html + "<t size='0.70'>";

        {
            _x params ["_perkName", "_perkDesc", "_perkIcon", "_reqLevel", "_perkType"];
            private _unlocked = _level >= _reqLevel;
            private _nodeColor = if (_unlocked) then { "#44cc44" } else {"#444444"};
            private _alpha = if (_unlocked) then { "1.0" } else { "0.4" };
            private _nodeStyle = if (_reqLevel in [3, 7]) then { "◆" } else { "●" };

            _html = _html + format [
                "<t alpha='%2' color='%3'>%4</t><br/><t alpha='%2' color='%2'>%5</t><br/>",
                _alpha, _nodeColor, _nodeStyle, _perkName, _perkDesc
            ];
        } forEach _perks;

        _html = _html + "</t>";
        _html
    };

    // Ветка 1
    private _ctrlB1 = _display displayCtrl (_baseIdc + 2);
    if (!isNull _ctrlB1) then {
        _ctrlB1 ctrlSetStructuredText parseText ([_branch1Name, _branch1Perks, _attrLevel, _attrColor] call _fnRenderBranch);
    };

    // Ветка 2
    private _ctrlB2 = _display displayCtrl (_baseIdc + 3);
    if (!isNull _ctrlB2) then {
        _ctrlB2 ctrlSetStructuredText parseText ([_branch2Name, _branch2Perks, _attrLevel, _attrColor] call _fnRenderBranch);
    };

    // Бонус
    private _bonus = 0;
    { if (_x select 0 == _attrLevel) exitWith { _bonus = _x select 1; }; } forEach RPG_SKILL_BONUSES;
    if (_attrLevel > 10) then { _bonus = 1.0 + ((_attrLevel - 10) * 0.1); };
    private _bonusPct = format ["+%1%%", floor (_bonus * 100)];
    private _bonusColor = if (_bonus > 0) then { "#44cc44" } else { "#666666" };

    private _ctrlBonus = _display displayCtrl (_baseIdc + 4);
    if (!isNull _ctrlBonus) then {
        _ctrlBonus ctrlSetStructuredText parseText format [
            "<t size='0.8' color='%1' align='center'>Бонус XP: %2</t>", _bonusColor, _bonusPct
        ];
    };

} forEach _attrDefs;
