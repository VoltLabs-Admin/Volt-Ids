local showID = false
local playerID = GetPlayerServerId(PlayerId())

RegisterCommand("toggleID", function()
    showID = not showID
    if showID then
        TriggerServerEvent("qb-id:syncID", playerID, true)
    else
        TriggerServerEvent("qb-id:syncID", playerID, false)
    end
end)

RegisterKeyMapping("toggleID", "Toggle ID above head", "keyboard", "K")

RegisterNetEvent("qb-id:updateID")
AddEventHandler("qb-id:updateID", function(playersWithID)
    Citizen.CreateThread(function()
        while showID do
            for _, player in ipairs(GetActivePlayers()) do
                local serverID = GetPlayerServerId(player)
                if playersWithID[serverID] then
                    local ped = GetPlayerPed(player)
                    local x, y, z = table.unpack(GetEntityCoords(ped))
                    DrawText3D(x, y, z + 1.0, serverID)
                end
            end
            Wait(0) -- Prevent freezing
        end
    end)
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
