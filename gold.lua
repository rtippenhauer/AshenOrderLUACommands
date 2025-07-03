local function GoldCommand(event, player, message)
    if player == nil then
        return false
    end

    local args = {}
    for word in string.gmatch(message, "%S+") do
        table.insert(args, word)
    end

    if args[2] == "-h" then
        player:SendBroadcastMessage("Usage: .gold <amount>")
        player:SendBroadcastMessage("Gives you the specified amount of gold (in gold units, not copper).")
        player:SendBroadcastMessage("Example: .gold 100")
        return false
    end

    local amount = tonumber(args[2])
    if not amount or amount < 1 then
        player:SendBroadcastMessage("Invalid amount. Use .gold <amount> where amount is greater than 0.")
        return false
    end

    player:ModifyMoney(amount * 10000) -- Convert gold to copper
    player:SendBroadcastMessage("You have received " .. amount .. " gold.")
    return false
end

RegisterPlayerEvent(42, GoldCommand)