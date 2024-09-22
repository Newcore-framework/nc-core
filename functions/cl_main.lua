local dead = false
local ped = PlayerPedId()
local isPedDead = IsPedDeadOrDying(ped)

local character = exports['nc-core']:GetCharacterData()

local deadanim = 'hej'
local deaddict = 'hej'

local freemode_model = GetHashKey("mp_m_freemode_01")
local freemode_model2 = 'mp_m_freemode_01'

CreateThread(function()
    while true do
        Wait(100)
        if dead then
            if IsPedMale(ped) then
                SetEntityHealth(ped, 110)
            else
                SetEntityHealth(ped, 10)
            end
        end
    end
end)

RegisterNetEvent('playerSpawned', function()
    if not character then
        -- CreateChar()
        print('hej')
    elseif character then
        exports['nc-multichar']:OpenMulticharacter(true)
    else
        print('player not defined')
    end
    -- SetPedAsMpFreemode()
    -- lib.notify({ title = 'Player spawned', description = 'You spawned in as ' .. freemode_model2 })
end)

function SetPedAsMpFreemode()
    if IsModelInCdimage(freemode_model) and IsModelValid(freemode_model) then
        RequestModel(freemode_model)
        while not HasModelLoaded(freemode_model) do
            Wait(50)
        end

        SetPlayerModel(PlayerId(), freemode_model)
        local player_ped = PlayerPedId()
        SetPedComponentVariation(player_ped, 0, 0, 0, 2)
        SetPedComponentVariation(player_ped, 2, 11, 4, 2)
        SetPedComponentVariation(player_ped, 4, 1, 5, 2)
        SetPedComponentVariation(player_ped, 6, 1, 0, 2)
        SetPedComponentVariation(player_ped, 11, 7, 2, 2)
    end
end

-- RegisterCommand('input', function()
--     local input = exports['nc-input']:showInput()
-- end)
