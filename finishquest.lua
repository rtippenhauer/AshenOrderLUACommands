local function FinishQuestCommand(event, player, message)
    if player == nil then
        return false
    end

    local args = {}
    for word in string.gmatch(message, "%S+") do
        table.insert(args, word)
    end

    -- Show help
    if args[2] == "-h" then
        player:SendBroadcastMessage("Usage:")
        player:SendBroadcastMessage(".finishquest             - List your current quests with numbers")
        player:SendBroadcastMessage(".finishquest <#>         - Mark that quest complete")
        player:SendBroadcastMessage(".finishquest <#> party   - Complete for all party members with that quest")
        return false
    end

    -- No quest number provided, list current quests
    if args[2] == nil then
        local questLog = player:GetQuestList()
        if #questLog == 0 then
            player:SendBroadcastMessage("You have no active quests.")
            return false
        end

        player:SendBroadcastMessage("Your active quests:")
        for i, questId in ipairs(questLog) do
            local title = GetQuestTitle(questId)
            player:SendBroadcastMessage(i .. ". " .. title .. " (ID: " .. questId .. ")")
        end
        player:SendBroadcastMessage("Use '.finishquest <#>' to finish one.")
        return false
    end

    -- Get quest index from list
    local index = tonumber(args[2])
    local questLog = player:GetQuestList()
    local questId = questLog[index]

    if not questId then
        player:SendBroadcastMessage("Invalid quest number. Use '.finishquest' to see your quests.")
        return false
    end

    local function completeQuest(p, qid)
        if p:HasQuest(qid) then
            p:CompleteQuest(qid)
            p:SendBroadcastMessage("Quest " .. GetQuestTitle(qid) .. " marked complete.")
        end
    end

    -- Check for 'party' option
    if args[3] and string.lower(args[3]) == "party" then
        local group = player:GetGroup()
        if group then
            for _, member in ipairs(group:GetMembers()) do
                completeQuest(member, questId)
            end
            player:SendBroadcastMessage("Marked quest complete for party members who have it.")
        else
            player:SendBroadcastMessage("You're not in a party.")
        end
    else
        completeQuest(player, questId)
    end

    return false
end

RegisterPlayerEvent(42, FinishQuestCommand)