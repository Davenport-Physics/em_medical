

local function pain_modifier(modifier)

    PLAYER.PAIN_LEVEL = PLAYER.PAIN_LEVEL + modifier * PLAYER.PAIN_LEVEL

end

local function reduce_effect_time(effect_type, effect)

    local effect_vec = effect_type[effect]
    local current_time = GetGameTimer()
    local dt = current_time - effect_vec.last_update_time

    effect_vec.effect_time = effect_vec.effect_time - dt
    effect_vec.last_update_time = current_time

end

local function get_wound_pain(wound, wound_amount)

    for _, wound_info in pairs(WOUND_TYPES) do
        
        if wound_info.name == wound then

            return wound_info.pain_level * wound_amount

        end

    end
    return 0

end

function calculate_pain()

    PLAYER.PAIN_LEVEL = 0
    for _, wounds in pairs(PLAYER.WOUNDS) do
        
        for wound, wound_info in pairs(wounds) do
            
            PLAYER.PAIN_LEVEL = PLAYER.PAIN_LEVEL + get_wound_pain(wound, wound_info.amount)

        end

    end

end

local function adrenaline_effect()

    if PLAYER.SHORTERM_EFFECTS["Adrenaline"] ~= nil then

        PLAYER.PAIN_LEVEL = 0
        reduce_effect_time(PLAYER.SHORTERM_EFFECTS, "Adrenaline")
        if PLAYER.SHORTERM_EFFECTS["Adrenaline"].effect_time <= 0 then

            PLAYER.SHORTERM_EFFECTS["Adrenaline"] = nil
            PLAYER.SHORTERM_EFFECTS["No Adrenaline"] = {effect_time = 1000*360, last_update_time = GetGameTimer()}

        end

    elseif PLAYER.SHORTERM_EFFECTS["No Adrenaline"] ~= nil then

        pain_modifier(0.20)
        reduce_effect_time(PLAYER.SHORTERM_EFFECTS, "No Adrenaline")
        if PLAYER.SHORTERM_EFFECTS["No Adrenaline"].effect_time <= 0 then

            PLAYER.SHORTERM_EFFECTS["No Adrenaline"] = nil

        end

    end

end

function debug_effects()

    assert(not (PLAYER.SHORTERM_EFFECTS["Adrenaline"] ~= nil and PLAYER.SHORTERM_EFFECTS["No Adrenaline"] ~= nil))

end

function short_term_effects()

    adrenaline_effect()

end

function long_term_effects()

end

function apply_adrenaline()

    if PLAYER.SHORTERM_EFFECTS["Adrenaline"] ~= nil then
        return 0
    end

    if PLAYER.SHORTERM_EFFECTS["No Adrenaline"] ~= nil then
        return 0
    end
    
	PLAYER.SHORTERM_EFFECTS["Adrenaline"] = {effect_time = 1000*180, last_update_time = GetGameTimer()}

end