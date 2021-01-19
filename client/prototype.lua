

-- GetWeaponDamageType(Hash weaponHash)
--[[

0=unknown (or incorrect weaponHash)  
1= no damage (flare,snowball, petrolcan)  
2=melee  
3=bullet  
4=force ragdoll fall  
5=explosive (RPG, Railgun, grenade)  
6=fire(molotov)  
8=fall(WEAPON_HELI_CRASH)  
10=electric  
11=barbed wire  
12=extinguisher  
13=gas  
14=water cannon(WEAPON_HIT_BY_WATER_CANNON)  

-- BOOL HAS_PED_BEEN_DAMAGED_BY_WEAPON(Ped ped, Hash weaponHash, int weaponType);
--[[
    It determines what weapons caused damage:  
    If you want to define only a specific weapon, second parameter=weapon hash code, third parameter=0  
    If you want to define any melee weapon, second parameter=0, third parameter=1.  
    If you want to identify any weapon (firearms, melee, rockets, etc.), second parameter=0, third parameter=2.
]]

-- BOOL IS_PED_MALE(Ped ped);
-- BOOL IS_PED_RAGDOLL(Ped ped);


-- _GET_TIME_OF_LAST_PED_WEAPON_DAMAGE
-- local retval = GetTimeOfLastPedWeaponDamage(ped, weaponHash)

local function check_all_timed_damage()

    local temp_table = {}
    for i = 1, #WEAPON_HASHES do
        local retval = GetTimeOfLastPedWeaponDamage(ped, WEAPON_HASHES[i][2])
        if GetGameTimer() - retval < 20 then
            table.insert(temp_table, WEAPON_HASHES[i][1])
        end
    end
    if #temp_table > 0 then
        print("timed: " .. json.encode(temp_table))
    end

end

local function check_all_damage()

    local temp_table = {}
    for i = 1, #WEAPON_HASHES do
        local retval = HasEntityBeenDamagedByWeapon(ped, WEAPON_HASHES[i].hash, 0)
        if retval then
            table.insert(temp_table, WEAPON_HASHES[i])
        end
    end
    if #temp_table > 0 then
        print("All damage :" .. json.encode(temp_table))
    end

    return temp_table

end

local function damage_loop()

    local weapons = check_all_damage()
    local _, out_bone = GetPedLastDamageBone(ped)

    for i = 1, #weapons do

        if out_bone ~= 0 then
            apply_weapon_damage(out_bone, weapons[i])
            break
        else
            attempt_to_apply_weapon_type_damage(weapons[i])
            break
        end

    end
    ClearEntityLastDamageEntity(ped)
    ClearEntityLastWeaponDamage(ped)

end


local function effects_loop()

    debug_effects()
    calculate_player_modifiers()
    apply_player_modifiers()
    short_term_effects()
    check_to_down_player()

end

local function bandage_loop()

    --calculate_blood_loss()

end

local function start_damage_loop()

    Citizen.CreateThread(function ()
    
        Citizen.Wait(0)
        while true do
    
            ped = PlayerPedId()
            damage_loop()
            Citizen.Wait(20)
    
        end
    
    end)

end

local function start_long_loop()

    Citizen.CreateThread(function() 

        Citizen.Wait(0)
        while true do

            --print(GetEntityHealth(ped))
            check_wound_heal_time()
            bandage_loop()
            effects_loop()
            body_part_cleanup()
            Citizen.Wait(100)

        end
    
    end)

end


start_damage_loop()
start_long_loop()

RegisterCommand("check_player", function (source, args, raw)

    print(json.encode(PLAYER))
    print(json.encode(PLAYER_MODIFIERS))

end)

RegisterCommand("give_adrenaline", function (source, args, raw)

    apply_adrenaline()

end)

RegisterCommand("give_knocked_out", function (source, args, raw)

    apply_knocked_out()

end)

RegisterCommand("give_shock", function (source, args, raw)

    apply_shock()

end)
    

RegisterCommand("clear_wounds", function (source, args, raw)

    PLAYER.WOUNDS = {}

end)
