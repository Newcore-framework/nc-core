local players = {}

exports('GetPlayerFromId', function(id)
    for _, player in ipairs(players) do
        if tonumber(player.id) == tonumber(id) then
            return player
        end
    end

    return nil
end)

exports('GetPlayer', function(src)
    return players[tostring(src)]
end)

exports('SetChosenCharacter', function(src, chosenCharacter)
    local player = players[tostring(src)]
    player.chosenCharacter = chosenCharacter
    players[tostring(src)] = player
end)

RegisterNetEvent('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, source in ipairs(GetPlayers()) do
            local response = MySQL.query.await('SELECT * FROM `players` WHERE `license` = ?', {
                GetPlayerIdentifierByType(source, 'license')
            })
            local player = response[1]
            player.source = source
            player.chosenCharacter = -1
            players[tostring(source)] = player
        end
    end
end)

RegisterNetEvent('playerConnecting', function(_, _, def)
    local src = source
    def.defer()
    Wait(0)
    def.update('Fetching data')

    local license = GetPlayerIdentifierByType(src, 'license')
    if not license then
        return def.done('License not found')
    end
    local response = MySQL.query.await('SELECT * FROM `players` WHERE `license` = ?', {
        license
    })
    if not player then
        def.update('[NEWCORE] Creating character')
        Wait(2000)
        local id = MySQL.insert.await('INSERT INTO `players` (license, name) VALUES (?, ?)', {
            license, GetPlayerName(src)
        })
        -- print(id)
        local response = MySQL.query.await('SELECT * FROM `players` WHERE `license` = ?', {
            license
        })
        player = response[1]
    end
    local player = response[1]
    if player.ban == 1 then
        def.done('[NEWCORE] Du er bannet for ' .. player.banreason)
    else
        def.update('[NEWCORE] Player not banned')
    end
    if Nccore.whitelist == true then
        if player.whitelisted == 0 then
            def.done('[NEWCORE] Du er ikke whitelisted. Ansøg på vores discord ' .. Nccore.discordlink)
        end
    end

    player.chosenCharacter = -1
    players[tostring(src)] = player
    -- print('!!! ' .. player.name .. ' joinede lige serveren. Som id ' .. player.id .. ' !!!')
    def.done()
end)

RegisterNetEvent('playerJoining', function(oldSrc --[[ string ]])
    local newSrc = tostring(source)
    players[newSrc] = players[oldSrc]
    players[newSrc].source = newSrc
    players[oldSrc] = nil
end)
