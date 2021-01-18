
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

    return effect_info.modifiers["stimulant"] or 0

end


function calculate_stimulatant_depressant_level()

    PLAYER_MODIFIERS.STIMULANT_LEVEL = 0
    PLAYER_MODIFIERS.DEPRESSANTS_LEVEL = 0
    for effect_name, _ in pairs(PLAYER.SHORTERM_EFFECTS) do
        
        for _, effect_info in pairs(EFFECTS) do
            
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