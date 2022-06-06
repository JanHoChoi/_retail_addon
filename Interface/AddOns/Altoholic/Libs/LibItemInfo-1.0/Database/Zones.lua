--	*** LibItemInfo ***
-- Written by : Thaoky, EU-Marécages de Zangar
-- March 2021
-- This list was manually curated (source: mostly Wowhead + in-game).
-- Non-commercial use is permitted as long as credits are preserved, and that Blizzard's terms of services are respected.

--[[ Purpose of this file :

Items stored in this file are "zone items", or items that are only relevant to a given zone.
The goal is to provide a minimum of info to the user for all those items that only have a vague description.
If it's an item that can simply be clicked to learn (like a pet or a toy), it has nothing to do in this list.
If the item already a clear description about a faction it is related to, it has nothing to do in this list.
However, if it is an item for which you cannot say from which expansion/zone it is.. then it should be here.
For some items that have only 1 location where they can be used in the zone, then try to add X-Y Coords with SetZoneItem()

Zones

https://wowpedia.fandom.com/wiki/UiMapID
C_Map.GetMapInfo()  https://wowpedia.fandom.com/wiki/API_C_Map.GetMapInfo
ID's : https://wowpedia.fandom.com/wiki/UiMapID
--]]

local lib = LibStub("LibItemInfo-1.0")

-- Note, pass the coordinates as integers (simply x10)
-- ex: 38.9 42.0 => 389, 420
local SetZoneItem = lib.SetZoneItem


local VALE_OF_ETERNAL_BLOSSOM = 390


local AZSUNA = 630
local DRAENOR_NAGRAND = 550
local LUNARFALL = 582		-- Alliance WoD Garrison
local FROSTWALL = 590		-- Horde WoD Garrison

local BASTION = 1533
local MALDRAXXUS = 1536
local THE_MAW = 1960
local KORTHIA = 1961
local ZERETH_MORTIS = 1970

lib:RegisterItems({

	-- 1.0 Classic


	
	-- 2.0 BC
	
	-- 3.0 WotLK
	
	-- 4.0 Cataclysm
	
	-- 5.0 Mists of Pandaria
	[87779] = SetZoneItem(4, VALE_OF_ETERNAL_BLOSSOM, 214, 169), 		-- Ancient Guo-Lai Cache Key
	
	-- 6.0 Warlords of Draenor
	[122272] = SetZoneItem(5, LUNARFALL), 		-- Follower Ability Retraining Manual
	[122273] = SetZoneItem(5, LUNARFALL), 		-- Follower Trait Retraining Guide
	[122307] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Barn
	[122490] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Dwarven Bunker
	[122497] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Garden Shipment
	[122487] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Gladiator's Sanctum
	[122500] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Gnomish Gearworks
	[122503] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Mine Shipment
	[128373] = SetZoneItem(5, LUNARFALL), 		-- Rush Order: Shipyard
	-- [122273] = SetZoneItem(5, LUNARFALL), 		-- scouting missives, to do   https://www.wowhead.com/npc=78564/sergeant-crowler#sells;0+1-2
	
	-- same for horde : https://www.wowhead.com/npc=79774/sergeant-grimjaw#sells;0+1-2
	-- [122307] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Barn		Same for A & H
	-- [122487] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Gladiator's Sanctum
	-- [128373] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Shipyard
	-- SEE BELOW !!
	[122496] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Garden Shipment
	[122501] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Goblin Workshop
	[122502] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Mine Shipment
	[122491] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: War Mill
	
	
	[118658] = SetZoneItem(5, DRAENOR_NAGRAND, 502, 412), 		-- Gagrog's Skull
	
	-- 7.0 Legion
	[131744] = SetZoneItem(6, AZSUNA, 533, 394), 		-- Key to Nar'thalas Academy
	
	-- 8.0 Battle for Azeroth
	
	-- 9.0 Shadowlands
	[178149] = SetZoneItem(8, BASTION), -- Centurion Anima Core
	
	[175757] = SetZoneItem(8, MALDRAXXUS, 389, 420), -- Construct Supply Key
	[180277] = SetZoneItem(8, MALDRAXXUS, 379, 456), -- Battlefront Ration Key
	[183987] = SetZoneItem(8, MALDRAXXUS), 	-- Prisoner Cage Key
	
	[186727] = SetZoneItem(8, THE_MAW), 		-- Seal Breaker Key
	[186718] = SetZoneItem(8, KORTHIA), 		-- Teleporter Repair Kit
	
	[188957] = SetZoneItem(8, ZERETH_MORTIS), -- Genesis Mote
	[189863] = SetZoneItem(8, ZERETH_MORTIS), -- Spatial Opener
	[189704] = SetZoneItem(8, ZERETH_MORTIS, 600, 178), -- Dominance Key
	[190189] = SetZoneItem(8, ZERETH_MORTIS), -- Sandworn Relic
	[190197] = SetZoneItem(8, ZERETH_MORTIS), -- Sandworn Chest Key
	[190198] = SetZoneItem(8, ZERETH_MORTIS), -- Sandworn Chest Key Fragment
	[190739] = SetZoneItem(8, ZERETH_MORTIS), -- Provis Wax
	[190740] = SetZoneItem(8, ZERETH_MORTIS), -- Automa Integration
})


-- If the player is playing horde, replace some id's by the horde equivalent location
if UnitFactionGroup("player") == "Horde" then
	lib:RegisterItems({
		[122307] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Barn
		[122487] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Gladiator's Sanctum
		[128373] = SetZoneItem(5, FROSTWALL), 		-- Rush Order: Shipyard
	})
end
