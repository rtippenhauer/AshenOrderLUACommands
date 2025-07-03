-- gossip/buyback_vendor.lua

local BUYBACK_VENDOR_ID = 99010

local function OnGossipHello(event, player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "Browse Buyback Items", 0, 1)
    player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then
        player:SendListInventory(creature)
    end
end

RegisterCreatureGossipEvent(BUYBACK_VENDOR_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(BUYBACK_VENDOR_ID, 2, OnGossipSelect)
