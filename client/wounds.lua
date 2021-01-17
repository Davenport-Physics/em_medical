
local function apply_hand_damage()

end

local function apply_mild_blunt()

end

local function apply_severe_blunt()

end

local function apply_sharp()

end

local function apply_severe_sharp()

end

local function apply_small_caliber_round()

end

local function apply_medium_caliber_round()

end

local function apply_large_caliber_round()

end

local function apply_less_lethal()

end

local function apply_fire()

end

local function apply_teeth()

end

local function apply_hand()

end

local function apply_arrow()

end

local function apply_severe_arrow()

end

local function apply_explosion()

end

local function apply_shotgun_shell()

end

local function apply_severe_shotgun_shell()

end

local function apply_vehicle()

end

local function apply_fall()

end

local function apply_drowning()

end

local function apply_mild_irritant()

end

local function apply_irritant()

end

local function apply_severe_irritant()

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
        return -1
    end

    for i = 1, #WEAPON_TYPE_FUNCTIONS do

		if WEAPON_TYPE_FUNCTIONS[i].weapon_type == WEAPON_HASHES[weapon_idx][3] then
			apply_adrenaline()
            WEAPON_TYPE_FUNCTIONS[i].func()
            break
        end

    end

end