fx_version 'cerulean'
game 'gta5'

author 'EnderDevelopment'
description 'Radio System for FiveM'
version '1.0.0'

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

shared_scripts {
    'config.lua'
}

dependencies {
    'es_extended'
}