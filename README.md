# AshenOrderEnhancements

A Lua module pack for the AzerothCore-based Ashen Order repack.

## Features

### Utility Commands
- `.buff [party]`: Apply level-appropriate buffs and restore health/mana
- `.fly on|off`, `.speed [value]`, `.scale [value]`: Movement control
- `.morph [id]`, `.demorph`, `.invisible on|off`
- `.resetcooldowns`, `.clearaura`
- `.summonobject [entryId]`: Temporarily spawn a game object
- `.sethome`, `.hearth`: Custom home teleport
- `.weather [type] [intensity]`, `.time [0-23]`
- `.duelreset`: Reset duel status
- `.completequest [id] [party]`: Complete quest for self or party

### Gameplay Commands
- `.buy`, `.gold [amount]`, `.level [1-80]`
- `.save [name]`, `.goto [name]`, `.deletelocation [name]`
- `.summon [name]`: Summon trainers, vendors, or events
- `.savepet [name]`, `.loadpet [name]`, `.deletepet [name]`
- `.clearbags`, `.clearbuyback`
- `.startevent`, `.endevent`, `.addevent`, `.listevents`

## Gossip NPCs
- Buyback Vendor (ID: 99010)
- Trainer Master (ID: 99011)
- Ultimate Vendor (ID: 99012)

## Setup

1. Copy the contents of `ashen_order_pack` into your `scripts/custom/ashen_order` directory.
2. Add `ashen_order_loader.lua` to your world server startup scripts.
3. Import the provided SQL files into your AzerothCore database.
4. Use `.help` in-game for all available commands.

---

Developed as a modular, extensible toolkit for Ashen Order repacks. Contributions welcome!
