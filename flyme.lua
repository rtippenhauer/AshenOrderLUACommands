local function FlyMeCommand(event, player, message)
    if player == nil then
        return false
    end

    local args = {}
    for word in string.gmatch(message, "%S+") do
        table.insert(args, word)
    end

    if args[2] == "-h" then
        player:SendBroadcastMessage("Usage: .flyme [on|off]")
        player:SendBroadcastMessage("Toggles your ability to fly.")
        player:SendBroadcastMessage("Examples:")
        player:SendBroadcastMessage(".flyme on")
        player:SendBroadcastMessage(".flyme off")
        return false
    end

    local arg = args[2]
    if arg == "on" then
        player:SetCanFly(true)
        player:SendBroadcastMessage("Flying enabled.")
    elseif arg == "off" then
        player:SetCanFly(false)
        player:SendBroadcastMessage("Flying disabled.")
    else
        player:SendBroadcastMessage("Invalid usage. Use '.flyme -h' for help.")
    end

    return false
end

RegisterPlayerEvent(42, FlyMeCommand)