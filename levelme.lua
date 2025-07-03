local function LevelMeCommand(event, player, message)
    if player == nil then
        return false
    end

    local args = {}
    for word in string.gmatch(message, "%S+") do
        table.insert(args, word)
    end

    if args[2] == "-h" then
        player:SendBroadcastMessage("Usage: .levelme <1-80> [targeted player optional]")
        player:SendBroadcastMessage("Example: .levelme 70")
        player:SendBroadcastMessage("Example: .levelme 60 (while targeting another player)")
        return false
    end

    local level = tonumber(args[2])
    if not level or level < 1 or level > 80 then
        player:SendBroadcastMessage("Invalid level. Must be between 1 and 80.")
        return false
    end

    local target = player:GetSelection()
    if target and target:IsPlayer() then
        target:SetLevel(level)
        player:SendBroadcastMessage("Set " .. target:GetName() .. " to level " .. level .. ".")
        target:SendBroadcastMessage("Your level has been set to " .. level .. " by " .. player:GetName() .. ".")
    else
        player:SetLevel(level)
        player:SendBroadcastMessage("Your level has been set to " .. level .. ".")
    end

    return false
end

RegisterPlayerEvent(42, LevelMeCommand)