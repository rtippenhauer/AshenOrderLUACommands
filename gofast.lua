local function GoFastCommand(event, player, message)
    if player == nil then
        return false
    end

    local args = {}
    for word in string.gmatch(message, "%S+") do
        table.insert(args, word)
    end

    if args[2] == "-h" then
        player:SendBroadcastMessage("Usage: .gofast <speed>")
        player:SendBroadcastMessage("Sets your running speed, or your target's speed if you have another player selected.")
        player:SendBroadcastMessage("If no speed is given, resets to default speed (1).")
        player:SendBroadcastMessage("Examples:")
        player:SendBroadcastMessage(".gofast 2")
        player:SendBroadcastMessage(".gofast")
        return false
    end

    local speed = tonumber(args[2]) or 1.0

    if speed < 0.1 or speed > 20 then
        player:SendBroadcastMessage("Invalid speed. Enter a number between 0.1 and 20.")
        return false
    end

    local target = player:GetSelection()
    if target and target:IsPlayer() then
        target:SetSpeed(1, speed, true) -- 1 = MOVE_RUN
        player:SendBroadcastMessage("Set " .. target:GetName() .. "'s run speed to " .. speed .. ".")
        target:SendBroadcastMessage("Your run speed was set to " .. speed .. " by " .. player:GetName() .. ".")
    else
        player:SetSpeed(1, speed, true)
        player:SendBroadcastMessage("Your run speed is now set to " .. speed .. ".")
    end

    return false
end

RegisterPlayerEvent(42, GoFastCommand)