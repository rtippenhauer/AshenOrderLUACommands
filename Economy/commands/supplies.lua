local function GetItemForLevel(level, itemTable)
    local selectedItem = nil
    for _, entry in ipairs(itemTable) do
        if level >= entry.minLevel then
            selectedItem = entry
        else
            break
        end
    end
    return selectedItem and selectedItem.itemId or nil
end

-- Food: Every 10 levels starting at 5
local FOOD_ITEMS = {
    {minLevel = 5, itemId = 4536},    -- Bananas
    {minLevel = 15, itemId = 4540},   -- Tough Hunk of Bread
    {minLevel = 25, itemId = 4544},   -- Mulgore Spice Bread
    {minLevel = 35, itemId = 16169},  -- Wild Ricecake
    {minLevel = 45, itemId = 8932},   -- Alterac Swiss
    {minLevel = 55, itemId = 27854},  -- Smoked Talbuk Venison
    {minLevel = 65, itemId = 35951},  -- Sizzling Meat Chops
    {minLevel = 75, itemId = 43015},  -- Fish Feast
}

-- Drink: Every 10 levels starting at 10
local DRINK_ITEMS = {
    {minLevel = 10, itemId = 159},     -- Refreshing Spring Water
    {minLevel = 20, itemId = 1179},    -- Ice Cold Milk
    {minLevel = 30, itemId = 1205},    -- Melon Juice
    {minLevel = 40, itemId = 1708},    -- Sweet Nectar
    {minLevel = 50, itemId = 27860},   -- Purified Draenic Water
    {minLevel = 60, itemId = 28399},   -- Filtered Draenic Water
    {minLevel = 70, itemId = 33445},   -- Honeymint Tea
    {minLevel = 80, itemId = 43523},   -- Frostberry Juice
}

-- Health Potions: Every 10 levels starting at 5
local HEALTH_POTIONS = {
    {minLevel = 5, itemId = 118},       -- Minor Healing Potion
    {minLevel = 15, itemId = 858},      -- Lesser Healing Potion
    {minLevel = 25, itemId = 929},      -- Healing Potion
    {minLevel = 35, itemId = 1710},     -- Greater Healing Potion
    {minLevel = 45, itemId = 3928},     -- Superior Healing Potion
    {minLevel = 55, itemId = 13446},    -- Major Healing Potion
    {minLevel = 65, itemId = 22829},    -- Super Healing Potion
    {minLevel = 75, itemId = 33447},    -- Runic Healing Potion
}

-- Mana Potions: Every 10 levels starting at 5
local MANA_POTIONS = {
    {minLevel = 5, itemId = 2455},       -- Minor Mana Potion
    {minLevel = 15, itemId = 3385},      -- Lesser Mana Potion
    {minLevel = 25, itemId = 3827},      -- Mana Potion
    {minLevel = 35, itemId = 6149},      -- Greater Mana Potion
    {minLevel = 45, itemId = 13443},     -- Superior Mana Potion
    {minLevel = 55, itemId = 13444},     -- Major Mana Potion
    {minLevel = 65, itemId = 22832},     -- Super Mana Potion
    {minLevel = 75, itemId = 33448},     -- Runic Mana Potion
}

-- Bandages
local BANDAGES = {
    {minLevel = 5, itemId = 1251},       -- Linen Bandage
    {minLevel = 15, itemId = 3530},      -- Wool Bandage
    {minLevel = 25, itemId = 6451},      -- Heavy Silk Bandage
    {minLevel = 35, itemId = 8545},      -- Heavy Mageweave Bandage
    {minLevel = 45, itemId = 14530},     -- Heavy Runecloth Bandage
    {minLevel = 55, itemId = 21991},     -- Heavy Netherweave Bandage
    {minLevel = 65, itemId = 34722},     -- Heavy Frostweave Bandage
}

-- Elixirs: Example elixirs based on stat-boosting usage
local ELIXIRS = {
    {minLevel = 15, itemId = 8949},      -- Elixir of Agility
    {minLevel = 25, itemId = 3825},      -- Elixir of Fortitude
    {minLevel = 35, itemId = 3390},      -- Elixir of Lesser Agility
    {minLevel = 45, itemId = 13452},     -- Elixir of the Mongoose
    {minLevel = 55, itemId = 22824},     -- Elixir of Major Strength
    {minLevel = 65, itemId = 32067},     -- Elixir of Draenic Wisdom
    {minLevel = 75, itemId = 40073},     -- Elixir of Mighty Strength
}

local function GiveItem(player, itemId, count)
    if itemId then
        player:AddItem(itemId, count)
    end
end

local function SuppliesCommand(event, player, command)
    if command:lower():sub(1, 8) ~= "supplies" then
        return
    end

    local args = {}
    for arg in command:gmatch("%S+") do
        table.insert(args, arg)
    end

    -- Help flag
    if args[2] == "-h" or args[2] == "--help" then
        player:SendBroadcastMessage("Usage: .supplies [count] [type]")
        player:SendBroadcastMessage(" - count: Number of items (default 100)")
        player:SendBroadcastMessage(" - type: food, drink, potions, health, mana, elixirs, bandages, all (default all)")
        return false
    end

    local count = 100
    local itemType = "all"

    if tonumber(args[2]) then
        count = tonumber(args[2])
        itemType = args[3] and args[3]:lower() or "all"
    elseif args[2] then
        itemType = args[2]:lower()
    end

    local level = player:GetLevel()

    if itemType == "all" or itemType == "food" then
        GiveItem(player, GetItemForLevel(level, FOOD_ITEMS), count)
    end
    if itemType == "all" or itemType == "drink" then
        GiveItem(player, GetItemForLevel(level, DRINK_ITEMS), count)
    end
    if itemType == "all" or itemType == "potions" or itemType == "health" then
        GiveItem(player, GetItemForLevel(level, HEALTH_POTIONS), count)
    end
    if itemType == "all" or itemType == "mana" then
        GiveItem(player, GetItemForLevel(level, MANA_POTIONS), count)
    end
    if itemType == "all" or itemType == "bandages" then
        GiveItem(player, GetItemForLevel(level, BANDAGES), count)
    end
    if itemType == "all" or itemType == "elixirs" then
        GiveItem(player, GetItemForLevel(level, ELIXIRS), count)
    end

    player:SendBroadcastMessage("Supplies delivered: " .. count .. "x " .. itemType)
    return false
end

RegisterPlayerEvent(42, SuppliesCommand)
