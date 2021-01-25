RequestAnimDict('mp_player_intdrink')
RequestAnimDict('mp_player_inteat@burger')

function GetStat(name)

    assert(name ~= nil)
    return PLAYER.MISC_LEVELS[name:upper()]

end


function ModStat(name, amount)

    assert(name ~= nil)
    local upper = name:upper()
    if PLAYER.MISC_LEVELS[upper] ~= nil then
        PLAYER.MISC_LEVELS[upper] = PLAYER.MISC_LEVELS[upper] + amount
    else
        Citizen.Trace("No stat by name of " .. name .. "\n")
    end

end

function GetStatMax(name)

    assert(name ~= nil)
    return PLAYER_MAX_LEVEL[name:upper()]

end

function SetStatMax(name, amount)

end

function ResetStatMaxes()

    PLAYER.MISC_LEVELS.FOOD   = PLAYER_MAX_LEVEL.FOOD
    PLAYER.MISC_LEVELS.WATER  = PLAYER_MAX_LEVEL.WATER
    PLAYER.MISC_LEVELS.STRESS = PLAYER_MAX_LEVEL.STRESS

end

function ResetStats(ToCurrentMaxes)

    PLAYER.MISC_LEVELS.FOOD   = PLAYER_MAX_LEVEL.FOOD
    PLAYER.MISC_LEVELS.WATER  = PLAYER_MAX_LEVEL.WATER
    PLAYER.MISC_LEVELS.STRESS = 0

end

function food_loop()

    if PLAYER.MISC_LEVELS.FOOD > PLAYER_MAX_LEVEL.FOOD then
        PLAYER.MISC_LEVELS.FOOD = PLAYER_MAX_LEVEL.FOOD
    end

    if PLAYER.MISC_LEVELS.FOOD <= 0 then
        if not is_player_unconscious() then
            apply_short_term_effect(EFFECTS.STARVED)
        end
    else
        if IsPedInAnyVehicle(ped, false) then
            PLAYER.MISC_LEVELS.FOOD = PLAYER.MISC_LEVELS.FOOD - 138
        else
            if IsPedSwimming(ped) or IsPedSwimmingUnderWater(ped) then
                PLAYER.MISC_LEVELS.FOOD = PLAYER.MISC_LEVELS.FOOD - 555 -- ~30 Mins of swimming
            elseif IsPedRunning(ped) or IsPedSprinting(ped) then
                PLAYER.MISC_LEVELS.FOOD = PLAYER.MISC_LEVELS.FOOD - 555 -- ~30 Mins of running
            elseif IsPedWalking(ped) then
                PLAYER.MISC_LEVELS.FOOD = PLAYER.MISC_LEVELS.FOOD - 277 -- ~1 Hour of walking
            else
                PLAYER.MISC_LEVELS.FOOD = PLAYER.MISC_LEVELS.FOOD - 138 -- ~2 Hours standing still
            end
        end
    end

end

function water_loop()

    if PLAYER.MISC_LEVELS.WATER > PLAYER_MAX_LEVEL.WATER then
        PLAYER.MISC_LEVELS.WATER = PLAYER_MAX_LEVEL.WATER
    end

    if PLAYER.MISC_LEVELS.WATER <= 0 then
        if not is_player_unconscious() then
            apply_short_term_effect(EFFECTS.DEHYDRATED)
        end
    else
        if IsPedInAnyVehicle(ped, false) then
            PLAYER.MISC_LEVELS.WATER = PLAYER.MISC_LEVELS.WATER - 138
        else
            if IsPedRunning(ped) or IsPedSprinting(ped) then
                PLAYER.MISC_LEVELS.WATER = PLAYER.MISC_LEVELS.WATER - 555  -- ~30 Mins of running
            elseif IsPedWalking(ped) then
                PLAYER.MISC_LEVELS.WATER = PLAYER.MISC_LEVELS.WATER - 277 -- ~1 Hour of walking
            else
                PLAYER.MISC_LEVELS.WATER = PLAYER.MISC_LEVELS.WATER - 138 -- ~2 Hours of standing still
            end
        end
    end
end


function OnEat(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ped, 18905)
			AttachEntityToEntity(prop, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

            TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

            Citizen.Wait(3000)
            IsAnimated = false
            ClearPedSecondaryTask(ped)
            DeleteObject(prop)
		end)
	end
end

function OnDrink(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ped, 18905)
			AttachEntityToEntity(prop, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

            TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

            Citizen.Wait(3000)
            IsAnimated = false
            ClearPedSecondaryTask(ped)
            DeleteObject(prop)
		end)
    end
end

function OnDonut(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_donut_02'
		IsAnimated = true
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(ped, 18905)
			AttachEntityToEntity(prop, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
            TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
            Citizen.Wait(3000)
            IsAnimated = false
            ClearPedSecondaryTask(ped)
            DeleteObject(prop)
		end)
	end
end