local function HelpMeCommand(event, player, message)
    if player == nil then
        return false
    end

    player:SendBroadcastMessage("Ashen Order - Available Commands:")
    player:SendBroadcastMessage("|cff00ccff.clearbags|r - Clears junk/unusable/low-level gear from your bags.")
    player:SendBroadcastMessage("|cff00ccff.buyback|r - (Removed feature, command deprecated.)")
    player:SendBroadcastMessage("|cff00ccff.gold <amount>|r - Gives yourself gold. Use -h for help.")
    player:SendBroadcastMessage("|cff00ccff.supplies|r - Get profession supplies.")
    player:SendBroadcastMessage("|cff00ccff.levelme <1-80>|r - Set your level or your target's level. Use -h for help.")
    player:SendBroadcastMessage("|cff00ccff.flyme [on|off]|r - Enables or disables flying. Use -h for help.")
    player:SendBroadcastMessage("|cff00ccff.gofast <speed>|r - Change run speed. Use -h or no value to reset.")
    player:SendBroadcastMessage("|cff00ccff.finishquest|r - Lists current quests and lets you complete one. Use -h for help.")
    return false
end

RegisterPlayerEvent(42, HelpMeCommand)