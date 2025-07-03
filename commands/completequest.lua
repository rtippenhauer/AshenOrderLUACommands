-- commands/completequest.lua

local function ListActiveQuests(player)
    for slot = 0, 24 do -- Max 25 quests
        local questId = player:GetQuestId(slot)
        if questId and questId ~= 0 then
            local entry = GetQuestEntry(questId)
            local title = entry and entry.Title or "Unknown"
            player:SendBroadcastMessage(string.format("[%d] %s", questId, title))
        end
    end
end

local function CompleteQuest(player, questId)
    if player:HasQuest(questId) then
        player:CompleteQuest(questId)
        player:SendBroadcastMessage("Quest " .. questId .. " objectives completed.")
    else
        player:SendBroadcastMessage("You do not have quest ID " .. questId)
    end
end

local function HandleCompleteQuest(event, player, msg, Type, lang)
    if not msg:lower():match("^%.completequest") then return end

    local questId, target = msg:match("^%.completequest%s+(%d+)%s*(%a*)")

    if not questId then
        player:SendBroadcastMessage("Active Quests:")
        ListActiveQuests(player)
    else
        questId = tonumber(questId)
        if target == "party" and player:GetGroup() then
            for _, member in ipairs(player:GetGroup():GetMembers()) do
                if member:IsInWorld() then CompleteQuest(member, questId) end
            end
        else
            CompleteQuest(player, questId)
        end
    end

    return false
end

RegisterPlayerEvent(18, HandleCompleteQuest)
