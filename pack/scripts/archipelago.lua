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
    for _, value in pairs(LocationMap) do
        local area = value[1]
        local section = value[2]
        local address = "@" .. area .. "/" .. section
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
        if slotData["coinbundlerange"] then
            setting.AcquiredCount = tonumber(slotData["coinbundlerange"])
        else
            setting.AcquiredCount = 0
        end
    end
    if slotData["item_shuffle"] then
        local setting = Tracker:FindObjectForCode("ItemsShuffled")
        setting.Active = slotData["item_shuffle"] ~= 0
    end
    if slotData["death_link"] then
        local setting = Tracker:FindObjectForCode("DeathLink")
        setting.Active = slotData["death_link"] ~= 0
    end
end

Archipelago:AddClearHandler("Reset", Reset)