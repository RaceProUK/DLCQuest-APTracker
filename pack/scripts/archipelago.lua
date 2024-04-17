ScriptHost:LoadScript("scripts/archipelago/itemMap.lua")
ScriptHost:LoadScript("scripts/archipelago/locationMap.lua")

CurrentIndex = -1

function Reset(slotData)
    CurrentIndex = -1

    --Auto-tracked Items
    for _, value in pairs(ItemMap) do
        local itemCode = value[1]
        if itemCode then
            local item = Tracker:FindObjectForCode(itemCode)
            if item then
                item.Active = false
            end
        end
    end

    --Locations
    for _, name in pairs(LocationMap) do
        local address = "@" .. name .. "/" .. name
        local location = Tracker:FindObjectForCode(address)
        if location then
            location.AvailableChestCount = location.ChestCount
        end
    end

    --Settings
    if slotData == nil then
        return
    end
    if slotData["campaign"] then
        local setting = Tracker:FindObjectForCode("Campaign")
        setting.CurrentStage = tonumber(slotData["campaign"])
    end
    if slotData["ending_choice"] then
        local setting = Tracker:FindObjectForCode("Ending")
        setting.Active = slotData["ending_choice"] ~= 0
    end
    if slotData["coinsanity"] then
        local setting = Tracker:FindObjectForCode("CoinBundleSize")
        if slotData["coinsanity"] ~= 0 and slotData["coinbundlerange"] then
            setting.AcquiredCount = tonumber(slotData["coinbundlerange"])
        else
            setting.AcquiredCount = 0
        end
    end
    if slotData["death_link"] then
        local setting = Tracker:FindObjectForCode("DeathLink")
        setting.Active = slotData["death_link"] ~= 0
    end
end

function ItemReceived(index, id, name, player)
    if index <= CurrentIndex then
        return
    else
        CurrentIndex = index
    end

    local itemCode = ItemMap[id]
    if itemCode == "DLCQProgWeapon" then
        local sword = Tracker:FindObjectForCode("Sword")
        local gun = Tracker:FindObjectForCode("Gun")
        gun.Active = sword.Active
        sword.Active = true
    elseif itemCode == "LFODProgWeapon" then
        local sword = Tracker:FindObjectForCode("NormalSword")
        local pickaxe = Tracker:FindObjectForCode("Pickaxe")
        pickaxe.Active = sword.Active
        sword.Active = true
    else
        local item = Tracker:FindObjectForCode(itemCode)
        if item then
            item.Active = true
        end
    end
end

function LocationChecked(id, name)
    local name = LocationMap[id]
    if not name then
        return
    end

    local address = "@" .. name .. "/" .. name
    local location = Tracker:FindObjectForCode(address)
    if location then
        location.AvailableChestCount = location.AvailableChestCount - 1
    end
end

Archipelago:AddClearHandler("Reset", Reset)
Archipelago:AddItemHandler("Item Received", ItemReceived)
Archipelago:AddLocationHandler("Location Checked", LocationChecked)