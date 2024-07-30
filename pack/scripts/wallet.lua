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
    print("DLCQ Deposit " .. amount .. ", new balance " .. Wallet.DLCQBalance)
end

function Wallet:DepositLFOD(amount)
    Wallet.LFODBalance = Wallet.LFODBalance + tonumber(amount)
    print("LFOD Deposit " .. amount .. ", new balance " .. Wallet.LFODBalance)
end

function Wallet:WithdrawDLCQ(amount)
    Wallet.DLCQBalance = Wallet.DLCQBalance - tonumber(amount)
    print("DLCQ Withdrawal " .. amount .. ", new balance " .. Wallet.DLCQBalance)
end

function Wallet:WithdrawLFOD(amount)
    Wallet.LFODBalance = Wallet.LFODBalance - tonumber(amount)
    print("LFOD Withdrawal " .. amount .. ", new balance " .. Wallet.LFODBalance)
end