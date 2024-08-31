--Handles the unique interplay of the Harmless Plants Pack and the Name Change Pack
function CanPassNameChangeGate()
    local hpp = Tracker:FindObjectForCode("PackHarmlessPlants")
    local ncp = Tracker:FindObjectForCode("PackNameChange")
    return hpp and ncp and (ncp.Active or not hpp.Active)
end

--Used for DLCQ Shopkeep
function AlwaysScoutable()
    return true
end

--Used only for Animation Pack, Audio Pack, and Pause Menu Pack checks
function MovementOrCoinsanity()
    local bundleSize = Tracker:FindObjectForCode("CoinBundleSize")
    local movement = Tracker:FindObjectForCode("PackMovement")
    return bundleSize.AcquiredCount > 0 or movement.Active
end

--It's currently not possible to track coins outside of Coinsanity,
--so when Coinsanity is not being used, always assume the player
--has sufficient funds to buy all available DLC packs
function HasSufficientDLCQBalance(cost)
    local bundleSize = Tracker:FindObjectForCode("CoinBundleSize")
    return bundleSize.AcquiredCount == 0 or tonumber(cost) <= Wallet.DLCQBalance
end
function HasSufficientLFODBalance(cost)
    local bundleSize = Tracker:FindObjectForCode("CoinBundleSize")
    return bundleSize.AcquiredCount == 0 or tonumber(cost) <= Wallet.LFODBalance
end

--Work out how many coin bundles can be collected
--with the player's current items and compare that
--to the number of bundles actually collected
--to determine if there are still more available
function CanReachRemainingDLCQBundles()
    local reachableCoins = ReachableDLCQCoins()
    if reachableCoins == 825 then
        return true
    else
        local remainingBundles = Tracker:FindObjectForCode("@DLCQ Coinsanity/Coin Bundle").AvailableChestCount
        local bundleSize = Tracker:FindObjectForCode("CoinBundleSize").AcquiredCount
        local bundleCount = math.ceil(825 / bundleSize)
        local reachableBundles = math.floor(reachableCoins / bundleSize)
        local collectedBundles = bundleCount - remainingBundles
        return collectedBundles < reachableBundles
    end
end
function CanReachRemainingLFODBundles()
    local reachableCoins = ReachableLFODCoins()
    if reachableCoins == 889 then
        return true
    else
        local remainingBundles = Tracker:FindObjectForCode("@LFOD Coinsanity/Coin Bundle").AvailableChestCount
        local bundleSize = Tracker:FindObjectForCode("CoinBundleSize").AcquiredCount
        local bundleCount = math.ceil(889 / bundleSize)
        local reachableBundles = math.floor(reachableCoins / bundleSize)
        local collectedBundles = bundleCount - remainingBundles
        return collectedBundles < reachableBundles
    end
end

function ReachableDLCQCoins()
    local mv = Tracker:FindObjectForCode("PackMovement").Active
    local sw = Tracker:FindObjectForCode("Sword").Active
    local dj = Tracker:FindObjectForCode("PackDoubleJump").Active
    local pw = Tracker:FindObjectForCode("PackPsychologicalWarfare").Active
    local mp = Tracker:FindObjectForCode("PackMap").Active

    if not mv then
        return 4
    elseif not sw and not dj and not pw then
        return 50
    elseif sw and not dj and not pw then
        if mp then 
            return 281 
        else 
            return 110 
        end
    elseif not sw and dj and not pw then
        return 110
    elseif not sw and not dj and pw then
        return 150
    elseif sw and dj and not pw then
        if mp then 
            return 656 
        else 
            return 260 
        end
    elseif sw and not dj and pw then
        return 210
    elseif not sw and dj and pw then
        return 216
    elseif sw and dj and pw then
        if mp then
            return 825 
        else 
            return 375 
        end
    end
end

function ReachableLFODCoins()
    local sw = Tracker:FindObjectForCode("NormalSword").Active
    local ax = Tracker:FindObjectForCode("Pickaxe").Active
    local wj = Tracker:FindObjectForCode("PackWallJump").Active
    local cc = Tracker:FindObjectForCode("PackCutContent").Active
    local sp = Tracker:FindObjectForCode("PackSeasonPass").Active

    if not wj then
        if ax then
            return 165
        elseif sw then
            return 145
        else
            return 50
        end
    elseif cc then
        if ax then
            if sp then
                return 889
            else
                return 735
            end
        elseif sw then
            return 495
        else
            return 432
        end
    else
        if ax then
            return 445
        elseif sw then
            return 295
        else
            return 232
        end
    end
end