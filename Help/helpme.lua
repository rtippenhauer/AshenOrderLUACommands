-- Ashen Order - .helpme Command
local function HelpMeCommand(event, player, command)
    if command:match("^helpme%s?-h$") then
        player:SendBroadcastMessage(".helpme - Lists all available Ashen Order enhancement commands.")
        return false
    end

    if command == "helpme" then
        player:SendBroadcastMessage("|cff00ff00Ashen Order Enhancement Commands:|r")

        player:SendBroadcastMessage("|cffffff00General Utility:|r")
        player:SendBroadcastMessage(".helpme - Shows this help message.")
        player:SendBroadcastMessage(".clearbags - Sells/deletes junk, low-level, and unusable gear. Use -h for details.")
        player:SendBroadcastMessage(".buyback [minutes] - Spawns a vendor to reclaim cleared items. Use -h for details.")

        player:SendBroadcastMessage("|cffffff00Economy:|r")
        player:SendBroadcastMessage(".gold - Grants your character some starting gold. Use -h for details.")
        player:SendBroadcastMessage(".supplies - Gives class-based starter items. Use -h for details.")

        player:SendBroadcastMessage("|cffffff00(Tip: Add -h to any command for details.)|r")
        return false
    end
end

RegisterPlayerEvent(42, HelpMeCommand) -- OnCommand
