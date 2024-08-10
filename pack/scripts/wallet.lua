Wallet = {
    DLCQBalance = 0,
    LFODBalance = 0
}

function Wallet:Reset()
    Wallet.DLCQBalance = 0
    Wallet.LFODBalance = 0
end

function Wallet:DepositDLCQ(amount)
    Wallet.DLCQBalance = Wallet.DLCQBalance + tonumber(amount)
end

function Wallet:DepositLFOD(amount)
    Wallet.LFODBalance = Wallet.LFODBalance + tonumber(amount)
end

function Wallet:WithdrawDLCQ(amount)
    Wallet.DLCQBalance = Wallet.DLCQBalance - tonumber(amount)
end

function Wallet:WithdrawLFOD(amount)
    Wallet.LFODBalance = Wallet.LFODBalance - tonumber(amount)
end