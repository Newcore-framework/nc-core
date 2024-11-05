lib.callback.register('nc-core:GetCharacterData', function(src)
    local characterdata = MySQL.single.await('SELECT * FROM `characters` WHERE `id` = ?', {
        exports['nc-core']:GetPlayer(src).id
    })
    return characterdata
end)


lib.callback.register('nc-core:GetPlayerData', function(src)
    local playerdata = MySQL.single.await('SELECT * FROM `players` WHERE `license` = ?', {
        GetPlayerIdentifierByType(src, 'license')
    })

    if not playerdata.name then return print('FEJL NAVN IKKE FUNDET') end

    return playerdata
end)
