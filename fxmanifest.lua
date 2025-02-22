fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "sc_lawn"
author "ScubeScripts"
description "A simple gardener job"
version "1.0.0"

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}
  
client_scripts {
    'client/*.lua'
}
  
shared_script {
    'config.lua'
}
  
dependencies {
    'es_extended',
}
