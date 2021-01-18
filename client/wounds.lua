
local function add_wound(bone_idx, wound_type, amount)

	local bone_name = CHECKED_BONES[bone_idx].name
	local amount_to_add = amount or 1

	if PLAYER.WOUNDS[bone_name] == nil then
		PLAYER.WOUNDS[bone_name] = {}
	end

	if PLAYER.WOUNDS[bone_name][wound_type.name] == nil then
		PLAYER.WOUNDS[bone_name][wound_type.name] = {amount = 0, heal_time = wound_type.heal_time * 1000, last_update_time = GetGameTimer()}
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

local function apply_hand_damage(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.SMALL_CONTUSION, 2)

end

local function apply_mild_blunt(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.CONTUSION, 2)

end

local function apply_severe_blunt(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.LACERATION, 1)
	add_wound(bone_idx, WOUND_TYPES.LARGE_CONTUSION, 2)

end

local function apply_sharp(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.PUNCTURE_WOUND)

end

local function apply_severe_sharp(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.LARGE_PUNCTURE_WOUND)

end

local function apply_small_caliber_round(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.SMALL_GUN_SHOT)
	add_wound(bone_idx, WOUND_TYPES.SMALL_GUN_SHOT_EXIT)

end

local function apply_medium_caliber_round(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.MEDIUM_GUN_SHOT)
	add_wound(bone_idx, WOUND_TYPES.MEDIUM_GUN_SHOT_EXIT)

end

local function apply_large_caliber_round(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.LARGE_GUN_SHOT)
	add_wound(bone_idx, WOUND_TYPES.LARGE_GUN_SHOT_EXIT)

end

local function apply_less_lethal(bone_idx, weapon_idx)

end

local function apply_fire(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.SECOND_DEGREE_BURN)

end

local function apply_teeth(bone_idx, weapon_idx)

end

local function apply_hand(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.SMALL_CONTUSION)
	add_wound(bone_idx, WOUND_TYPES.SMALL_LACERATION)

end

local function apply_arrow(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.LARGE_PUNCTURE_WOUND)

end

local function apply_severe_arrow(bone_idx, weapon_idx)

end

local function apply_explosion(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.SECOND_DEGREE_BURN)
	add_wound(bone_idx, WOUND_TYPES.LARGE_LACERATION, 2)

end

local function apply_shotgun_shell(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.MEDIUM_GUN_SHOT)

end

local function apply_severe_shotgun_shell(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.MEDIUM_GUN_SHOT)

end

local function apply_vehicle(bone_idx, weapon_idx)
	
	add_wound(bone_idx, WOUND_TYPES.LACERATION, 3)
	add_wound(bone_idx, WOUND_TYPES.CONTUSION, 2)

end

local function apply_fall(bone_idx, weapon_idx)

	add_wound(bone_idx, WOUND_TYPES.LARGE_CONTUSION)

end

local function apply_drowning(bone_idx, weapon_idx)

end

local function apply_mild_irritant(bone_idx, weapon_idx)

end

local function apply_irritant(bone_idx, weapon_idx)

end

local function apply_severe_irritant(bone_idx, weapon_idx)

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

function apply_weapon_damage(out_bone, weapon_idx)

    local bone_idx = nil
    for i = 1, #CHECKED_BONES do
        
        if CHECKED_BONES[i].hash == out_bone then
            bone_idx = i
            break
        end

    end

	if bone_idx == nil then
		print("Unknown bone " .. out_bone)
        return -1
    end

    for i = 1, #WEAPON_TYPE_FUNCTIONS do

		if WEAPON_TYPE_FUNCTIONS[i].weapon_type == WEAPON_HASHES[weapon_idx][3] then
			apply_adrenaline()
            WEAPON_TYPE_FUNCTIONS[i].func(bone_idx, weapon_idx)
            break
        end

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