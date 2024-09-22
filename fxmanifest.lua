fx_version('cerulean')
games({ 'gta5' })
lua54 'yes'

author 'K1an'
description 'A must have to use all the scripts from the framework'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/**.lua',
    'jobs/**'
}

client_scripts {
    'exports/cl_main.lua',
    'functions/cl_main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/**',
    'exports/sv_main.lua',
    'functions/sv_main.lua',
}
