ScriptHost:LoadScript("scripts/archipelago/itemMap.lua")
ScriptHost:LoadScript("scripts/archipelago/locationMap.lua")

CurrentIndex = -1
DLCQHasProgSword = false
LFODHasProgSword = false

function Reset(slotData)
    Tracker.BulkUpdate = true

    CurrentIndex = -1
    DLCQHasProgSword = false
    LFODHasProgSword = false

    --Wallet
    Wallet:Reset()

    --Coins
    local dlcqCoins = Tracker:FindObjectForCode("DLCQCoinsReceived")
    local lfodCoins = Tracker:FindObjectForCode("LFODCoinsReceived")
    dlcqCoins.AcquiredCount = 0
    lfodCoins.AcquiredCount = 0

    --Auto-tracked Items
    for _, value in pairs(ItemMap) do
        local itemCode = tostring(value)
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
        setting.CurrentStage = math.tointeger(slotData["campaign"]) or 0
    end
    if slotData["ending_choice"] then
        local setting = Tracker:FindObjectForCode("Ending")
        setting.Active = slotData["ending_choice"] ~= 0
    end
    if slotData["coinsanity"] then
        local bundleSetting = Tracker:FindObjectForCode("CoinBundleSize")
        local piecesSetting = Tracker:FindObjectForCode("CoinPieces")
        local dlcqBundlesAvailable = Tracker:FindObjectForCode("@DLCQ Coinsanity/Coin Bundle")
        local lfodBundlesAvailable = Tracker:FindObjectForCode("@LFOD Coinsanity/Coin Bundle")

        if slotData["coinsanity"] ~= 0 and slotData["coinbundlerange"] then
            local size = math.tointeger(slotData["coinbundlerange"])
            if size > 0 then
                bundleSetting.AcquiredCount = size or 0
                piecesSetting.Active = false
                dlcqBundlesAvailable.AvailableChestCount = math.ceil(825 / size)
                lfodBundlesAvailable.AvailableChestCount = math.ceil(889 / size)
            else
                bundleSetting.AcquiredCount = 0
                piecesSetting.Active = true
                dlcqBundlesAvailable.AvailableChestCount = 0
                lfodBundlesAvailable.AvailableChestCount = 0
            end
        else
            bundleSetting.AcquiredCount = 0
            piecesSetting.Active = false
            dlcqBundlesAvailable.AvailableChestCount = 0
            lfodBundlesAvailable.AvailableChestCount = 0
        end
    end
    if slotData["item_shuffle"] then
        local setting = Tracker:FindObjectForCode("ItemsShuffled")
        setting.Active = slotData["item_shuffle"] ~= 0
    end
    if slotData["permanent_coins"] then
        local setting = Tracker:FindObjectForCode("PermanentCoins")
        setting.Active = slotData["permanent_coins"] ~= 0
    end
    if slotData["death_link"] then
        local setting = Tracker:FindObjectForCode("DeathLink")
        setting.Active = slotData["death_link"] ~= 0
    end

    Tracker.BulkUpdate = false
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
    elseif itemCode == "DLCQCoinPiece" then
        local received = Tracker:FindObjectForCode("DLCQCoinsReceived")
        if received then
            Wallet:DepositDLCQ(1)
            received.AcquiredCount = math.min(Wallet.DLCQBalance / 10, received.MaxCount)
        end
    elseif itemCode == "LFODCoinPiece" then
        local received = Tracker:FindObjectForCode("LFODCoinsReceived")
        if received then
            Wallet:DepositLFOD(1)
            received.AcquiredCount = math.min(Wallet.LFODBalance / 10, received.MaxCount)
        end
    elseif itemCode == "DLCQCoinBundle" then
        local received = Tracker:FindObjectForCode("DLCQCoinsReceived")
        local bundleSize = Tracker:FindObjectForCode("CoinBundleSize")
        if received and bundleSize then
            Wallet:DepositDLCQ(bundleSize.AcquiredCount)
            received.AcquiredCount = math.min(Wallet.DLCQBalance, received.MaxCount)
        end
    elseif itemCode == "LFODCoinBundle" then
        local received = Tracker:FindObjectForCode("LFODCoinsReceived")
        local bundleSize = Tracker:FindObjectForCode("CoinBundleSize")
        if received and bundleSize then
            Wallet:DepositLFOD(bundleSize.AcquiredCount)
            received.AcquiredCount = math.min(Wallet.LFODBalance, received.MaxCount)
        end
    elseif itemCode == "DLCQProgWeapon" then
        local sword = Tracker:FindObjectForCode("Sword")
        local gun = Tracker:FindObjectForCode("Gun")
        if sword and gun then
            gun.Active = sword.Active and DLCQHasProgSword
            sword.Active = true
            DLCQHasProgSword = true
        end
    elseif itemCode == "LFODProgWeapon" then
        local sword = Tracker:FindObjectForCode("NormalSword")
        local pickaxe = Tracker:FindObjectForCode("Pickaxe")
        if sword and pickaxe then
            pickaxe.Active = sword.Active and LFODHasProgSword
            sword.Active = true
            LFODHasProgSword = true
        end
    else
        local item = Tracker:FindObjectForCode(tostring(itemCode))
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
    --local cost = mapping[3]
    local address = "@" .. area .. "/" .. section
    local location = Tracker:FindObjectForCode(address)
    if location then
        location.AvailableChestCount = location.AvailableChestCount - 1

        --Toggle to force logic rules to run
        Tracker.BulkUpdate = true
        Tracker.BulkUpdate = false

        --local permanentCoins = Tracker:FindObjectForCode("PermanentCoins")
        --if permanentCoins.Active then
        --    if id >= 120000 and id <= 120015 then
        --        Wallet:WithdrawDLCQ(cost)
        --
        --        local received = Tracker:FindObjectForCode("DLCQCoinsReceived")
        --        received.AcquiredCount = Wallet.DLCQBalance
        --    elseif id >= 120016 and id <= 120032 then
        --        Wallet:WithdrawLFOD(cost)
        --
        --        local received = Tracker:FindObjectForCode("LFODCoinsReceived")
        --        received.AcquiredCount = Wallet.LFODBalance
        --    end
        --end
    end
end

Archipelago:AddClearHandler("Reset", Reset)
Archipelago:AddItemHandler("Item Received", ItemReceived)
Archipelago:AddLocationHandler("Location Checked", LocationChecked)