RegisterServerEvent('td_spawnVeh:spawnVeh')
AddEventHandler('td_spawnVeh:spawnVeh', function(modelName, modelType, coordinates, heading, vehprops)
    local vehicle = TD_SpawnVehicle(modelName, modelType, coordinates, heading, vehprops)
end)

---@param modelName string
---@param modelType string
---@param coordinates vector3
---@param heading number
function TD_SpawnVehicle(modelName, modelType, coordinates, heading, vehprops)
    if modelType == "bicycle" or modelType == "quadbike" or modelType == "amphibious_quadbike" then
        modelType = "bike"
    elseif modelType == "amphibious_automobile" or modelType == "submarinecar" or modelType == "car" then
        modelType = "automobile"
    elseif modelType == "blimp" then
        modelType = "heli"
    end

    local entity = CreateVehicleServerSetter(joaat(modelName), modelType, coordinates.x, coordinates.y, coordinates.z, heading)

    while true do
        Citizen.Wait(0)
        if DoesEntityExist(entity) then
            Wait(1)
            TriggerClientEvent('td_spawnVeh:SetVehicleProperties', -1, NetworkGetNetworkIdFromEntity(entity), vehprops)
            TriggerClientEvent('td_spawnVeh:spawn', -1, NetworkGetNetworkIdFromEntity(entity), vehprops)
            break
        end
    end

    return entity
end