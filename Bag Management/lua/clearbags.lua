-- Ashen Order - .clearbags Command
local BUYBACK_DATA = {}

local function IsLowLevel(item, playerLevel)
    return item:GetRequiredLevel() > 1 and (item:GetRequiredLevel() + 10 <= playerLevel)
end

local function IsUnusable(item, player)
    return not player:CanUseItem(item)
end

local function ShouldClearItem(item, player)
    local quality = item:GetQuality()
    local level = player:GetLevel()
    return (
        quality == 0 or
        IsLowLevel(item, level) or
        IsUnusable(item, player)
    )
end

local function TrackBuybackItem(playerGUID, item)
    if not BUYBACK_DATA[playerGUID] then BUYBACK_DATA[playerGUID] = {} end
    table.insert(BUYBACK_DATA[playerGUID], {
        entry = item:GetEntry(),
        count = item:GetCount(),
        type = item:GetClass(),
        name = item:GetItemLink()
    })
end

local function ClearBagsCommand(event, player, command)
    if command:match("^clearbags%s?-h$") then
        player:SendBroadcastMessage(".clearbags - Sells junk, low-level, and unusable items from your bags.")
        player:SendBroadcastMessage("Items are tracked for buyback at the vendor.")
        return false
    end

    if command == "clearbags" then
        for bag = 0, 4 do
            for slot = 0, player:GetBagSize(bag) - 1 do
                local item = player:GetItemByPos(bag, slot)
                if item and ShouldClearItem(item, player) then
                    local sellPrice = item:GetSellPrice()
                    if sellPrice > 0 and player:SellItem(item) then
                        TrackBuybackItem(player:GetGUIDLow(), item)
                    else
                        TrackBuybackItem(player:GetGUIDLow(), item)
                        player:RemoveItem(item:GetEntry(), item:GetCount())
                    end
                end
            end
        end
        player:SendBroadcastMessage("Bags cleared. Items sent to Buyback Vendor.")
        return false
    end
end

RegisterPlayerEvent(42, ClearBagsCommand) -- OnCommand
