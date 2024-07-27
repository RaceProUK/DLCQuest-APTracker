ScriptHost:LoadScript("scripts/archipelago/itemMap.lua")
ScriptHost:LoadScript("scripts/archipelago/locationMap.lua")

CurrentIndex = -1
DLCQHasProgSword = false
LFODHasProgSword = false

function Reset(slotData)
    CurrentIndex = -1
    DLCQHasProgSword = false
    LFODHasProgSword = false

    --Auto-tracked Items
    for _, value in pairs(ItemMap) do
        local itemCode = value[1]
        if itemCode then
            local item = Tracker:FindObjectForCode(itemCode)
            if item then
                if itemType == "toggle" then
                    item.Active = false
                elseif itemType == "consumable" then
                    item.AcquiredCount = 0
                    item.MaxCount = 0
                end
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
        local dlcqReceived = Tracker:FindObjectForCode("DLCQCoinBundlesReceived")
        local lfodReceived = Tracker:FindObjectForCode("LFODCoinBundlesReceived")
        if slotData["coinsanity"] ~= 0 and slotData["coinbundlerange"] then
            local size = tonumber(slotData["coinbundlerange"]);
            setting.AcquiredCount = size
            dlcqReceived.MaxCount = math.ceil(825 / size)
            lfodReceived.MaxCount = math.ceil(889 / size)
        else
            setting.AcquiredCount = 0
            dlcqReceived.MaxCount = 0
            lfodReceived.MaxCount = 0
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

function ItemReceived(index, id, name, player)
    if index <= CurrentIndex then
        return
    else
        CurrentIndex = index
    end

    local itemCode = ItemMap[id]
    if itemCode == "LoadingScreen" or itemCode == "TemporarySpike" or itemCode == "ZombieSheep" then
        --Traps are always ignored
        return
    elseif itemCode == "DLCQCoinPiece" or itemCode == "LFODCoinPiece" then
        --Coin pieces can be ignored for now
        return
    elseif itemCode == "DLCQCoinBundle" then
        local received = Tracker:FindObjectForCode("DLCQCoinBundlesReceived")
        received.AcquiredCount = received.AcquiredCount + received.Increment
    elseif itemCode == "LFODCoinBundle" then
        local received = Tracker:FindObjectForCode("LFODCoinBundlesReceived")
        received.AcquiredCount = received.AcquiredCount + received.Increment
    elseif itemCode == "DLCQProgWeapon" then
        local sword = Tracker:FindObjectForCode("Sword")
        local gun = Tracker:FindObjectForCode("Gun")
        gun.Active = sword.Active and DLCQHasProgSword
        sword.Active = true
        DLCQHasProgSword = true
    elseif itemCode == "LFODProgWeapon" then
        local sword = Tracker:FindObjectForCode("NormalSword")
        local pickaxe = Tracker:FindObjectForCode("Pickaxe")
        pickaxe.Active = sword.Active and LFODHasProgSword
        sword.Active = true
        LFODHasProgSword = true
    else
        local item = Tracker:FindObjectForCode(itemCode)
        if item then
            item.Active = true
        end
    end
end

function LocationChecked(id, name)
    local mapping = LocationMap[id]
    if not mapping then
        return
    end

    local area = mapping[1]
    local section = mapping[2]
    local address = "@" .. area .. "/" .. section
    local location = Tracker:FindObjectForCode(address)
    if location then
        location.AvailableChestCount = location.AvailableChestCount - 1
    end
end

Archipelago:AddClearHandler("Reset", Reset)
Archipelago:AddItemHandler("Item Received", ItemReceived)
Archipelago:AddLocationHandler("Location Checked", LocationChecked)