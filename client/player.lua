
PLAYER = {
    BLOOD_PRESSURE = {systolic = 100, diastolic = 75},
    WOUNDS = {},
    BANDAGES = {},
    SHORTERM_EFFECTS = {},
    PERMANENT_EFFECTS = {}
}

PLAYER_MODIFIERS = {
    PAIN_LEVEL = 0,
    STIMULANT_LEVEL = 0,
    DEPRESSANTS_LEVEL = 0
}

PLAYER_STATS = {
    HEALTH = 0,
    ARMOUR = 0,
    LAST_HEALTH_DIFF = 0,
    LAST_ARMOUR_DIFF = 0
}

ped = nil

function pain_level_modifier(modifier)

    PLAYER_MODIFIERS.PAIN_LEVEL = PLAYER_MODIFIERS.PAIN_LEVEL + modifier * PLAYER_MODIFIERS.PAIN_LEVEL

end

function pain_level_set(level)

    PLAYER_MODIFIERS.PAIN_LEVEL = level

end


local function get_wound_pain(wound, wound_amount)

    for _, wound_info in pairs(WOUND_TYPES) do
        
        if wound_info.name == wound then

            return wound_info.pain_level * wound_amount

        end

    end

    return 0

end

function calculate_pain_level()

    PLAYER_MODIFIERS.PAIN_LEVEL = 0
    for _, wounds in pairs(PLAYER.WOUNDS) do
        
        for wound, wound_info in pairs(wounds) do
            
            PLAYER_MODIFIERS.PAIN_LEVEL = PLAYER_MODIFIERS.PAIN_LEVEL + get_wound_pain(wound, wound_info.amount)

        end

    end

end

local function get_modifier_level(effect_info, modifier_name)

    if effect_info.modifiers == nil then
        return 0
    end

    return effect_info.modifiers[modifier_name] or 0

end

local function apply_stimulant_modifier()


end

local function apply_depressant_modifier()

end

local function apply_sprint_modifier()

    local run_multiplier = PLAYER_MODIFIERS.STIMULANT_LEVEL/20.0 - PLAYER_MODIFIERS.DEPRESSANTS_LEVEL/15.0
    if run_multiplier > 0.49 then
        run_multiplier = 0.49
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0 + run_multiplier)

end

local function apply_shared_modifier()

    apply_sprint_modifier()

end

function calculate_stimulatant_depressant_level()

    PLAYER_MODIFIERS.STIMULANT_LEVEL = 0
    PLAYER_MODIFIERS.DEPRESSANTS_LEVEL = 0
    for effect_name, _ in pairs(PLAYER.SHORTERM_EFFECTS) do
        
        for __, effect_info in pairs(EFFECTS) do
            
            if effect_name == effect_info.name then

                PLAYER_MODIFIERS.STIMULANT_LEVEL   = PLAYER_MODIFIERS.STIMULANT_LEVEL + get_modifier_level(effect_info, "stimulant")
                PLAYER_MODIFIERS.DEPRESSANTS_LEVEL = PLAYER_MODIFIERS.DEPRESSANTS_LEVEL + get_modifier_level(effect_info, "depressant")

            end

        end

    end

end

function calculate_player_modifiers()

    calculate_pain_level()
    calculate_stimulatant_depressant_level()

end

function get_wound_hit_modifier()

    local hit_severity = get_hit_severity()

    if hit_severity == DAMAGE_SEVERITY_TYPES.NONE then
        return 0
    elseif hit_severity == DAMAGE_SEVERITY_TYPES.MINOR then
        return 1
    elseif hit_severity == DAMAGE_SEVERITY_TYPES.MEDIUM then
        return 2
    elseif hit_severity == DAMAGE_SEVERITY_TYPES.SEVERE then
        return 3
    elseif hit_severity == DAMAGE_SEVERITY_TYPES.CRTICICAL then
        return 5
    end

end

function get_hit_severity()

    if PLAYER_STATS.LAST_HEALTH_DIFF >= 0 then
        return DAMAGE_SEVERITY_TYPES.NONE
    end

    local health_diff = -PLAYER_STATS.LAST_HEALTH_DIFF

    if health_diff < 15 then
        return DAMAGE_SEVERITY_TYPES.MINOR
    elseif health_diff < 60 then
        return DAMAGE_SEVERITY_TYPES.MEDIUM
    elseif health_diff < 100 then
        return DAMAGE_SEVERITY_TYPES.SEVERE
    elseif health_diff < 200 then
        return DAMAGE_SEVERITY_TYPES.CRTICICAL
    end

end

function calculate_health_armour()

    local current_health = GetEntityHealth(ped)
    local current_armour = GetPedArmour(ped)

    PLAYER_STATS.LAST_HEALTH_DIFF = current_health - PLAYER_STATS.LAST_HEALTH
    PLAYER_STATS.LAST_ARMOUR_DIFF = current_armour - PLAYER_STATS.LAST_ARMOUR

    PLAYER_STATS.LAST_HEALTH = current_health
    PLAYER_STATS.LAST_ARMOUR = current_armour


    SetEntityHealth(ped, 200)

end

function apply_player_modifiers()

    apply_stimulant_modifier()
    apply_depressant_modifier()
    apply_shared_modifier()

end

function check_to_down_player() 

    if PLAYER_MODIFIERS.PAIN_LEVEL >= PAIN_THRESHOLD_BEFORE_SHOCK then
        apply_shock()
    end

end