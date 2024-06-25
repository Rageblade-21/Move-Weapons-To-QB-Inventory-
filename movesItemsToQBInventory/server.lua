-- Import QBCore
QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-weapons:server:AddWeapon', function(weaponHash, weaponLabel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        local weaponName = QBCore.Shared.Weapons[weaponHash] and QBCore.Shared.Weapons[weaponHash]["name"] or "unknown"
        Player.Functions.AddItem(weaponName, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[weaponName], "add")
    end
end)

QBCore.Functions.CreateCallback('qb-weapons:server:HasWeapon', function(source, cb, weaponName)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player then
        local hasWeapon = Player.Functions.GetItemByName(weaponName) ~= nil
        cb(hasWeapon)
    else
        cb(false)
    end
end)
