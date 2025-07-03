local function ClearBagsCommand(event, player, message)
    if player == nil then
        return false
    end

    if string.find(message, "-h") then
        player:SendBroadcastMessage("Usage: .clearbags")
        player:SendBroadcastMessage("Sells or destroys junk, unusable, or low-level items from your bags.")
        player:SendBroadcastMessage("Items 10+ levels below your current level or unusable by your class are removed.")
        return false
    end

    local removedCount = 0
    local playerLevel = player:GetLevel()

    for bag = 0, 4 do
        for slot = 0, player:GetBagSize(bag) - 1 do
            local item = player:GetItemByPos(bag, slot)
            if item then
                local entry = item:GetEntry()
                local itemClass = item:GetClass()
                local itemSubClass = item:GetSubClass()
                local itemLevel = item:GetRequiredLevel()
                local quality = item:GetQuality()

                local shouldRemove = false

                if quality == 0 then -- poor quality (junk)
                    shouldRemove = true
                elseif itemLevel > 1 and itemLevel + 10 <= playerLevel then
                    shouldRemove = true
                elseif not player:CanUseItem(item) then
                    shouldRemove = true
                end

                if shouldRemove then
                    local sellPrice = item:GetSellPrice()
                    if sellPrice > 0 then
                        player:ModifyMoney(sellPrice * item:GetCount())
                        player:SendBroadcastMessage("Sold: " .. item:GetItemLink())
                    else
                        player:SendBroadcastMessage("Destroyed: " .. item:GetItemLink())
                    end
                    player:RemoveItem(entry, item:GetCount())
                    removedCount = removedCount + 1
                end
            end
        end
    end

    if removedCount == 0 then
        player:SendBroadcastMessage("No items were removed from your bags.")
    else
        player:SendBroadcastMessage("Cleared " .. removedCount .. " items from your bags.")
    end

    return false
end

RegisterPlayerEvent(42, ClearBagsCommand)