-- Ashen Order - .buyback Command
local BUYBACK_VENDOR_ID = 99010

local function SpawnBuybackVendor(event, player, command)
    if command:match("^buyback%s?-h$") then
        player:SendBroadcastMessage(".buyback [minutes] - Spawns Buyback Vendor in front of you.")
        player:SendBroadcastMessage("Default: 2 minutes, Range: 1–10 minutes.")
        return false
    end

    local _, _, duration = string.find(command, "buyback%s?(%d*)")
    local time = tonumber(duration) or 2
    if time < 1 then time = 1 elseif time > 10 then time = 10 end

    local x, y, z = player:GetLocation()
    local o = player:GetO()
    local frontX = x + (math.cos(o) * 5)
    local frontY = y + (math.sin(o) * 5)
    local vendor = player:SpawnCreature(BUYBACK_VENDOR_ID, frontX, frontY, z, o + math.pi, 1, time * 60 * 1000)
    if vendor then
        player:SendBroadcastMessage("Buyback Vendor spawned for " .. time .. " minute(s).")
    end
    return false
end

RegisterPlayerEvent(42, SpawnBuybackVendor) -- OnCommand
