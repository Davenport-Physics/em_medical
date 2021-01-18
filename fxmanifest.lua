fx_version 'bodacious'

game 'gta5'

server_scripts {
    '@mysql-async/lib/MySQL.lua'
}

client_scripts {
    'client/prototype.lua',
    'client/config.lua',
    'client/wounds.lua',
    'client/effects.lua',
    'client/player.lua',
    'client/libs.lua',
    'client/blood.lua'
}