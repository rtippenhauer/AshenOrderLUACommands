local SUPPLY_TYPES = { "food", "drink", "potions", "bandages", "elixirs" }

local function getItemList(player, supplyType)
    local level = player:GetLevel()
    local items = {}

    if supplyType == "food" then
        if level < 15 then table.insert(items, 117) -- Tough Jerky
        elseif level < 25 then table.insert(items, 2287)
        elseif level < 35 then table.insert(items, 3770)
        elseif level < 45 then table.insert(items, 4599)
        else table.insert(items, 16169) end

    elseif supplyType == "drink" then
        if level < 15 then table.insert(items, 159) -- Refreshing Spring Water
        elseif level < 25 then table.insert(items, 1179)
        elseif level < 35 then table.insert(items, 1205)
        elseif level < 45 then table.insert(items, 1708)
        else table.insert(items, 1645) end

    elseif supplyType == "potions" then
        if level < 20 then table.insert(items, 118) -- Minor Healing Potion
        elseif level < 30 then table.insert(items, 858)
        elseif level < 45 then table.insert(items, 1710)
        else table.insert(items, 3928) end

        if player:GetPowerType() == 0 or player:GetClass() == 8 then
            if level < 20 then table.insert(items, 2455) -- Minor Mana Potion
            elseif level < 30 then table.insert(items, 3385)
            elseif level < 45 then table.insert(items, 3827)
            else table.insert(items, 6149) end
        end

    elseif supplyType == "bandages" then
        if level < 15 then table.insert(items, 1251)
        elseif level < 30 then table.insert(items, 2581)
        elseif level < 45 then table.insert(items, 6450)
        else table.insert(items, 14529) end

    elseif supplyType == "elixirs" then
        local class = player:GetClass()
        if class == 1 then table.insert(items, 3389) -- Warrior: Defense
        elseif class == 2 then table.insert(items, 3390) -- Paladin: Lesser Agility
        elseif class == 3 then table.insert(items, 13452) -- Hunter: Brute Force
        elseif class == 4 then table.insert(items, 9187) -- Rogue: Agility
        elseif class == 5 or class == 8 or class == 9 then table.insert(items, 13447) -- Caster
        elseif class == 7 then table.insert(items, 8949) -- Shaman
        elseif class == 11 then table.insert(items, 9206) end
    end

    return items
end

local function handleSuppliesCommand(event, player, command)
    if player == nil then
        return false
    end

    local args = {}
    for word in command:gmatch("%S+") do
        table.insert(args, word)
    end

    if args[1] == "supplies" then
        if args[2] == "-h" then
            player:SendBroadcastMessage("Usage: .supplies [amount] [type]")
            player:SendBroadcastMessage("  amount - Number of items to receive (default 100)")
            player:SendBroadcastMessage("  type   - food, drink, potions, bandages, elixirs, all (default all)")
            return false
        end

        local amount = tonumber(args[2]) or 100
        local requested = args[3] or "all"

        local types = {}
        if requested == "all" then
            types = SUPPLY_TYPES
        else
            for _, t in ipairs(SUPPLY_TYPES) do
                if requested == t then
                    table.insert(types, t)
                    break
                end
            end
        end

        for _, t in ipairs(types) do
            local items = getItemList(player, t)
            for _, item in ipairs(items) do
                player:AddItem(item, amount)
            end
        end

        player:SendBroadcastMessage("Supplies delivered.")
        return false
    end
end

RegisterPlayerEvent(42, handleSuppliesCommand)
