/*
    RPG System - Skills Initialization (Cyberpunk 2077 Skill Tree)
    Инициализация системы навыков с древом перков

    Атрибуты: constitution, reflexes, technical, intelligence, cool
    Каждый атрибут имеет 2 ветки по 3 перка.
    На уровнях 3 и 7 — выбор специализации (перк).
*/

// Типы навыков (атрибуты)
RPG_SKILL_TYPES = ["constitution", "reflexes", "technical", "intelligence", "cool"];

// Бонусы за уровень навыка (множитель XP, в процентах)
RPG_SKILL_BONUSES = [
    [0, 0],       // Уровень 0 — без бонуса
    [1, 0.05],    // Уровень 1 — 5%
    [2, 0.10],    // Уровень 2 — 10%
    [3, 0.15],    // Уровень 3 — 15%
    [4, 0.20],    // Уровень 4 — 20%
    [5, 0.30],    // Уровень 5 — 30%
    [6, 0.40],    // Уровень 6 — 40%
    [7, 0.50],    // Уровень 7 — 50%
    [8, 0.65],    // Уровень 8 — 65%
    [9, 0.80],    // Уровень 9 — 80%
    [10, 1.0]     // Уровень 10 — 100%
    // Уровень > 10 экстраполируется: +10% за каждый уровень
];

// Перки древа навыков (Cyberpunk 2077 стиль)
// Формат: "attribute_level" → [имя, описание, реализуемость, icon]
// реализуемость: "full" (работает), "xp" (множитель XP), "visual" (пока только визуал)

RPG_SKILL_PERKS = createHashMap;

// ═══════════════════════════════════════════════════════
// CONSTITUTION — Физиология (Body)
// ═══════════════════════════════════════════════════════
RPG_SKILL_PERKS set ["constitution_branches", ["athlete", "vitality"]];

// Ветка: Атлетика
RPG_SKILL_PERKS set ["constitution_1_athlete", [
    "Вьючный мул", "Переносимый вес +15%", "full", "🎒"
]];
RPG_SKILL_PERKS set ["constitution_3_athlete", [
    "Второе дыхание", "Восстановление выносливости +20% вне боя", "full", "💨"
]];
RPG_SKILL_PERKS set ["constitution_5_athlete", [
    "Мастер препятствий", "Быстрое преодоление препятствий", "visual", "🧗"
]];

// Ветка: Живучесть
RPG_SKILL_PERKS set ["constitution_1_vitality", [
    "Адреналиновый шок", "3 сек без замедления при ранении", "visual", "⚡"
]];
RPG_SKILL_PERKS set ["constitution_3_vitality", [
    "Своих не бросаем", "Скорость перетаскивания раненых +30%", "full", "🤝"
]];
RPG_SKILL_PERKS set ["constitution_5_vitality", [
    "Крепкий орешек", "Снижение потери сознания от лёгких ранений", "visual", "🛡️"
]];

// ═══════════════════════════════════════════════════════
// REFLEXES — Огневая подготовка (Reflexes)
// ═══════════════════════════════════════════════════════
RPG_SKILL_PERKS set ["reflexes_branches", ["assault", "marksman"]];

// Ветка: Штурмовик
RPG_SKILL_PERKS set ["reflexes_1_assault", [
    "Мышечная память", "Смена оружия на 25% быстрее", "visual", "🔁"
]];
RPG_SKILL_PERKS set ["reflexes_3_assault", [
    "Тактическая перезарядка", "Перезарядка неполного магазина на 20% быстрее", "visual", "📦"
]];
RPG_SKILL_PERKS set ["reflexes_5_assault", [
    "Контроль ствола", "Снижен горизонтальный разброс в движении", "visual", "🎯"
]];

// Ветка: Марксман
RPG_SKILL_PERKS set ["reflexes_1_marksman", [
    "Контроль дыхания", "Больше время задержки дыхания", "visual", "🌬️"
]];
RPG_SKILL_PERKS set ["reflexes_3_marksman", [
    "Холодный расчёт", "Быстрее стабилизация прицела после спринта", "visual", "🧊"
]];
RPG_SKILL_PERKS set ["reflexes_5_marksman", [
    "Пристрелка", "Мгновенная пристрелка и дальномер", "visual", "🔭"
]];

// ═══════════════════════════════════════════════════════
// TECHNICAL — Техническая грамотность (Technical)
// ═══════════════════════════════════════════════════════
RPG_SKILL_PERKS set ["technical_branches", ["engineering", "sapper"]];

// Ветка: Инженерия и механика
RPG_SKILL_PERKS set ["technical_1_engineering", [
    "Полевой ремонт", "Ремонт техники и разрушений в 2 раза быстрее", "xp", "🔧"
]];
RPG_SKILL_PERKS set ["technical_3_engineering", [
    "Фортификатор", "Быстрая установка заграждений", "xp", "🏗️"
]];
RPG_SKILL_PERKS set ["technical_5_engineering", [
    "Механик-водитель", "Техника получает меньше урона от бездорожья", "visual", "🚗"
]];

// Ветка: Сапёрное дело
RPG_SKILL_PERKS set ["technical_1_sapper", [
    "Сапёрная лопатка", "Быстрая и тихая установка мин/взрывчатки", "xp", "💣"
]];
RPG_SKILL_PERKS set ["technical_3_sapper", [
    "Наметанный глаз", "Больше радиус обнаружения мин и растяжек", "visual", "👁️"
]];
RPG_SKILL_PERKS set ["technical_5_sapper", [
    "Ювелирная работа", "Безопасное обезвреживание сложной взрывчатки", "xp", "💎"
]];

// ═══════════════════════════════════════════════════════
// INTELLIGENCE — Интеллект и связь (Intelligence)
// ═══════════════════════════════════════════════════════
RPG_SKILL_PERKS set ["intelligence_branches", ["medic", "operator"]];

// Ветка: Полевой медик
RPG_SKILL_PERKS set ["intelligence_1_medic", [
    "Жгут и бинт", "Наложение жгутов и перевязка на 30% быстрее", "full", "🩹"
]];
RPG_SKILL_PERKS set ["intelligence_3_medic", [
    "Фармацевт", "Эффективность морфина и эпинефрина повышена", "full", "💊"
]];
RPG_SKILL_PERKS set ["intelligence_5_medic", [
    "Реаниматолог", "Повышенный шанс успешной СЛР", "full", "❤️"
]];

// Ветка: Оператор и наводчик
RPG_SKILL_PERKS set ["intelligence_1_operator", [
    "Аккумулятор БПЛА", "Время работы дронов +50%", "visual", "🔋"
]];
RPG_SKILL_PERKS set ["intelligence_3_operator", [
    "Целеуказатель", "Дальняя лазерная подсветка целей", "visual", "🔴"
]];
RPG_SKILL_PERKS set ["intelligence_5_operator", [
    "РЭБ", "Глушение GPS и радиосвязи в радиусе 100м", "visual", "📡"
]];

// ═══════════════════════════════════════════════════════
// COOL — Выдержка (Cool)
// ═══════════════════════════════════════════════════════
RPG_SKILL_PERKS set ["cool_branches", ["ghost", "steel_nerves"]];

// Ветка: Призрак (Стелс)
RPG_SKILL_PERKS set ["cool_1_ghost", [
    "Мягкий шаг", "Громкость шагов снижена при приседе/ползком", "visual", "👣"
]];
RPG_SKILL_PERKS set ["cool_3_ghost", [
    "Слияние с местностью", "Враги замечают на 20% медленнее в укрытии", "visual", "🌿"
]];
RPG_SKILL_PERKS set ["cool_5_ghost", [
    "Ночной охотник", "Снижен эффект ослепления от ПНВ", "visual", "🌙"
]];

// Ветка: Стальные нервы
RPG_SKILL_PERKS set ["cool_1_steel_nerves", [
    "Подавление подавления", "Эффект подавления при обстреле снижен на 50%", "full", "🧠"
]];
RPG_SKILL_PERKS set ["cool_3_steel_nerves", [
    "Ясный ум", "Быстрое восстановление слуха после гранат", "visual", "🔔"
]];
RPG_SKILL_PERKS set ["cool_5_steel_nerves", [
    "Ледяное спокойствие", "Нет потери точности при ранении", "visual", "❄️"
]];

diag_log "[RPG] Skills system initialized (Cyberpunk 2077 style)";
