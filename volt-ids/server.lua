local playersWithID = {}

RegisterNetEvent("qb-id:syncID")
AddEventHandler("qb-id:syncID", function(playerID, state)
    local src = source
    if state then
        playersWithID[playerID] = true
    else
        playersWithID[playerID] = nil
    end
    TriggerClientEvent("qb-id:updateID", -1, playersWithID)
end)
