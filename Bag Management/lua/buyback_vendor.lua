-- Ashen Order - Buyback Vendor Gossip Handler
local BUYBACK_VENDOR_ID = 99010

local function OnGossipHello(event, player, creature)
    local guid = player:GetGUIDLow()
    local data = BUYBACK_DATA[guid]
    if not data or #data == 0 then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "No items available for buyback.", 1, 0)
        player:GossipSendMenu(1, creature)
        return
    end

    local groups = {}
    for _, item in ipairs(data) do
        local group = item.type or "Misc"
        if not groups[group] then groups[group] = {} end
        table.insert(groups[group], item)
    end

    player:GossipClearMenu()
    local id = 1
    for group, items in pairs(groups) do
        player:GossipMenuAddItem(0, "== " .. group .. " ==", 1000 + id, 0)
        for _, item in ipairs(items) do
            player:GossipMenuAddItem(0, item.name .. " x" .. item.count, item.entry, 0)
        end
        id = id + 1
    end
    player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid >= 1000 then return OnGossipHello(event, player, creature) end

    local guid = player:GetGUIDLow()
    local data = BUYBACK_DATA[guid]
    for i, item in ipairs(data) do
        if item.entry == intid then
            player:AddItem(item.entry, item.count)
            table.remove(data, i)
            break
        end
    end
    OnGossipHello(event, player, creature)
end

RegisterCreatureGossipEvent(BUYBACK_VENDOR_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(BUYBACK_VENDOR_ID, 2, OnGossipSelect)
