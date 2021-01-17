
--[[

    PLAYER = {
        BLOOD_PRESSURE = {SYSTOLIC = 100, DIASTOLIC = 75},
        WOUNDS = {},
        BANDAGES = {},
        TEMPORARY_EFFECTS = {},
        LONGTERM_EFFECTS  = {},
        PERMANENT_EFFECTS = {}
    }

]]

function calculate_pain()



end

local function reduce_effect_time(effect)

    local effect_vec = PLAYER.SHORTERM_EFFECTS[effect]
    local current_time = GetGameTimer()
    local dt = current_time - effect_vec.last_update_time
    
    effect_vec.effect_time = effect_vec.effect_time - dt
    effect_vec.last_update_time = current_time

end

local function adrenaline_effect()

    if PLAYER.SHORTERM_EFFECTS["Adrenaline"] ~= nil then

        PLAYER.PAIN_LEVEL = 0
        reduce_effect_time("Adrenaline")
        if PLAYER.SHORTERM_EFFECTS["Adrenaline"].effect_time <= 0 then

            PLAYER.SHORTERM_EFFECTS["Adrenaline"] = nil
            PLAYER.SHORTERM_EFFECTS["No Adrenaline"] = {effect_time = 1000*360, last_update_time = GetGameTimer()}

        end

    elseif PLAYER.SHORTERM_EFFECTS["No Adrenaline"] ~= nil then

        PLAYER.PAIN_LEVEL = PLAYER.PAIN_LEVEL + 0.20 * PLAYER.PAIN_LEVEL
        reduce_effect_time("No Adrenaline")
        if PLAYER.SHORTERM_EFFECTS["No Adrenaline"].effect_time <= 0 then

            PLAYER.SHORTERM_EFFECTS["No Adrenaline"] = nil

        end

    end

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