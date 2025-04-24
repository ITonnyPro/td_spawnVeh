# td_spawnVeh

# Exemple d'utilisation 

    RegisterNetEvent('td_garage:SpawnVeh')
    AddEventHandler('td_garage:SpawnVeh', function(plate, parking)
        local _src = source
        local xPlayer = ESX.GetPlayerFromId(_src)
    
        local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE `plate` = @plate', {
            ['@plate'] = plate
        })
    
        if type(result) == 'table' and result[1] ~= nil then
            local model = result[1].model
            local type = result[1].type
            local coords = Config.Garages[parking]["car"]["spawncar"]
            local Heading = Config.Garages[parking]["car"]["spawncar"].w
            local Properties = json.decode(result[1].vehicle)
    
            TriggerEvent('td_spawnVeh:spawnVeh', model, type, coords, Heading, Properties)
    
            MySQL.update("UPDATE `owned_vehicles` SET stored = 0 WHERE `plate` ='".. plate .."'")
    
            exports.wasabi_carlock:GiveKey(_src, plate)
        end
    end)
