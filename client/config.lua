
GENERAL_BODY_PARTS = {
	HEAD     = "Head",
	L_ARM    = "Left Arm",
	R_ARM    = "Right Arm",
	L_LEG    = "Left Leg",
	R_LEG    = "Right Leg",
	PELVIS   = "Pelvis",
	CHEST    = "Chest",
	ABDOMEN  = "Abdomen",
	BACK     = "Back"
}

CHECKED_BONES = {
	SKEL_Pelvis     = {name = "SKEL_Pelvis"    , hash = 0x2E28, general_body_part = GENERAL_BODY_PARTS.PELVIS},
	SKEL_L_Thigh    = {name = "SKEL_L_Thigh"   , hash = 0xE39F, general_body_part = GENERAL_BODY_PARTS.L_LEG},
	SKEL_L_Calf     = {name = "SKEL_L_Calf"    , hash = 0xF9BB, general_body_part = GENERAL_BODY_PARTS.L_LEG},
	SKEL_L_Foot     = {name = "SKEL_L_Foot"    , hash = 0x3779, general_body_part = GENERAL_BODY_PARTS.L_LEG},
    SKEL_L_Toe0     = {name = "SKEL_L_Toe0"    , hash = 0x83C , general_body_part = GENERAL_BODY_PARTS.L_LEG},
    SKEL_R_Thigh    = {name = "SKEL_R_Thigh"   , hash = 0xCA72, general_body_part = GENERAL_BODY_PARTS.R_LEG },
	SKEL_R_Calf     = {name = "SKEL_R_Calf"    , hash = 0x9000, general_body_part = GENERAL_BODY_PARTS.R_LEG },
	SKEL_R_Foot     = {name = "SKEL_R_Foot"    , hash = 0xCC4D, general_body_part = GENERAL_BODY_PARTS.R_LEG },
	SKEL_R_Toe0     = {name = "SKEL_R_Toe0"    , hash = 0x512D, general_body_part = GENERAL_BODY_PARTS.R_LEG },
	SKEL_L_Clavicle = {name = "SKEL_L_Clavicle", hash = 0xFCD9, general_body_part = GENERAL_BODY_PARTS.L_ARM},
	SKEL_L_UpperArm = {name = "SKEL_L_UpperArm", hash = 0xB1C5, general_body_part = GENERAL_BODY_PARTS.L_ARM },
	SKEL_L_Forearm  = {name = "SKEL_L_Forearm" , hash = 0xEEEB, general_body_part = GENERAL_BODY_PARTS.L_ARM },
    SKEL_L_Hand     = {name = "SKEL_L_Hand"    , hash = 0x49D9, general_body_part = GENERAL_BODY_PARTS.L_ARM },
    SKEL_R_Clavicle = {name = "SKEL_R_Clavicle", hash = 0x29D2, general_body_part = GENERAL_BODY_PARTS.R_ARM },
	SKEL_R_UpperArm = {name = "SKEL_R_UpperArm", hash = 0x9D4D, general_body_part = GENERAL_BODY_PARTS.R_ARM },
	SKEL_R_Forearm  = {name = "SKEL_R_Forearm" , hash = 0x6E5C, general_body_part = GENERAL_BODY_PARTS.R_ARM },
    SKEL_R_Hand     = {name = "SKEL_R_Hand"    , hash = 0xDEAD, general_body_part = GENERAL_BODY_PARTS.R_ARM },
    SKEL_Neck_1     = {name = "SKEL_Neck_1"    , hash = 0x9995, general_body_part = GENERAL_BODY_PARTS.HEAD},
    SKEL_Head       = {name = "SKEL_Head"      , hash = 0x796E, general_body_part = GENERAL_BODY_PARTS.HEAD},
    SPR_L_Breast    = {name = "SPR_L_Breast"   , hash = 0xFC8E, general_body_part = GENERAL_BODY_PARTS.CHEST},
	SPR_R_Breast    = {name = "SPR_R_Breast"   , hash = 0x885F, general_body_part = GENERAL_BODY_PARTS.CHEST},
	SKEL_Spine0     = {name = "SKEL_Spine0"    , hash = 0x5C01, general_body_part = GENERAL_BODY_PARTS.BACK},
	SKEL_Spine1     = {name = "SKEL_Spine1"    , hash = 0x60F0, general_body_part = GENERAL_BODY_PARTS.BACK},
	SKEL_Spine2     = {name = "SKEL_Spine2"    , hash = 0x60F1, general_body_part = GENERAL_BODY_PARTS.BACK},
	SKEL_Spine3     = {name = "SKEL_Spine3"    , hash = 0x60F2, general_body_part = GENERAL_BODY_PARTS.BACK},
}

PAIN_THRESHOLD_BEFORE_SHOCK = 30

WOUND_TYPES = {
	SMALL_CONTUSION      = {name = "Small Contusion"         , pain_level = 0, bleeding = 0, heal_time = 1200},
	CONTUSION            = {name = "Contusion"               , pain_level = 1, bleeding = 0, heal_time = 1320},
	LARGE_CONTUSION      = {name = "Large Contusion"         , pain_level = 2, bleeding = 0, heal_time = 1440},
	SMALL_LACERATION     = {name = "Small Laceration"        , pain_level = 1, bleeding = 0, heal_time = 1200},
	LACERATION           = {name = "Laceration"              , pain_level = 1, bleeding = 1},
	LARGE_LACERATION     = {name = "Large Laceration"        , pain_level = 2, bleeding = 2},
	PUNCTURE_WOUND       = {name = "Puncture Wound"          , pain_level = 3, bleeding = 3},
	LARGE_PUNCTURE_WOUND = {name = "Large Puncture Wound"    , pain_level = 5, bleeding = 5},
	FIRST_DEGREE_BURN    = {name = "First Degree Burn"       , pain_level = 2, bleeding = 0, heal_time = 1440},
	SECOND_DEGREE_BURN   = {name = "Second Degree Burn"      , pain_level = 5, bleeding = 0, heal_time = 2400},
	THIRD_DEGREE_BURN    = {name = "Third Degree Burn"       , pain_level = 1, bleeding = 0},
	INFECTION            = {name = "Infection"               , pain_level = 0, bleeding = 0},
	SMALL_GUN_SHOT       = {name = "Small Gun Shot Entrance" , pain_level = 3, bleeding = 1},
	MEDIUM_GUN_SHOT      = {name = "Medium Gun Shot Entrance", pain_level = 5, bleeding = 2},
	LARGE_GUN_SHOT       = {name = "Large Gun Shot Entrance" , pain_level = 6, bleeding = 3},
	SMALL_GUN_SHOT_EXIT  = {name = "Small Gun Shot Exit"     , pain_level = 3, bleeding = 2},
	MEDIUM_GUN_SHOT_EXIT = {name = "Medium Gun Shot Exit"    , pain_level = 5, bleeding = 3},
	LARGE_GUN_SHOT_EXIT  = {name = "Large Gun Shot Exit"     , pain_level = 6, bleeding = 5},
	BROKEN_BONE          = {name = "Broken Bone"             , pain_level = 4, bleeding = 0},
	SMALL_INCISION       = {name = "Small Incision"          , pain_level = 3, bleeding = 2},
	INCISION             = {name = "Incision"                , pain_level = 5, bleeding = 3},
	LARGE_INCISION       = {name = "Large Incision"          , pain_level = 6, bleeding = 5},
	FRACTURE             = {name = "Fracture"                , pain_level = 3, bleeding = 0}
}

ITEMS = {

	BANDAGES = {
		BANDAGE          = {name = "Bandage"},
		DRESSING         = {name = "Dressing"},
		COMPRESSION      = {name = "Compression"},
		GAUZE            = {name = "Gauze"},
		USED_BANDAGE     = {name = "Used Bandage"},
		USED_DRESSING    = {name = "Used Dressing"},
		USED_COMPRESSION = {name = "Used Compression"},
		USED_GAUZE       = {name = "Used Gauze"},
		SPLINT           = {name = "Splint"},
		NECK_BRACE       = {name = "Neck Brace"},
		TOURNIQUET       = {name = "Tourniquet"},
		STITCHING        = {name = "Stitching"},
		OLD_STITCHING    = {name = "Old Stitching"},
		ALCOHOL_PAD      = {name = "Alcohol Pad"}
	},
	INJECTABLES = {
		MORPHINE      = {name = "Morphine"},
		EPINEPHRINE   = {name = "Epinephrine"},
		SALINE_250ML  = {name = "Saline 250ml"},
		SALINE_500ML  = {name = "Saline 500ml"},
		SALINE_750ML  = {name = "Saline 750ml"},
		SALINE_1000ML = {name = "Saline 1000ml"},
		BLOOD_250ML   = {name = "Blood 250ml"},
		BLOOD_500ML   = {name = "Blood 500ml"},
		BLOOD_750ML   = {name = "Blood 750ml"},
		BLOOD_1000ML  = {name = "Blood 1000ml"},
	},
	MEDICATION = {
		ACETAMINOPHEN = {name = "Acetaminophen"},
		ASPIRIN       = {name = "Aspirin"},
		IBUPROFEN     = {name = "Ibuprofen"}
	}

}

DAMAGE_SEVERITY_TYPES = {

	NONE      = 1,
	MINOR     = 2,
	MEDIUM    = 3,
	SEVERE    = 4,
	CRTICICAL = 5

}

EFFECTS = {

	SHOCK           = {name = "Shock"        , effect_time = 60*15},
	ADRENALINE      = {name = "Adrenaline"   , modifiers = {stimulant = 2}, effect_time = 60},
	NO_ADRENALINE   = {name = "No Adrenaline", effect_time = 60*5},
	FATIGUE         = {name = "Fatigue"      , effect_time = 60*5},
	KNOCKED_OUT     = {name = "Knocked Out"  , effect_time = 15},
	UNCONSCIOUS     = {name = "Unconscious"  , effect_time = 60*10}

}

WEAPON_TYPES = {
	MILD_BLUNT           = 1,
	BLUNT                = 2,
	SEVERE_BLUNT         = 3,
	SHARP                = 4,
	SEVERE_SHARP         = 5,
	SMALL_CALIBER_ROUND  = 6,
	MEDIUM_CALIBER_ROUND = 7,
	LARGE_CALIBER_ROUND  = 8,
	LESS_LETHAL          = 9,
	FIRE                 = 10,
	TEETH                = 11,
	HAND                 = 12,
	ARROW                = 13,
	SEVERE_ARROW         = 14,
	EXPLOSION            = 15,
	SHOTGUN_SHELL        = 16,
	SEVERE_SHOTGUN_SHELL = 17,
	VEHICLE              = 18,
	FALL                 = 19,
	DROWNING             = 20,
	MILD_IRRITANT        = 21,
	IRRITANT             = 22,
	SEVERE_IRRITANT      = 23
}

WEAPON_HASHES = {
    {name = "WEAPON_UNARMED", hash = 0xA2719263, weapon_type = WEAPON_TYPES.HAND},
    {name = "WEAPON_ANIMAL", hash = 0xF9FBAEBE, weapon_type = WEAPON_TYPES.TEETH},
    {name = "WEAPON_COUGAR", hash = 0x08D4BE52, weapon_type = WEAPON_TYPES.TEETH},
    {name = "WEAPON_KNIFE", hash = 0x99B507EA, weapon_type = WEAPON_TYPES.SHARP},
    {name = "WEAPON_NIGHTSTICK", hash = 0x678B81B1, weapon_type = WEAPON_TYPES.BLUNT},
    {name = "WEAPON_HAMMER", hash = 0x4E875F73, weapon_type = WEAPON_TYPES.SEVERE_BLUNT},
    {name = "WEAPON_BAT", hash = 0x958A4A8F, weapon_type = WEAPON_TYPES.BLUNT},
    {name = "WEAPON_GOLFCLUB", hash = 0x440E4788, weapon_type = WEAPON_TYPES.BLUNT},
    {name = "WEAPON_CROWBAR", hash = 0x84BD7BFD, weapon_type = WEAPON_TYPES.SEVERE_ARROW},
    {name = "WEAPON_PISTOL", hash = 0x1B06D571, weapon_type = WEAPON_TYPES.SMALL_CALIBER_ROUND},
    {name = "WEAPON_COMBATPISTOL", hash = 0x5EF9FEC4, weapon_type = WEAPON_TYPES.SMALL_CALIBER_ROUND},
    {name = "WEAPON_APPISTOL", hash = 0x22D8FE39, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_PISTOL50", hash = 0x99AEEB3B, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_MICROSMG", hash = 0x13532244, weapon_type = WEAPON_TYPES.SMALL_CALIBER_ROUND},
    {name = "WEAPON_SMG", hash = 0x2BE6766B, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_ASSAULTSMG", hash = 0xEFE7E2DF, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_ASSAULTRIFLE", hash = 0xBFEFFF6D, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_CARBINERIFLE", hash = 0x83BF0278, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_ADVANCEDRIFLE", hash = 0xAF113F99, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_MG", hash = 0x9D07F764, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_COMBATMG", hash = 0x7FD62962, weapon_type = WEAPON_TYPES.LARGE_CALIBER_ROUND},
    {name = "WEAPON_PUMPSHOTGUN", hash = 0x1D073A89, weapon_type = WEAPON_TYPES.SHOTGUN_SHELL},
    {name = "WEAPON_SAWNOFFSHOTGUN", hash = 0x7846A318, weapon_type = WEAPON_TYPES.SHOTGUN_SHELL},
    {name = "WEAPON_ASSAULTSHOTGUN", hash = 0xE284C527, weapon_type = WEAPON_TYPES.SHOTGUN_SHELL},
    {name = "WEAPON_BULLPUPSHOTGUN", hash = 0x9D61E50F, weapon_type = WEAPON_TYPES.SHOTGUN_SHELL},
    {name = "WEAPON_STUNGUN", hash = 0x3656C8C1, weapon_type = WEAPON_TYPES.LESS_LETHAL},
    {name = "WEAPON_SNIPERRIFLE", hash = 0x05FC3C11, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_HEAVYSNIPER", hash = 0x0C472FE2, weapon_type = WEAPON_TYPES.LARGE_CALIBER_ROUND},
    {name = "WEAPON_REMOTESNIPER", hash = 0x33058E22, weapon_type = WEAPON_TYPES.MEDIUM_CALIBER_ROUND},
    {name = "WEAPON_GRENADELAUNCHER", hash = 0xA284510B, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_GRENADELAUNCHER_SMOKE", hash = 0x4DD2DC56, weapon_type = WEAPON_TYPES.MILD_IRRITANT},
    {name = "WEAPON_RPG", hash = 0xB1CA77B1, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_PASSENGER_ROCKET", hash = 0x166218FF, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_AIRSTRIKE_ROCKET", hash = 0x13579279, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_STINGER", hash = 0x687652CE, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_MINIGUN", hash = 0x42BF8A85, weapon_type = WEAPON_TYPES.LARGE_CALIBER_ROUND},
    {name = "WEAPON_GRENADE", hash = 0x93E220BD, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_STICKYBOMB", hash = 0x2C3731D9, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_SMOKEGRENADE", hash = 0xFDBC8A50, weapon_type = WEAPON_TYPES.MILD_IRRITANT},
    {name = "WEAPON_BZGAS", hash = 0xA0973D5E, weapon_type = WEAPON_TYPES.SEVERE_IRRITANT},
    {name = "WEAPON_MOLOTOV", hash = 0x24B17070, weapon_type = WEAPON_TYPES.FIRE},
    {name = "WEAPON_FIREEXTINGUISHER",  hash = 0x060EC506},
    {name = "WEAPON_PETROLCAN", hash = 0x34A67B97},
    {name = "WEAPON_DIGISCANNER", hash = 0xFDBADCED},
    {name = "WEAPON_BRIEFCASE", hash = 0x88C78EB7},
    {name = "WEAPON_BRIEFCASE_02", hash = 0x01B79F17},
    {name = "WEAPON_BALL", hash = 0x23C9F95C, weapon_type = WEAPON_TYPES.MILD_BLUNT},
    {name = "WEAPON_FLARE",  hash = 0x497FACC3, weapon_type = WEAPON_TYPES.FIRE},
    {name = "WEAPON_VEHICLE_ROCKET", hash = 0xBEFDC581, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_BARBED_WIRE", hash = 0x48E7B178, weapon_type = WEAPON_TYPES.SHARP},
    {name = "WEAPON_DROWNING", hash = 0xFF58C4FB, weapon_type = WEAPON_TYPES.DROWNING},
    {name = "WEAPON_DROWNING_IN_VEHICLE", hash = 0x736F5990, weapon_type = WEAPON_TYPES.DROWNING},
    {name = "WEAPON_BLEEDING", hash = 0x8B7333FB},
    {name = "WEAPON_ELECTRIC_FENCE", hash = 0x92BD4EBB},
    {name = "WEAPON_EXPLOSION", hash = 0x2024F4E8, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_FALL", hash = 0xCDC174B0, weapon_type = WEAPON_TYPES.FALL},
    {name = "WEAPON_EXHAUSTION", hash = 0x364A29EC},
    {name = "WEAPON_HIT_BY_WATER_CANNON", hash = 0xCC34325E, weapon_type = WEAPON_TYPES.BLUNT},
    {name = "WEAPON_RAMMED_BY_CAR", hash = 0x07FC7D7A, weapon_type = WEAPON_TYPES.VEHICLE},
    {name = "WEAPON_RUN_OVER_BY_CAR", hash = 0xA36D413E, weapon_type = WEAPON_TYPES.VEHICLE},
    {name = "WEAPON_HELI_CRASH", hash = 0x145F1012, weapon_type = WEAPON_TYPES.EXPLOSION},
    {name = "WEAPON_FIRE", hash = 0xDF8E89EB, weapon_type = WEAPON_TYPES.FIRE}
}