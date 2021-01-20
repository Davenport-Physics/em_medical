fx_version 'bodacious'

game 'gta5'

server_scripts {
    '@mysql-async/lib/MySQL.lua'
}

client_scripts {
    'client/prototype.lua',
    'client/config.lua',
    'client/wounds.lua',
    'client/effects/effects_core.lua',
    'client/effects/effects.lua',
    'client/player/player.lua',
    'client/misc/unconscious_manager.lua',
    'client/libs.lua',
    'client/blood.lua'
}