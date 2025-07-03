local function AddGoldCommand(event, player, command)
    if command:lower():find("^%.gold") then
        local args = command:match("^%.gold%s*(.*)")

        -- Show help if -h is present
        if args and args:lower() == "-h" then
            player:SendBroadcastMessage(".gold <amount> - Adds the specified amount of gold to your inventory.")
            player:SendBroadcastMessage("If <amount> is omitted or invalid, 100 gold is granted by default.")
            return false
        end

        -- Parse gold amount
        local amount = tonumber(args)
        if not amount or amount < 1 then
            amount = 100
        end

        local copper = amount * 10000
        player:ModifyMoney(copper)
        player:SendBroadcastMessage(string.format("You have been granted %d gold.", amount))

        return false
    end
end

RegisterPlayerEvent(42, AddGoldCommand)
