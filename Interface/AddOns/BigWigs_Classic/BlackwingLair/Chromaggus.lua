--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Chromaggus", 469, 1535)
if not mod then return end
mod:RegisterEnableMob(14020)

local barcount = 2
local debuffCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.breath = "Breaths"
	L.breath_desc = "Warn for Breaths."

	L.debuffs = "{23174} ({605})" -- Chromatic Mutation (Mind Control)
	L.debuffs_desc = 23174
	L.debuffs_icon = 23174
	L.debuffs_message = "3/5 debuffs, carefull!"
	L.debuffs_warning = "4/5 debuffs, %s on 5th!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		23128, -- Enrage
		23537, -- Frenzy
		"breath",
		"debuffs",
		--"vulnerability",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "Enrage", 23128)
	self:Log("SPELL_AURA_APPLIED", "Frenzy", 23537)
	self:Log("SPELL_AURA_APPLIED", "Debuffs", 23170, 23154, 23155, 23169, 23153) -- Brood Affliction: Bronze, Black, Red, Green, Blue
	self:Log("SPELL_AURA_REMOVED", "DebuffsRemoved", 23170, 23154, 23155, 23169, 23153) -- Brood Affliction: Bronze, Black, Red, Green, Blue
	self:Log("SPELL_CAST_START", "Breath",
		23310, 23312, -- Time Lapse
		23313, 23314, 33551, -- Corrosive Acid
		23315, 23316, -- Ignite Flesh
		23308, 23309, -- Incinerate
		23187, 23189 -- Frost Burn
	)

	self:Death("Win", 14020)
end

function mod:OnEngage()
	barcount = 2
	debuffCount = 0
	self:RegisterUnitEvent("UNIT_HEALTH", "FrenzySoon", "boss1")

	local b1 = CL.count:format(self:SpellName(18617), 1) -- Breath (1)
	local b2 = CL.count:format(self:SpellName(18617), 2) -- Breath (2)
	self:Bar("breath", 30, b1, 212812) -- INV_Misc_QuestionMark / icon 134400
	self:Bar("breath", 60, b2, 212812)
	self:DelayedMessage("breath", 20, "green", CL.custom_sec:format(b1, 10))
	self:DelayedMessage("breath", 50, "green", CL.custom_sec:format(b2, 10))
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Enrage(args)
	self:MessageOld(args.spellId, "yellow")
end

function mod:Frenzy(args)
	self:UnregisterUnitEvent("UNIT_HEALTH", "boss1")
	self:MessageOld(args.spellId, "red", nil, "20% - ".. args.spellName)
end

function mod:Debuffs(args)
	if self:Me(args.destGUID) then
		debuffCount = debuffCount + 1
		if debuffCount == 3 then
			self:MessageOld("debuffs", "red", "alarm", L.debuffs_message, args.spellId)
		elseif debuffCount == 4 then
			self:MessageOld("debuffs", "orange", "warning", L.debuffs_warning:format(self:SpellName(605)), args.spellId) -- 605 = Mind Control
		elseif debuffCount == 5 then
			self:MessageOld("debuffs", "orange", "warning", 605, args.spellId) -- 605 = Mind Control
		end
	end
end

function mod:DebuffsRemoved(args)
	if self:Me(args.destGUID) then
		debuffCount = debuffCount - 1
	end
end

function mod:Breath(args)
	if barcount == 2 then
		barcount = 1
		self:StopBar(CL.count:format(self:SpellName(18617), 1)) -- Breath (1)
	elseif barcount == 1 then
		barcount = 0
		self:StopBar(CL.count:format(self:SpellName(18617), 2)) -- Breath (2)
	end

	self:Bar("breath", 2, CL.cast:format(args.spellName), args.spellId)
	self:MessageOld("breath", "yellow", nil, CL.casting:format(args.spellName), args.spellId)
	self:DelayedMessage("breath", 50, "red", CL.custom_sec:format(args.spellName, 10))
	self:Bar("breath", 60, args.spellId)
end

function mod:FrenzySoon(event, unitId)
	local hp = UnitHealth(unitId) / UnitHealthMax(unitId)
	if hp < 0.25 then -- Frenzy at 20%
		self:UnregisterUnitEvent(event, unitId)
		self:MessageOld(23537, "cyan", nil, CL.soon:format(self:SpellName(23537)), false)
	end
end

--function mod:CHAT_MSG_MONSTER_EMOTE(msg)
--	if msg == L["vulnerability_trigger"] then
--		if self.db.profile.vulnerability then
--			self:MessageOld(L["vulnerability_warning"], "green")
--		end
--		--self:ScheduleEvent("BWChromNilSurv", function() mod.vulnerability = nil end, 2.5)
--	end
--end

--if (GetLocale() == "koKR") or (GetLocale() == "zhCN") then
--	function mod:PlayerDamageEvents(msg)
--		if (not self.vulnerability) then
--			local dmg, school, type = select(4, msg:find(L["vulnerability_test"]))
--			if ( type == L["hit"] or type == L["crit"] ) and tonumber(dmg or "") and school then
--				if (tonumber(dmg) >= 550 and type == L["hit"]) or (tonumber(dmg) >= 1100 and type == L["crit"]) then
--					self.vulnerability = school
--					if self.db.profile.vulnerability then self:MessageOld(format(L["vulnerability_message"], school), "green") end
--				end
--			end
--		end
--	end
--else
--	function mod:PlayerDamageEvents(msg)
--		if (not self.vulnerability) then
--			local type, dmg, school = select(3, msg:find(L["vulnerability_test"]))
--			if ( type == L["hit"] or type == L["crit"] ) and tonumber(dmg or "") and school then
--				if (tonumber(dmg) >= 550 and type == L["hit"]) or (tonumber(dmg) >= 1100 and type == L["crit"]) then
--					self.vulnerability = school
--					if self.db.profile.vulnerability then self:MessageOld(format(L["vulnerability_message"], school), "green") end
--				end
--			end
--		end
--	end
--end

--L:RegisterTranslations("enUS", function() return {
--	vulnerability = "Vulnerability Change",
--	vulnerability_desc = "Warn for Vulnerability changes.",
--	vulnerability_trigger = "%s flinches as its skin shimmers.",
--	vulnerability_message = "Vulnerability: %s!",
--	vulnerability_warning = "Spell vulnerability changed!",
--} end )

--L:RegisterTranslations("ruRU", function() return {
--	vulnerability = "?????????????????? ????????????????????",
--	vulnerability_desc = "???????????????? ?????????? ???????????????????? ????????????????????.",
--	vulnerability_trigger = "%s ?????????????????? ?????? ???????????????? ?????? ????????.",
--	vulnerability_message = "????????????????????: %s!",
--	vulnerability_warning = "???????????????????? ?? ???????????? ????????????????!",
--} end )

--L:RegisterTranslations("deDE", function() return {
--	vulnerability = "Zauber-Verwundbarkeiten",
--	vulnerability_desc = "Warnung, wenn Chromagguss Zauber-Verwundbarkeit sich ??ndert.",
--	vulnerability_trigger = "%s weicht zur??ck, als die Haut schimmert.",
--	vulnerability_message = "Neue Zauber-Verwundbarkeit: %s",
--	vulnerability_warning = "Zauber-Verwundbarkeit ge??ndert!",
--} end )

--L:RegisterTranslations("zhCN", function() return {
--	vulnerability = "????????????",
--	vulnerability_desc = "??????????????????????????????????????????",
--	vulnerability_trigger = "%s???????????????????????????????????????",
--	vulnerability_message = "???????????????????????????%s",
--	vulnerability_warning = "???????????????????????????",
--} end )

--L:RegisterTranslations("zhTW", function() return {
--	vulnerability = "??????????????????",
--	vulnerability_desc = "?????????????????????????????????????????????",
--	vulnerability_trigger = "%s???????????????????????????????????????", --????????????
--	vulnerability_message = "???????????????????????????%s ???",
--	vulnerability_warning = "???????????????????????????",
--} end )

--L:RegisterTranslations("koKR", function() return {
--	vulnerability = "?????? ?????? ??????",
--	vulnerability_desc = "?????? ?????? ????????? ?????? ??????",
--	vulnerability_trigger = "%s|1???;???; ??????????????? ??????????????? ????????? ????????????.", --"????????? ?????? ???????????? ???????????? ???????????????.",
--	vulnerability_message = "????????? ?????? ??????: %s",
--	vulnerability_warning = "?????? ????????? ?????????????????????!",
--} end )

--L:RegisterTranslations("frFR", function() return {
--	vulnerability = "Changement de vuln??rabilit??",
--	vulnerability_desc = "Pr??viens quand la vuln??rabilit?? change.",
--	vulnerability_trigger = "%s grimace lorsque sa peau se met ?? briller.",
--	vulnerability_message = "Vulnerabilit?? : %s !",
--	vulnerability_warning = "Vuln??rabilit?? aux sorts chang??e !",
--} end )

