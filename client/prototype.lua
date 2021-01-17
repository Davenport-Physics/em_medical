

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

]]

--[[
    local retval, outBone = GetPedLastDamageBone(ped)
]]
-- pastebin.com/3pz17QGd

-- BOOL HAS_PED_BEEN_DAMAGED_BY_WEAPON(Ped ped, Hash weaponHash, int weaponType);
--[[
    It determines what weapons caused damage:  
    If you want to define only a specific weapon, second parameter=weapon hash code, third parameter=0  
    If you want to define any melee weapon, second parameter=0, third parameter=1.  
    If you want to identify any weapon (firearms, melee, rockets, etc.), second parameter=0, third parameter=2.
]]


-- GetTimeOfLastPedWeaponDamage
-- int _GET_TIME_OF_LAST_PED_WEAPON_DAMAGE(Ped ped, Any weaponHash);

-- BOOL IS_PED_MALE(Ped ped);
-- BOOL IS_PED_RAGDOLL(Ped ped);


-- _GET_TIME_OF_LAST_PED_WEAPON_DAMAGE
-- local retval = GetTimeOfLastPedWeaponDamage(ped, weaponHash)

local ped = nil

local function detect_weapon_hit()

    for i = 1, #WEAPON_HASHES do
        local retval = GetTimeOfLastPedWeaponDamage(ped, WEAPON_HASHES[i][2])
        if GetGameTimer() - retval < 2 then
            local _, out_bone = GetPedLastDamageBone(ped)
            if out_bone ~= 0 then
                apply_weapon_damage(out_bone, i)
                break
            end
        end
    end

end

local function damage_loop()

    detect_weapon_hit()

end


local function effects_loop()

    calculate_pain()
    short_term_effects()
    long_term_effects()

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

local function start_effects_loop()

    Citizen.CreateThread(function() 

        Citizen.Wait(0)
        while true do
            effects_loop()
            Citizen.Wait(100)
        end
    
    end)

end


start_damage_loop()
start_effects_loop()

RegisterCommand("check_effects", function (source, args, raw)

    print(json.encode(PLAYER.SHORTERM_EFFECTS))

end)

RegisterCommand("give_effect", function (source, args, raw)

    apply_adrenaline()

end)
    
