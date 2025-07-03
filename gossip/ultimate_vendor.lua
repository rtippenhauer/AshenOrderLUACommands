-- gossip/ultimate_vendor.lua

local ULTIMATE_VENDOR_ID = 99012

local VENDOR_OPTIONS = {
    ["Consumables"] = 99001,
    ["Professions"] = 99002,
    ["Enchantments"] = 99003,
    ["Glyphs"] = 99004,
    ["Upgrades"] = 99005
}

local function OnGossipHello(event, player, creature)
    player:GossipClearMenu()
    for label, _ in pairs(VENDOR_OPTIONS) do
        player:GossipMenuAddItem(0, label, 0, label)
    end
    player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menu_id)
    local entry = VENDOR_OPTIONS[intid]
    if entry then
        player:SendListInventory(entry)
    end
end

RegisterCreatureGossipEvent(ULTIMATE_VENDOR_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(ULTIMATE_VENDOR_ID, 2, OnGossipSelect)
