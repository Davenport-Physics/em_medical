
local function register_bone_hit_function(bone, func)

	bone.func = func

end

local function register_weapon_use_function(weapon, func)

	weapon.func = func

end

local function add_wound(bone, wound_type, amount)

	local bone_name = bone.name
	local amount_to_add = amount or 1

	if PLAYER.WOUNDS[bone_name] == nil then
		PLAYER.WOUNDS[bone_name] = {}
	end

	if PLAYER.WOUNDS[bone_name][wound_type.name] == nil then
		PLAYER.WOUNDS[bone_name][wound_type.name] = {amount = 0}
		if wound_type.heal_time ~= nil then
			PLAYER.WOUNDS[bone_name][wound_type.name].heal_time = wound_type.heal_time * 1000
			PLAYER.WOUNDS[bone_name][wound_type.name].last_update_time = GetGameTimer()
		end
	end
	
	if PLAYER.WOUNDS[bone_name][wound_type.name].amount == 5 then
		return 0
	end

	PLAYER.WOUNDS[bone_name][wound_type.name].amount = PLAYER.WOUNDS[bone_name][wound_type.name].amount + amount_to_add
	PLAYER.WOUNDS[bone_name][wound_type.name].last_update_time = GetGameTimer()

	if PLAYER.WOUNDS[bone_name][wound_type.name].amount > 5 then
		PLAYER.WOUNDS[bone_name][wound_type.name].amount = 5
	end

end

local function apply_hand_damage(bone, weapon)

	add_wound(bone, WOUND_TYPES.SMALL_CONTUSION, 2)

end

local function apply_mild_blunt(bone, weapon)

	add_wound(bone, WOUND_TYPES.CONTUSION, 2)

end

local function apply_severe_blunt(bone, weapon)

	add_wound(bone, WOUND_TYPES.LACERATION, 1)
	add_wound(bone, WOUND_TYPES.LARGE_CONTUSION, 2)

end

local function apply_sharp(bone, weapon)

	add_wound(bone, WOUND_TYPES.PUNCTURE_WOUND)

end

local function apply_severe_sharp(bone, weapon)

	add_wound(bone, WOUND_TYPES.LARGE_PUNCTURE_WOUND)

end

local function apply_small_caliber_round(bone, weapon)

	--if GetPedArmour(ped) > 0 then

	--end
	add_wound(bone, WOUND_TYPES.SMALL_GUN_SHOT)
	add_wound(bone, WOUND_TYPES.SMALL_GUN_SHOT_EXIT)

end

local function apply_medium_caliber_round(bone, weapon)

	add_wound(bone, WOUND_TYPES.MEDIUM_GUN_SHOT)
	add_wound(bone, WOUND_TYPES.MEDIUM_GUN_SHOT_EXIT)

end

local function apply_large_caliber_round(bone, weapon)

	add_wound(bone, WOUND_TYPES.LARGE_GUN_SHOT)
	add_wound(bone, WOUND_TYPES.LARGE_GUN_SHOT_EXIT)

end

local function apply_less_lethal(bone, weapon)

end

local function apply_fire(bone, weapon)

	add_wound(bone, WOUND_TYPES.SECOND_DEGREE_BURN)

end

local function apply_teeth(bone, weapon)

end

local function apply_hand(bone, weapon)

	add_wound(bone, WOUND_TYPES.SMALL_CONTUSION)
	add_wound(bone, WOUND_TYPES.SMALL_LACERATION)

end

local function apply_arrow(bone, weapon)

	add_wound(bone, WOUND_TYPES.LARGE_PUNCTURE_WOUND)

end

local function apply_severe_arrow(bone, weapon)

end

local function apply_explosion(bone, weapon)

	add_wound(bone, WOUND_TYPES.SECOND_DEGREE_BURN)
	add_wound(bone, WOUND_TYPES.LARGE_LACERATION, 2)

end

local function apply_shotgun_shell(bone, weapon)

	add_wound(bone_idx, WOUND_TYPES.MEDIUM_GUN_SHOT)

end

local function apply_severe_shotgun_shell(bone, weapon)

	add_wound(bone, WOUND_TYPES.MEDIUM_GUN_SHOT)

end

local function apply_vehicle(bone, weapon)
	
	add_wound(bone, WOUND_TYPES.LACERATION, 3)
	add_wound(bone, WOUND_TYPES.CONTUSION, 2)

end

local function apply_fall(bone, weapon)

	add_wound(bone, WOUND_TYPES.LARGE_CONTUSION)

end

local function apply_drowning(bone, weapon)

end

local function apply_mild_irritant(bone, weapon)

end

local function apply_irritant(bone, weapon)

end

local function apply_severe_irritant(bone, weapon)

end

local WEAPON_TYPE_FUNCTIONS = 
{

	{weapon_type = WEAPON_TYPES.MILD_BLUNT, func = apply_hand_damage},
	{weapon_type = WEAPON_TYPES.BLUNT, func = apply_mild_blunt},
	{weapon_type = WEAPON_TYPES.SEVERE_BLUNT, func = apply_severe_blunt},
	{weapon_type = WEAPON_TYPES.SHARP, func = apply_sharp},
	{weapon_type = WEAPON_TYPES.SEVERE_SHARP, func = apply_severe_sharp},
	{weapon_type = WEAPON_TYPES.SMALL_CALIBER_ROUND, func = apply_small_caliber_round},
	{weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND, func = apply_medium_caliber_round},
	{weapon_type = WEAPON_TYPES.LARGE_CALIBER_ROUND, func = apply_large_caliber_round},
	{weapon_type = WEAPON_TYPES.LESS_LETHAL, func = apply_less_lethal},
	{weapon_type = WEAPON_TYPES.FIRE, func = apply_fire},
	{weapon_type = WEAPON_TYPES.TEETH, func = apply_teeth},
	{weapon_type = WEAPON_TYPES.HAND, func = apply_hand},
	{weapon_type = WEAPON_TYPES.ARROW, func = apply_arrow},
	{weapon_type = WEAPON_TYPES.SEVERE_ARROW, func = apply_severe_arrow},
	{weapon_type = WEAPON_TYPES.EXPLOSION, func = apply_explosion},
	{weapon_type = WEAPON_TYPES.SHOTGUN_SHELL, func = apply_shotgun_shell},
	{weapon_type = WEAPON_TYPES.SEVERE_SHOTGUN_SHELL, func = apply_severe_shotgun_shell},
	{weapon_type = WEAPON_TYPES.VEHICLE, func = apply_vehicle},
	{weapon_type = WEAPON_TYPES.FALL, func = apply_fall},
	{weapon_type = WEAPON_TYPES.DROWNING, func = apply_drowning},
	{weapon_type = WEAPON_TYPES.MILD_IRRITANT, func = apply_mild_irritant},
	{weapon_type = WEAPON_TYPES.IRRITANT, func = apply_irritant},
	{weapon_type = WEAPON_TYPES.SEVERE_IRRITANT, func = apply_severe_irritant}

}

function apply_weapon_damage(out_bone, weapon)

    local bone = nil
    for _, temp_bone_info in pairs(CHECKED_BONES) do
        
        if temp_bone_info.hash == out_bone then
            bone = temp_bone_info
            break
        end

    end

	if bone == nil then
		print("Unknown bone " .. out_bone)
        return -1
    end

    for i = 1, #WEAPON_TYPE_FUNCTIONS do

		if WEAPON_TYPE_FUNCTIONS[i].weapon_type == weapon.weapon_type then
			apply_adrenaline()
            WEAPON_TYPE_FUNCTIONS[i].func(bone, weapon)
            break
        end

    end

end

function attempt_to_apply_weapon_type_damage(weapon)

	if weapon.name == "WEAPON_RUN_OVER_BY_CAR" then

		print("Applying WEAPON_RUN_OVER_BY_CAR")
		apply_vehicle(12, nil)
		apply_vehicle(13, nil)

		apply_vehicle(15, nil)
		apply_vehicle(16, nil)

	elseif weapon.name == "WEAPON_RAMMED_BY_CAR" then

		print("Applying WEAPON_RAMMED_BY_CAR")
		apply_vehicle(17, nil)
		apply_vehicle(20, nil)
		apply_vehicle(21, nil)

	elseif weapon.name == "WEAPON_UNARMED" then

		apply_hand(15, nil)
		apply_hand(16, nil)
		apply_hand(17, nil)

	end

end

local function wound_heal_time(body_part, wound, wound_info)

	if wound_info.heal_time == nil then
		return 0 
	end

	local current_time = GetGameTimer()
	local dt = current_time - wound_info.last_update_time

	wound_info.heal_time        = wound_info.heal_time - dt
	wound_info.last_update_time = current_time

	if wound_info.heal_time <= 0 then
		PLAYER.WOUNDS[body_part][wound] = nil
	end

end

function check_wound_heal_time()

	for body_part, wounds in pairs(PLAYER.WOUNDS) do
		
		for wound, wound_info in pairs(wounds) do

			wound_heal_time(body_part, wound, wound_info)

		end

	end

end

function body_part_cleanup()

	for body_part, wounds in pairs(PLAYER.WOUNDS) do
		if next(wounds) == nil then
			PLAYER.WOUNDS[body_part] = nil
		end
	end

end