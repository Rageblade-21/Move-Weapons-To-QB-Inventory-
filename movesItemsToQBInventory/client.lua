-- Import QBCore
QBCore = exports['qb-core']:GetCoreObject()

-- Function to check if player has a weapon in hand and add to inventory
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Check every 1 seconds

        local playerPed = PlayerPedId()
        local weaponHash = GetSelectedPedWeapon(playerPed)

        if weaponHash ~= GetHashKey('WEAPON_UNARMED') then
            local weaponLabel = QBCore.Shared.Weapons[weaponHash] and QBCore.Shared.Weapons[weaponHash]["label"] or "Unknown Weapon"
            local weaponName = QBCore.Shared.Weapons[weaponHash] and QBCore.Shared.Weapons[weaponHash]["name"] or "unknown"

            -- Check if player already has the weapon in inventory
            QBCore.Functions.TriggerCallback('qb-weapons:server:HasWeapon', function(hasWeapon)
                if not hasWeapon then
                    -- Add weapon to player inventory
                    TriggerServerEvent('qb-weapons:server:AddWeapon', weaponHash, weaponLabel)
                    RemoveWeaponFromPed(playerPed, weaponHash)
                    QBCore.Functions.Notify("Weapon added to inventory: " .. weaponLabel, "success", 5000)
                end
            end, weaponName)
        end
    end
end)
