
local function register_bone_hit_function(bone, func)

	bone.func = func

end

local function register_weapon_use_function(weapon, func)

	weapon.func = func

end

local function add_wound(bone, wound_type, amount)

	local amount_to_add = amount or 1
	local bone_part     = bone.general_body_part
	local wound_type    = wound_type

	if PLAYER.WOUNDS[bone_part] == nil then
		PLAYER.WOUNDS[bone_part] = {}
	end

	for i = 1, amount_to_add do

		if #PLAYER.WOUNDS[bone_part] >= 10 then
			break
		end

		table.insert(PLAYER.WOUNDS[bone_part], {wound_name = wound_type.name, bandages = {}})
		if wound_type.heal_time ~= nil then
			PLAYER.WOUNDS[bone_part][#PLAYER.WOUNDS[bone_part]].heal_time = wound_type.heal_time * 1000
			PLAYER.WOUNDS[bone_part][#PLAYER.WOUNDS[bone_part]].last_update_time = GetGameTimer()
		end

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

local function chest_shot_and_has_body_armour(bone)

	return bone.general_body_part == GENERAL_BODY_PARTS.CHEST and PLAYER_STATS.LAST_ARMOUR > 0

end

local function apply_small_caliber_round(bone, weapon)

	if chest_shot_and_has_body_armour(bone) then

		add_wound(bone, WOUND_TYPES.CONTUSION)
		return

	end

	add_wound(bone, WOUND_TYPES.SMALL_GUN_SHOT)

	if math.random() <= 0.2 then
		add_wound(bone, WOUND_TYPES.BULLET_FRAGMENTS)
	else
		add_wound(bone, WOUND_TYPES.SMALL_GUN_SHOT_EXIT)
	end

end

local function apply_medium_caliber_round(bone, weapon)

	if chest_shot_and_has_body_armour(bone) then

		add_wound(bone, WOUND_TYPES.LARGE_CONTUSION)
		return
		
	end

	add_wound(bone, WOUND_TYPES.MEDIUM_GUN_SHOT)

	if math.random() <= 0.15 then
		add_wound(bone, WOUND_TYPES.BULLET_FRAGMENTS)
	else
		add_wound(bone, WOUND_TYPES.MEDIUM_GUN_SHOT_EXIT)
	end

end

local function apply_large_caliber_round(bone, weapon)

	if chest_shot_and_has_body_armour(bone) then

		add_wound(bone, WOUND_TYPES.LARGE_CONTUSION)
		return
		
	end

	add_wound(bone, WOUND_TYPES.LARGE_GUN_SHOT)

	if math.random() <= 0.1 then
		add_wound(bone, WOUND_TYPES.BULLET_FRAGMENTS)
	else
		add_wound(bone, WOUND_TYPES.LARGE_GUN_SHOT_EXIT)
	end

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

	if chest_shot_and_has_body_armour(bone) then

		add_wound(bone, WOUND_TYPES.LARGE_CONTUSION)
		return
		
	end

	add_wound(bone, WOUND_TYPES.MEDIUM_GUN_SHOT)
	add_wound(bone, WOUND_TYPES.BULLET_FRAGMENTS)

end

local function apply_severe_shotgun_shell(bone, weapon)

	if chest_shot_and_has_body_armour(bone) then

		add_wound(bone, WOUND_TYPES.LARGE_CONTUSION)
		return
		
	end

	add_wound(bone, WOUND_TYPES.MEDIUM_GUN_SHOT)
	add_wound(bone, WOUND_TYPES.BULLET_FRAGMENTS)

end

local function apply_vehicle(bone, weapon)
	
	add_wound(bone, WOUND_TYPES.LACERATION, 3)
	add_wound(bone, WOUND_TYPES.CONTUSION, 2)

end

local function apply_fall(bone, weapon)

	local hit_severity = get_hit_severity()

    if hit_severity == DAMAGE_SEVERITY_TYPES.NONE then
        return 0
    end

    add_wound(bone, WOUND_TYPES.CONTUSION)

    if hit_severity == DAMAGE_SEVERITY_TYPES.MEDIUM then

    	add_wound(bone, WOUND_TYPES.CONTUSION)
        add_wound(bone, WOUND_TYPES.LACERATION)

    elseif hit_severity == DAMAGE_SEVERITY_TYPES.SEVERE then
        
        add_wound(bone, WOUND_TYPES.LARGE_CONTUSION)
        add_wound(bone, WOUND_TYPES.LARGE_LACERATION, 1)
        add_wound(bone, WOUND_TYPES.BROKEN_BONE)

    elseif hit_severity == DAMAGE_SEVERITY_TYPES.CRTICICAL then
        
        add_wound(bone, WOUND_TYPES.LARGE_CONTUSION, 2)
        add_wound(bone, WOUND_TYPES.LARGE_LACERATION, 2)
        add_wound(bone, WOUND_TYPES.BROKEN_BONE)

    end

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
		apply_vehicle(CHECKED_BONES.SPR_L_Breast, nil)
		apply_vehicle(CHECKED_BONES.SPR_R_Breast, nil)

		apply_vehicle(CHECKED_BONES.SKEL_L_UpperArm, nil)
		apply_vehicle(CHECKED_BONES.SKEL_R_UpperArm, nil)

	elseif weapon.name == "WEAPON_RAMMED_BY_CAR" then

		print("Applying WEAPON_RAMMED_BY_CAR")
		apply_hand(CHECKED_BONES.SKEL_Head, nil)
		apply_hand(CHECKED_BONES.SPR_L_Breast, nil)
		apply_hand(CHECKED_BONES.SPR_R_Breast, nil)

	elseif weapon.name == "WEAPON_UNARMED" then

		apply_hand(CHECKED_BONES.SKEL_Head, nil)
		apply_hand(CHECKED_BONES.SKEL_R_Clavicle, nil)
		apply_hand(CHECKED_BONES.SKEL_L_Clavicle, nil)

	end

end

local function wound_heal_time(body_part, wound)

	if wound.heal_time == nil then
		return 0 
	end

	local current_time = GetGameTimer()
	local dt = current_time - wound.last_update_time

	wound.heal_time        = wound.heal_time - dt
	wound.last_update_time = current_time

end

function check_wound_heal_time()

	for body_part, wounds in pairs(PLAYER.WOUNDS) do
		
		for i = 1, #wounds do

			wound_heal_time(body_part, wounds[i])

		end

		for i = #wounds, 1, -1 do

			if wounds[i].heal_time ~= nil and wounds[i].heal_time <= 0 then
				table.remove(wounds, i)
			end

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