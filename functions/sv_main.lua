AddEventHandler('playerDropped', function()
    local src = source
    local player = exports['nc-core']:GetPlayer(src)

    if not player or player.chosenCharacter == -1 then return end

    MySQL.update.await('UPDATE characters SET coords = ? WHERE character_id = ?', {
        json.encode(GetEntityCoords(GetPlayerPed(src))), exports['nc-core']:GetPlayer(src).chosenCharacter
    })
end)
