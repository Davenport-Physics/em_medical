
function get_effect_info(effect_name)

    for _, effect_info in pairs(EFFECTS) do
        if effect_info.name == effect_name then
            return effect_info
        end
    end
    return nil

end

local function apply_short_term_effect(effect)

    PLAYER.SHORTERM_EFFECTS[effect.name] = {effect_time = effect.effect_time * 1000, last_update_time = GetGameTimer()}

end

local function reduce_effect_time(effect)

    local effect_vec = PLAYER.SHORTERM_EFFECTS[effect]
    local current_time = GetGameTimer()
    local dt = current_time - effect_vec.last_update_time

    effect_vec.effect_time = effect_vec.effect_time - dt
    effect_vec.last_update_time = current_time

end

local function remove_or_change_effect(effect_name)

    local effect = get_effect_info(effect_name)

    if effect.end_to ~= nil then
        apply_short_term_effect(get_effect_info(effect.end_to))
    end
    
    PLAYER.SHORTERM_EFFECTS[effect_name] = nil

end

local function reduce_all_effect_times()

    for effect_name, _ in pairs(PLAYER.SHORTERM_EFFECTS) do

        reduce_effect_time(effect_name)

        if PLAYER.SHORTERM_EFFECTS[effect_name].effect_time <= 0 then
            remove_or_change_effect(effect_name)
        end

    end

end

local function adrenaline_effect()

    if PLAYER.SHORTERM_EFFECTS["Adrenaline"] ~= nil then

        pain_level_set(0)

    elseif PLAYER.SHORTERM_EFFECTS["No Adrenaline"] ~= nil then

        pain_level_modifier(0.20)

    end

end

function debug_effects()

    assert(not (PLAYER.SHORTERM_EFFECTS["Adrenaline"] ~= nil and PLAYER.SHORTERM_EFFECTS["No Adrenaline"] ~= nil))

end

function short_term_effects()

    adrenaline_effect()
    reduce_all_effect_times()

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
    
    apply_short_term_effect(EFFECTS.ADRENALINE)

end