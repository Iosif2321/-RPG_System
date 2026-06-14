/*
    RPG System - Skills and perks initialization.
    Runtime source of truth for the five 16-perk trees used by the HTML simulator.
*/

RPG_SKILL_TYPES = ["constitution", "reflexes", "technical", "intelligence", "cool"];

RPG_SKILL_NAMES = createHashMapFromArray [
    ["constitution", "Физиология"],
    ["reflexes", "Рефлексы"],
    ["technical", "Техника"],
    ["intelligence", "Интеллект"],
    ["cool", "Выдержка"]
];

RPG_SKILL_SHORT_NAMES = createHashMapFromArray [
    ["constitution", "ФИЗ"],
    ["reflexes", "РЕФ"],
    ["technical", "ТЕХ"],
    ["intelligence", "ИНТ"],
    ["cool", "ВЫД"]
];

RPG_SKILL_ROLES = createHashMapFromArray [
    ["constitution", "груз, выносливость, тело"],
    ["reflexes", "оружие, темп, контроль"],
    ["technical", "ремонт, снабжение, фортификация"],
    ["intelligence", "ACE медицина и поддержка"],
    ["cool", "будущий RPG_stress"]
];

RPG_SKILL_BONUSES = [
    [0, 0],
    [1, 0.05],
    [2, 0.10],
    [3, 0.15],
    [4, 0.20],
    [5, 0.30],
    [6, 0.40],
    [7, 0.50],
    [8, 0.65],
    [9, 0.80],
    [10, 1.0]
];

RPG_PERK_TIER_LEVELS = [0, 4, 7, 10, 13, 16, 20];
RPG_TREE_MAX_LEVEL = 20;
RPG_MAX_SKILL_POINTS = 260;
RPG_SKILL_POINTS_PER_LEVEL = 3;
RPG_PERK_TIER_COSTS = [1, 2, 3, 4, 5, 6, 8];
RPG_TREE_LEVEL_COSTS = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5];
RPG_PERK_COST = 1;

RPG_PERKS = createHashMap;
RPG_PERKS_BY_TREE = createHashMap;
{ RPG_PERKS_BY_TREE set [_x, []]; } forEach RPG_SKILL_TYPES;

private _addPerk = {
    params ["_tree", "_id", "_name", "_desc", "_tier", "_type", "_detail", ["_status", "ready"]];

    private _perk = createHashMapFromArray [
        ["tree", _tree],
        ["id", _id],
        ["name", _name],
        ["description", _desc],
        ["tier", _tier],
        ["type", _type],
        ["detail", _detail],
        ["status", _status]
    ];

    RPG_PERKS set [_id, _perk];
    private _treePerks = RPG_PERKS_BY_TREE getOrDefault [_tree, []];
    _treePerks pushBack _perk;
    RPG_PERKS_BY_TREE set [_tree, _treePerks];
};

// Constitution / Physiology
["constitution", "phys_sprinter", "Спринтер", "Короткий рывок скорости при старте бега", 0, "full", "Временный скоростной бафф с кулдауном. Не влияет на оружейные анимации.", "ready"] call _addPerk;
["constitution", "phys_rabbit", "Рывок из-под огня", "Короткий рывок скорости после лёгкого реального ранения", 0, "full", "Срабатывает только от роста повреждения, без бонусов за бездействие.", "ready"] call _addPerk;
["constitution", "phys_field_march", "Полевой марш", "Медленнее набирается усталость при движении с грузом выше порога", 0, "full", "Работает от нагрузки и движения, но не начисляет XP сам по себе.", "ready"] call _addPerk;
["constitution", "phys_athlete", "Легкоатлет", "+10% скорость восстановления выносливости", 1, "full", "Ускоряет восстановление усталости.", "ready"] call _addPerk;
["constitution", "phys_marathoner", "Марафонец", "Мягкий cap максимальной усталости", 1, "full", "Игрок дольше сохраняет ход, но не получает бесконечную выносливость.", "ready"] call _addPerk;
["constitution", "phys_organized", "Организованный", "+15% вместимость рюкзака", 1, "full", "Увеличивает лимит рюкзака и переприменяется при смене контейнера.", "ready"] call _addPerk;
["constitution", "phys_long_stride", "Длинный шаг", "Небольшой постоянный бонус к передвижению пешком", 2, "full", "Мягкий локальный бонус скорости только вне техники.", "verify"] call _addPerk;
["constitution", "phys_deep_pocket", "Глубокий карман", "+20% вместимость формы и жилета", 2, "full", "Увеличивает лимит личных контейнеров без создания предметов.", "ready"] call _addPerk;
["constitution", "phys_trained_throw", "Тренированный бросок", "Немного увеличивает дальность броска гранат", 2, "full", "Через скорость уже созданного projectile, без усиления взрыва.", "ready"] call _addPerk;
["constitution", "phys_thick_blood", "Густая кровь", "Снижает скорость кровотечения", 3, "full", "Использует публичное событие ACE blood-loss, без прямого редактирования ран.", "verify"] call _addPerk;
["constitution", "phys_adrenaline", "Адреналиновая реакция", "После ранения временно замедляет ухудшение состояния", 3, "full", "Не лечит бесплатно, только ограниченно снижает кровопотерю через ACE event.", "verify"] call _addPerk;
["constitution", "phys_tough_bones", "Крепкие кости", "Лучше переносит переломы или быстрее стабилизируется после шины", 3, "full", "Не удаляет переломы напрямую; пока только каталог/будущий ACE-safe эффект.", "verify"] call _addPerk;
["constitution", "phys_iron_will", "Железная воля", "Единственный перк на грани отключки", 4, "full", "Не отменяет unconscious напрямую; пока только каталог/будущий ACE-safe эффект.", "verify"] call _addPerk;
["constitution", "phys_spare_lungs", "Запасные лёгкие", "+30% скорость восстановления выносливости", 4, "full", "Суммируется с Легкоатлетом только до общего cap.", "ready"] call _addPerk;
["constitution", "phys_gunpowder_blood", "Порох вместо крови", "Ограниченная защита от критической кровопотери / остановки", 5, "full", "Не пишет внутренние ACE-переменные напрямую в текущей реализации.", "verify"] call _addPerk;
["constitution", "phys_night_adapt", "Ночная адаптация", "Мягкая адаптация зрения в темноте", 6, "full", "Не заменяет NV и не делает ночь днём; эффект оставлен за проверкой.", "verify"] call _addPerk;

// Reflexes
["reflexes", "ref_barrel_control", "Контроль ствола", "Небольшое снижение отдачи", 0, "full", "Ограниченный recoil coefficient. Не дыхание, не aim speed.", "ready"] call _addPerk;
["reflexes", "ref_reload_drill", "Тактическая перезарядка", "Перезарядка становится удобнее после проверки reload hook", 0, "full", "Без бесплатных патронов и без подмены магазинов.", "verify"] call _addPerk;
["reflexes", "ref_mag_memory", "Память магазина", "UI-подсказка по текущему магазину / остатку после перезарядки", 0, "ui", "Информационный перк без влияния на урон и боезапас.", "ready"] call _addPerk;
["reflexes", "ref_fire_discipline", "Огневая дисциплина", "Бонус к контролю отдачи только при одиночном / коротком огне", 1, "full", "Не работает как damage spike.", "verify"] call _addPerk;
["reflexes", "ref_return_to_line", "Возврат на линию", "Короткая стабилизация оружия после завершённой перезарядки", 1, "full", "Малый временный бонус контроля, не меняет скорость наведения.", "ready"] call _addPerk;
["reflexes", "ref_emergency_reload", "Аварийная перезарядка", "Если магазин пустой, перезарядка получает небольшой бонус", 2, "full", "Требуется проверка reload hook; сейчас каталог/будущий эффект.", "verify"] call _addPerk;
["reflexes", "ref_steady_burst", "Короткая очередь", "Снижает штраф отдачи только для коротких очередей с паузой", 2, "full", "Используется как ограниченный контроль recoil, не laser-beam.", "verify"] call _addPerk;
["reflexes", "ref_combat_habit", "Боевая привычка", "Мастер-перк: объединяет recoil / reload / UI-бонусы без новых эффектов", 3, "full", "Не добавляет stealth или мгновенное наведение.", "ready"] call _addPerk;
["reflexes", "ref_tempo_control", "Контроль темпа", "Бонус контроля держится только при стрельбе с паузами", 3, "full", "Сбрасывается при длинном зажиме или хаотичной стрельбе.", "verify"] call _addPerk;
["reflexes", "ref_shoulder_habit", "Плечевая вкладка", "Стабильнее удержание оружия в статичной позиции", 4, "full", "Каталог/будущий эффект после проверки состояния игрока.", "verify"] call _addPerk;
["reflexes", "ref_recoil_reset", "Сброс отдачи", "После короткой паузы оружие быстрее возвращается к базовому контролю", 4, "full", "Не ускоряет наведение и не даёт бонус к урону.", "verify"] call _addPerk;
["reflexes", "ref_reload_awareness", "Контроль патронника", "UI предупреждает о пустом магазине перед критическим моментом", 4, "ui", "Информационный перк без автоперезарядки.", "ready"] call _addPerk;
["reflexes", "ref_weapon_flow", "Оружейный поток", "Снижает мелкие штрафы между выстрелом и перезарядкой", 5, "full", "Только на короткое окно после реального оружейного события.", "verify"] call _addPerk;
["reflexes", "ref_short_contact", "Короткий контакт", "Первый контролируемый выстрел после смены укрытия легче удержать", 5, "full", "Каталог/будущий эффект после проверки безопасного условия.", "verify"] call _addPerk;
["reflexes", "ref_elite_drill", "Элитная муштра", "Сводит вместе подтверждённые reload и recoil-бонусы", 6, "full", "Не добавляет новых скрытых механик.", "ready"] call _addPerk;
["reflexes", "ref_master_control", "Мастер контроля", "Финальный cap для оружейного контроля", 6, "full", "Ограничивает суммарные бонусы, чтобы дерево не ушло в laser-beam.", "verify"] call _addPerk;

// Technical
["technical", "tech_vehicle_diagnostics", "Диагностика узлов", "Показывает понятную сводку повреждений техники при осмотре", 0, "ui", "Не чинит, только объясняет повреждённые узлы.", "verify"] call _addPerk;
["technical", "tech_field_patch", "Полевая заплатка", "После успешного ACE-ремонта лучше стабилизирует повреждённый узел", 0, "full", "Инструменты и условия ACE остаются обязательными.", "verify"] call _addPerk;
["technical", "tech_tool_habit", "Привычка к инструменту", "Уменьшает ошибки только при наличии нужного инструмента", 0, "full", "Никакого ремонта без инструмента или ресурсов.", "verify"] call _addPerk;
["technical", "tech_refuel_hand", "Заправщик", "Улучшает работу с ACE-заправкой", 1, "full", "Привязка к ACE refuel events: начало, тики, остановка.", "verify"] call _addPerk;
["technical", "tech_rearm_hand", "Боекомплектчик", "Улучшает rearm-обслуживание при подтверждённом hook", 1, "full", "Не создаёт боеприпасы из воздуха.", "verify"] call _addPerk;
["technical", "tech_repair_triage", "Ремонтный приоритет", "UI подсказывает, что важнее чинить: двигатель, колёса, башню, корпус", 1, "ui", "Информационная помощь инженеру без изменения ACE-правил.", "ready"] call _addPerk;
["technical", "tech_sapper", "Сапёр", "Бонус к обезвреживанию через ACE explosives events", 2, "full", "Не даёт 100% безопасное разминирование.", "verify"] call _addPerk;
["technical", "tech_mine_marker", "Метки сапёра", "Локальная отметка уже обнаруженной мины / взрывчатки", 2, "ui", "Без глобального раскрытия карты и без информации через стены.", "verify"] call _addPerk;
["technical", "tech_fortifier", "Фортификатор", "Быстрее или удобнее строит укрепления", 3, "full", "Материалы и условия остаются обязательными.", "verify"] call _addPerk;
["technical", "tech_wheel_priority", "Приоритет ходовой", "UI выделяет колёса / гусеницы как приоритет восстановления", 3, "ui", "Помогает ремонту мобильности, но не чинит автоматически.", "ready"] call _addPerk;
["technical", "tech_master_mechanic", "Мастер-механик", "Мастер-перк: диагностика + repair / refuel / rearm-бонусы", 4, "full", "Не даёт бесплатный ремонт и не увеличивает HP техники глобально.", "verify"] call _addPerk;
["technical", "tech_engine_stabilizer", "Стабилизация двигателя", "После успешного ремонта снижает риск повторной остановки двигателя", 4, "full", "Нужна проверка hitpoint/event поверхности техники.", "verify"] call _addPerk;
["technical", "tech_refuel_safety", "Безопасная заправка", "Меньше ошибок и остановок при работе с ACE-заправкой", 5, "full", "Не ускоряет бесконечно и не создаёт топливо.", "verify"] call _addPerk;
["technical", "tech_rearm_accounting", "Учёт БК", "UI показывает расход и пополнение боекомплекта при обслуживании", 5, "ui", "Без создания боеприпасов и без глобальной разведки запасов.", "ready"] call _addPerk;
["technical", "tech_recovery_rig", "Эвакуационный комплект", "Улучшает восстановление сильно повреждённой техники после успешного ремонта", 6, "full", "Работает только при выполненных ACE-условиях ремонта.", "verify"] call _addPerk;
["technical", "tech_engineer_command", "Инженерный контроль", "Финальная панель инженера: диагностика, ремонт, топливо, БК", 6, "ui", "Сводный UI-перк без бесплатных ресурсов.", "verify"] call _addPerk;

// Intelligence
["intelligence", "int_field_diagnosis", "Быстрая оценка", "Понятнее показывает состояние пациента", 0, "ui", "Кровь, раны, переломы, сознание. Без бесплатного лечения.", "ready"] call _addPerk;
["intelligence", "int_treatment_protocol", "Жгут и бинт", "После успешного лечения улучшает качество стабилизации", 0, "full", "Работает от ACE treatment success, не ускоряет действие без проверки API.", "verify"] call _addPerk;
["intelligence", "int_triage_list", "Триаж", "Локальный список ближайших раненых союзников с приоритетом лечения", 0, "ui", "Помогает медику выбирать цель, не лечит и не раскрывает врагов.", "ready"] call _addPerk;
["intelligence", "int_blood_control", "Контроль кровотечения", "Медик лучше стабилизирует кровотечение у пациента", 1, "full", "Только после успешного ACE-treatment. Нужна проверка структуры wounds.", "verify"] call _addPerk;
["intelligence", "int_suture_master", "Мастер шва", "После успешных швов снижает риск повторного ухудшения раны", 1, "full", "Пост-эффект после suture, без обещания ускорения шитья.", "verify"] call _addPerk;
["intelligence", "int_pharmacology", "Фармаколог", "Лучше работает с препаратами ACE", 1, "full", "Только конкретные ограниченные эффекты, без бесконечной выносливости.", "verify"] call _addPerk;
["intelligence", "int_revive_focus", "Реаниматолог", "После успешного revive пациент получает короткую стабилизацию", 2, "full", "Кулдаун на пациента. Не мгновенное воскрешение.", "ready"] call _addPerk;
["intelligence", "int_aftercare", "Постреанимационный уход", "После подъёма показывает медику, что ещё нужно сделать", 2, "ui", "Кровь, раны, шины, препараты; только подсказка.", "ready"] call _addPerk;
["intelligence", "int_drug_log", "Журнал препаратов", "UI отслеживает последние введённые препараты пациента", 2, "ui", "Помогает избежать повторного морфина / адреналина без понимания состояния.", "ready"] call _addPerk;
["intelligence", "int_team_vitals", "Командные виталы", "Ограниченная медицинская панель по группе", 3, "ui", "Без wallhack-информации и без частого тяжёлого polling.", "verify"] call _addPerk;
["intelligence", "int_tourniquet_audit", "Контроль жгутов", "Подсказка медику о наложенных жгутах и риске забыть их снять", 3, "ui", "Не лечит, только снижает человеческую ошибку.", "ready"] call _addPerk;
["intelligence", "int_blood_request", "Запрос крови", "Подсказка по необходимости крови / плазмы / saline после диагностики", 3, "ui", "Не выдаёт ресурсы, только формирует медицинский приоритет.", "ready"] call _addPerk;
["intelligence", "int_combat_medic", "Боевой медик", "Мастер-перк: diagnosis / triage / revive / stabilization", 4, "full", "Не делает мгновенное лечение и не отменяет ACE medical.", "verify"] call _addPerk;
["intelligence", "int_stable_window", "Окно стабильности", "После грамотной стабилизации пациент медленнее ухудшается короткое время", 4, "full", "Только после успешных ACE-treatment событий, с кулдауном.", "verify"] call _addPerk;
["intelligence", "int_medical_route", "Маршрут эвакуации", "UI помогает выбрать, кого эвакуировать первым", 5, "ui", "Локальная сортировка пациентов по медицинскому приоритету.", "ready"] call _addPerk;
["intelligence", "int_master_protocol", "Протокол выживания", "Финальный cap медицинских бонусов дерева", 6, "full", "Ограничивает суммарную стабилизацию, чтобы медик не стал бессмертием для отряда.", "verify"] call _addPerk;

// Cool / future RPG_stress
["cool", "cool_recovery_drill", "Восстановление темпа", "Быстрее снижает RPG_stress после выхода из боя", 0, "future", "Нужен отдельный модуль RPG_stress.", "later"] call _addPerk;
["cool", "cool_clear_head", "Ясная голова", "Уменьшает UI-эффекты собственного stress-модуля", 0, "future", "Затемнение, шум, дрожание интерфейса; не ACE medical.", "later"] call _addPerk;
["cool", "cool_under_pressure", "Работа под давлением", "Снижает штраф RPG_stress к лечению / ремонту", 1, "future", "Только если такой штраф будет введён.", "later"] call _addPerk;
["cool", "cool_shell_recovery", "После взрыва", "Быстрее восстанавливает stress / disorientation после близкого взрыва", 1, "future", "Нужна честная фиксация близкого взрыва.", "later"] call _addPerk;
["cool", "cool_blood_calm", "Хладнокровие", "При низкой крови снижает только стрессовый UI-эффект", 2, "future", "Не отменяет ACE-тремор, боль или кровопотерю.", "later"] call _addPerk;
["cool", "cool_noise_filter", "Фильтр шума", "Снижает визуально-звуковой шум собственного stress-модуля", 2, "future", "Не скрывает реальные звуки выстрелов от игроков и ботов.", "later"] call _addPerk;
["cool", "cool_combat_focus", "Боевой фокус", "Коротко ограничивает рост RPG_stress после реального ранения", 3, "future", "Большой кулдаун, без бессмертия и без бонуса за бездействие.", "later"] call _addPerk;
["cool", "cool_task_lock", "Фиксация задачи", "Под стрессом меньше проседают действия лечения / ремонта", 3, "future", "Только если RPG_stress будет давать такой штраф.", "later"] call _addPerk;
["cool", "cool_veteran", "Ветеран", "Мастер-перк: общий cap на RPG_stress", 4, "future", "Без скрытности, бесшумности и отмены ACE medical.", "later"] call _addPerk;
["cool", "cool_breathing_timer", "Счёт дыхания", "Игрок быстрее выводит интерфейсный стресс в норму после укрытия", 4, "future", "Не влияет на оружейное дыхание или точность.", "later"] call _addPerk;
["cool", "cool_casualty_control", "Контроль потерь", "Меньше стресс от вида тяжело раненых союзников", 5, "future", "Работает только на RPG_stress и не лечит союзников.", "later"] call _addPerk;
["cool", "cool_contact_report", "Доклад контакта", "Командное действие снижает рост стресса после обнаружения угрозы", 5, "future", "Требует отдельного события доклада / отметки контакта.", "later"] call _addPerk;
["cool", "cool_recovery_anchor", "Точка восстановления", "В безопасной зоне стресс уходит быстрее", 5, "future", "Не даёт бонус за сидение на базе, только восстановление уже накопленного стресса.", "later"] call _addPerk;
["cool", "cool_fireline", "Линия огня", "Под плотным контактом stress cap растёт медленнее", 6, "future", "Нужна честная фиксация боевого контакта, не просто отсутствие урона.", "later"] call _addPerk;
["cool", "cool_veteran_scar", "Шрам ветерана", "Повторные похожие стресс-события слабее раскачивают UI", 6, "future", "Адаптация только к RPG_stress, без иммунитета.", "later"] call _addPerk;
["cool", "cool_stress_commander", "Командир под давлением", "Финальный cap и командная стабилизация stress-модуля", 6, "future", "Не даёт скрытность, бесшумность, бессмертие или отмену ACE medical.", "later"] call _addPerk;

// Backward-compatible physiology map used by existing code and diagnostics.
RPG_CONSTITUTION_PERKS = createHashMap;
{
    RPG_CONSTITUTION_PERKS set [
        _x get "id",
        [
            _x get "name",
            _x get "description",
            _x get "tier",
            _x get "type",
            "",
            _x get "detail",
            _x get "status"
        ]
    ];
} forEach (RPG_PERKS_BY_TREE getOrDefault ["constitution", []]);
RPG_CONSTITUTION_TIER_LEVELS = +RPG_PERK_TIER_LEVELS;

diag_log format ["[RPG] Skills/perks initialized: %1 trees, %2 perks", count RPG_SKILL_TYPES, count (keys RPG_PERKS)];
