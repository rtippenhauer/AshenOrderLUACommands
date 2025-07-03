-- gossip/trainer_master.lua

local TRAINER_MASTER_ID = 99011
local TRAINERS = {
    ["Warrior"] = 5113, ["Paladin"] = 5144, ["Hunter"] = 5115,
    ["Rogue"] = 5165, ["Priest"] = 5149, ["Shaman"] = 5140,
    ["Mage"] = 5142, ["Warlock"] = 5171, ["Druid"] = 5505,
    ["Tailoring"] = 11052, ["Blacksmithing"] = 5164,
    ["Alchemy"] = 4611, ["Enchanting"] = 11072,
    ["Engineering"] = 5518, ["Herbalism"] = 12025,
    ["Inscription"] = 30715, ["Jewelcrafting"] = 19775,
    ["Leatherworking"] = 5784, ["Mining"] = 4254,
    ["Skinning"] = 7087, ["Cooking"] = 4210,
    ["First Aid"] = 2326, ["Fishing"] = 1680
}

local function OnGossipHello(event, player, creature)
    player:GossipClearMenu()
    for name, _ in pairs(TRAINERS) do
        player:GossipMenuAddItem(0, name, 0, name)
    end
    player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menu_id)
    local entry = TRAINERS[intid]
    if entry then
        local x, y, z, o = player:GetLocation()
        local npc = PerformIngameSpawn(1, entry, player:GetMapId(), 1, x+2, y, z, o, true, 120000)
        if npc then
            player:SendBroadcastMessage("Trainer summoned: " .. intid)
        end
    end
end

RegisterCreatureGossipEvent(TRAINER_MASTER_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(TRAINER_MASTER_ID, 2, OnGossipSelect)
