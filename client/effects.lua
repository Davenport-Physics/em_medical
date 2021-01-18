
local function register_effect_function(effect, func_type, func)

    effect[func_type] = func

end

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
    if effect.intro ~= nil then
        effect.intro()
    end

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

    if effect.outro ~= nil then
        effect.outro()
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

register_effect_function(EFFECTS.KNOCKED_OUT, "intro", function() 

    DoScreenFadeOut(1000)
    SetPedToRagdollWithFall(ped, PLAYER.SHORTERM_EFFECTS["Knocked Out"].effect_time + 1000, PLAYER.SHORTERM_EFFECTS["Knocked Out"].effect_time + 1000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

end)

register_effect_function(EFFECTS.KNOCKED_OUT, "outro", function() 

    if IsScreenFadedOut() then
        DoScreenFadeIn(1500)
    end

end)

register_effect_function(EFFECTS.ADRENALINE, "intro", function() 

    PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
    AnimpostfxPlay("FocusIn", 500, false)

end)

register_effect_function(EFFECTS.ADRENALINE, "loop", function() 

    pain_level_set(0)

end)

register_effect_function(EFFECTS.ADRENALINE, "outro", function() 

    apply_short_term_effect(EFFECTS.NO_ADRENALINE)

end)

register_effect_function(EFFECTS.NO_ADRENALINE, "intro", function() 

    PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
    AnimpostfxStop("FocusIn")
    AnimpostfxPlay("FocusOut", 500, false)

end)

register_effect_function(EFFECTS.NO_ADRENALINE, "loop", function() 

    pain_level_modifier(0.20)

end)

register_effect_function(EFFECTS.SHOCK, "loop", function() 

    if not DoesEntityExist(GetVehiclePedIsIn(ped, false)) and not IsEntityPlayingAnim(ped, "missarmenian2", "corpse_search_exit_ped", 2) then
        TaskPlayAnim(ped, "missarmenian2", "corpse_search_exit_ped", 100.0, -100.0, -1, 2, 1.0, false, false, false)
    end

end)

register_effect_function(EFFECTS.SHOCK, "outro", function() 

    ClearPedTasksImmediately(ped)

end)

function debug_effects()

    assert(not (PLAYER.SHORTERM_EFFECTS["Adrenaline"] ~= nil and PLAYER.SHORTERM_EFFECTS["No Adrenaline"] ~= nil))

end

function short_term_effects()

    for effect_name, effect_info in pairs(PLAYER.SHORTERM_EFFECTS) do
        
        local effect = get_effect_info(effect_name)
        if effect.loop ~= nil then
            effect.loop()
        end

    end

    reduce_all_effect_times()

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

function apply_knocked_out()

    apply_short_term_effect(EFFECTS.KNOCKED_OUT)

end

function apply_shock()

    apply_short_term_effect(EFFECTS.SHOCK)

end