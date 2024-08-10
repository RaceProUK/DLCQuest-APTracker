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