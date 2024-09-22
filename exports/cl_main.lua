---@diagnostic disable: missing-parameter
exports("getAllJobs", function()
    return Newcore.jobs
end)

exports("Getjob", function(job)
    if not Newcore.jobs[job] then
        print('Job not found')
    else
        print(Newcore.Jobs[job] .. ' was found in database')
        return Newcore.jobs[job]
    end
end)

exports("GetPlayerJobById", function(job)
    return Newcore.jobs[job]
end)

exports('GetPlayerData', function()
    local playerdata = lib.callback.await('nc-core:GetPlayerData', false)
    return playerdata
end)

exports('GetCharacterData', function()
    local characterdata = lib.callback.await('nc-core:GetCharacterData', false)
    return characterdata
end)
