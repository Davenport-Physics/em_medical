fx_version 'bodacious'

game 'gta5'

server_scripts {
    '@mysql-async/lib/MySQL.lua'
}

client_scripts {
    'client/prototype.lua',
    'client/config.lua',
    'client/wounds/wounds_core.lua',
    'client/wounds/wounds.lua',
    'client/effects/effects_core.lua',
    'client/effects/effects.lua',
    'client/player/player.lua',
    'client/player/player_misc.lua',
    'client/player/player_misc_events.lua',
    'client/misc/unconscious_manager.lua',
    'client/libs.lua',
    'client/blood.lua',
    'client/reactions/reactions_core.lua',
    'client/reactions/bone_reactions.lua',
    'client/reactions/weapon_reactions.lua'
}

exports {
    'GetStat',
    "ModStat",
    "GetStatMax",
    "SetStatMax",
    "ResetStatMaxes",
    "ResetStats"
}