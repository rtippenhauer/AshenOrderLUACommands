-- Buyback Vendor (NPC ID 99010)
DELETE FROM creature_template WHERE entry = 99010;
INSERT INTO creature_template (entry, name, subname, GossipMenuId, npcflag, minlevel, maxlevel, scale, unit_class, type, faction, speed_walk, speed_run)
VALUES (99010, 'Buyback Vendor', 'Reclaim your cleared items', 0, 1, 80, 80, 1, 1, 7, 35, 1, 1.2);
