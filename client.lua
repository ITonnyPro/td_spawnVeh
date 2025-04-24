RegisterNetEvent('td_spawnVeh:SetVehicleProperties')
AddEventHandler('td_spawnVeh:SetVehicleProperties', function(vehicle, vehprops)
    TD_SetVehicleProperties(NetworkGetEntityFromNetworkId(vehicle), vehprops)
end)

RegisterNetEvent('td_spawnVeh:spawn')
AddEventHandler('td_spawnVeh:spawn', function(vehicle, props)
    local model        = props['model']
    local enginehealth = props['engineHealth']
    local bodyhealth = props['bodyHealth']
    local currentfuel  = props['fuelLevel'] + 1.0
    local playerPed    = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local entity = NetworkGetEntityFromNetworkId(vehicle)
    
    if GetVehicleNumberPlateText(entity) == props['plate'] then
        SetVehicleEngineHealth(entity, enginehealth)
        SetVehicleBodyHealth(entity, bodyhealth)
        SetVehicleEngineOn(entity, false, true, true)
        SetVehRadioStation(entity, "OFF")
        
        -- Fuel system --
        exports["lc_fuel"]:SetFuel(entity, currentfuel)
        -----------------
    end
end)