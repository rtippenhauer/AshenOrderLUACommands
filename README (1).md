# Ashen Order Lua Commands

This repository contains a collection of custom Lua scripts for enhancing gameplay on the Ashen Order 2.0 AzerothCore repack. Each command is player-initiated and includes built-in help (`-h`) options.

---

## 📜 Commands

### `.clearbags`
Sells or destroys junk, unusable, or gear more than 10 levels below the player's current level.

- **Usage:** `.clearbags`
- **Help:** `.clearbags -h`

---

### `.buyback` *(Deprecated)*
Formerly used for reclaiming cleared items. No longer in use.

---

### `.gold`
Grants the player a specified amount of gold.

- **Usage:** `.gold <amount>`
- **Help:** `.gold -h`
- **Example:** `.gold 100`

---

### `.supplies`
Provides profession-related supplies to the player.

- **Usage:** `.supplies`

---

### `.levelme`
Sets your level or the level of a targeted player (1–80).

- **Usage:** `.levelme <level>`
- **Help:** `.levelme -h`
- **Example:** `.levelme 70`

---

### `.flyme`
Enables or disables flying.

- **Usage:** `.flyme on` or `.flyme off`
- **Help:** `.flyme -h`

---

### `.gofast`
Sets the player or target's run speed (0.1 to 20). If no speed is provided, resets to normal.

- **Usage:** `.gofast <speed>`
- **Help:** `.gofast -h`
- **Examples:** `.gofast 2`, `.gofast` (resets to 1)

---

### `.finishquest`
Lists and allows completion of quests in the player's log, optionally for the party.

- **Usage:**
  - `.finishquest` — lists current quests
  - `.finishquest <#>` — completes the quest at that list number
  - `.finishquest <#> party` — completes it for the whole party if they have it
- **Help:** `.finishquest -h`

---

## 🔧 Setup Notes
Ensure each script is placed in your Lua script directory and registered properly in your AzerothCore repack. Use the provided SQL if integrating with the `command` table.