-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local maxAuras = 64
local width = C.UnitFrame.Raid.Width
local height = C.UnitFrame.Raid.Height
local groupNum, maxColumns, columnSpacing = -1, 6, 8
local raidAuras, indicatorFilters = C.UnitFrame.RaidAuras, C.UnitFrame.Raid.IndicatorFilters

-- Common
local IsHealer = function()
	local _, class = UnitClass("player")
	local specialization = GetSpecialization()

	local result =
		(class == "MONK" and specialization == 2) or (class == "DRUID" and specialization == 4) or
		(class == "SHAMAN" and specialization == 3) or
		(class == "PALADIN" and specialization == 1) or
		(class == "PRIEST" and (specialization == 1 or specialization == 2))

	return result
end

-- RaidDebuff
local SortPriority = function(l, r)
	return l.priority < r.priority
end

local UpdateRaidDebuff = function(self, event, unit, ...)
	local auras = {}

	for i = 1, maxAuras do
		local name, texture, count, _, duration, expiration, _, _, _, spellID = UnitAura(unit, i)

		if not spellID then
			break
		end

		local priority = raidAuras[spellID]

		if priority then
			local aura = {}
			aura.priority = priority
			aura.count = count
			aura.texture = texture
			aura.duration = duration
			aura.expiration = expiration

			table.insert(auras, aura)
		end
	end

	local raidDebuff = self.RaidDebuff
	local nameTag, statusTag = self.NameTag, self.StatusTag

	if #auras == 0 then
		raidDebuff:Hide()

		nameTag:SetAlpha(1.00)
		statusTag:SetAlpha(1.00)
	else
		table.sort(auras, SortPriority)

		local aura = auras[1]
		local count, texture, duration, expiration = aura.count, aura.texture, aura.duration, aura.expiration

		raidDebuff.icon:SetTexture(texture)
		raidDebuff.count:SetText((count and count > 0) and count or "")
		raidDebuff.cooldown:SetCooldown(expiration - duration, duration)

		raidDebuff:Show()

		nameTag:SetAlpha(0.25)
		statusTag:SetAlpha(0.25)
	end
end

local CreateRaidDebuff = function(self, ...)
	local raidDebuff = CreateFrame("Frame", nil, self.Health)
	raidDebuff:Hide()
	raidDebuff:SetSize(20, 20)
	raidDebuff:SetFrameStrata("HIGH")
	raidDebuff:SetPoint("CENTER", 0, 0)

	raidDebuff.cooldown = CreateFrame("Cooldown", "$parentCooldown", raidDebuff, "CooldownFrameTemplate")
	raidDebuff.cooldown:SetAllPoints()

	raidDebuff.icon = raidDebuff:CreateTexture(nil, "OVERLAY")
	raidDebuff.icon:SetAllPoints()
	raidDebuff.shadow = S.MakeShadow(raidDebuff, 2)

	raidDebuff.count = S.MakeText(raidDebuff, 8)
	raidDebuff.count:SetPoint("BOTTOMRIGHT", raidDebuff, "BOTTOMRIGHT", 1, 1)

	self.RaidDebuff = raidDebuff
end

-- AuraIndicator
local OnIndicatorUpdate = function(self, elapsed, ...)
	self.timer = self.timer + elapsed

	if self.timer > 0.50 then
		self.timer = 0

		local duration = self.duration
		local expiration = self.expiration
		local durationLeft = self.expiration - GetTime()

		if expiration <= 0 or durationLeft < 0 then
			self:Hide()
			self:SetScript("OnUpdate", nil)

			return 0
		end

		if expiration > 0 and durationLeft < duration * 0.30 then
			self.icon:SetVertexColor(1.00, 0.00, 0.00)
		else
			self.icon:SetVertexColor(1.00, 1.00, 1.00)
		end
	end
end

local UpdateAuraIndicator = function(self, event, unit, ...)
	local _, class = UnitClass("player")

	for i = 1, maxAuras do
		local indicators = self.Indicators
		local filters = indicatorFilters[class]
		local _, texture, count, _, duration, expiration, caster, _, _, spellID = UnitAura(unit, i)

		if not filters or #filters == 0 or not spellID or caster ~= "player" then
			break
		end

		for k, indicator in pairs(indicators) do
			local filter = filters[k]

			if filter == spellID then
				indicator:Show()
				indicator.icon:SetTexture(texture)

				indicator.duration = duration
				indicator.expiration = expiration

				indicator.timer = 0
				indicator:SetScript("OnUpdate", OnIndicatorUpdate)
			end
		end
	end
end

local CreateAuraIndicator = function(self, ...)
	local indicators = {}

	for i = 1, 6 do
		local indicator = CreateFrame("Frame", nil, self)
		indicator:Hide()
		indicator:SetSize(8, 8)
		indicator:SetFrameLevel(self.Health:GetFrameLevel() + 254)

		indicator.icon = indicator:CreateTexture(nil, "OVERLAY")
		indicator.icon:SetAllPoints()
		indicator.shadow = S.MakeShadow(indicator, 2)

		if i == 1 then
			indicator:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 2.5, 2.0)
		elseif i == 4 then
			indicator:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT", -2.5, 2.0)
		elseif i == 2 or i == 3 then
			indicator:SetPoint("LEFT", indicators[i - 1], "RIGHT", 2.0, 0.0)
		elseif i == 5 or i == 6 then
			indicator:SetPoint("RIGHT", indicators[i - 1], "LEFT", -2.0, 0.0)
		end

		indicators[i] = indicator
	end

	self.Indicators = indicators
end

-- ThreatIndicator
local CreateThreatIndicator = function(self, ...)
	local anchor = CreateFrame("Frame", nil, self)
	anchor:SetAllPoints()
	anchor:SetFrameLevel(self.Health:GetFrameLevel() + 255)

	local PostUpdate = function(indicator, unit, status, r, g, b)
		local alpha = 1.00

		if status and status > 1 then
			alpha = 0.75
		else
			r, g, b = 0.00, 0.00, 0.00
		end

		self.Power.shadow:SetBackdropBorderColor(r, g, b, alpha)
		self.Health.shadow:SetBackdropBorderColor(r, g, b, alpha)
	end

	local indicator = anchor:CreateTexture(nil, "ARTWORK")
	indicator.PostUpdate = PostUpdate

	self.ThreatIndicator = indicator
end

-- ReadyCheckIndicator
local CreateReadyCheckIndicator = function(self, ...)
	local anchor = CreateFrame("Frame", nil, self.Health)
	anchor:SetAllPoints()
	anchor:SetFrameLevel(self.Health:GetFrameLevel() + 1)

	local indicator = anchor:CreateTexture(nil, "ARTWORK")
	indicator:SetSize(16, 16)
	indicator:SetPoint("CENTER", anchor, "CENTER", 0, 0)

	self.ReadyCheckIndicator = indicator
end

local SetAnchor = function(self, ...)
	if not oUF_Sora_Raid_Anchor then
		return 0
	end

	oUF_Sora_Raid_Anchor:ClearAllPoints()

	if not IsHealer() then
		oUF_Sora_Raid_Anchor:SetPoint(unpack(C.UnitFrame.Raid.Postion))
	elseif groupNum < 0 or groupNum >= 6 then
		oUF_Sora_Raid_Anchor:SetPoint(unpack(C.UnitFrame.Raid.HealerPostion))
	else
		local point, relativeTo, relativePoint, xOfs, yOfs = unpack(C.UnitFrame.Raid.HealerPostion)
		yOfs = yOfs - height * (maxColumns - groupNum - 1) - columnSpacing * (maxColumns - 1 - groupNum - 1)

		oUF_Sora_Raid_Anchor:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
	end
end

local SetCompactRaidFrame = function(self, ...)
	local HideCompactRaidFrame = function()
		if UnitAffectingCombat("player") then
			return
		end

		local isShown = CompactRaidFrameManager_GetSetting("IsShown")
		if isShown and isShown ~= "0" then
			CompactRaidFrameManager_SetSetting("IsShown", "0")
		end

		S.KillFrame(CompactRaidFrameManager)
	end

	if CompactRaidFrameManager_UpdateShown then
		hooksecurefunc("CompactRaidFrameManager_UpdateShown", HideCompactRaidFrame)
	end

	CompactRaidFrameManager:HookScript("OnShow", HideCompactRaidFrame)
	CompactRaidFrameContainer:UnregisterAllEvents()
end

-- Begin
local RegisterStyle = function(self, unit, ...)
	self.Range = {}
	self.Range.insideAlpha = 1.00
	self.Range.outsideAlpha = 0.40

	local OnUnitAura = function(self, event, unit, ...)
		if self.unit ~= unit then
			return
		end

		UpdateRaidDebuff(self, event, unit, ...)
		UpdateAuraIndicator(self, event, unit, ...)
	end

	self:RegisterForClicks("AnyUp")
	self:RegisterEvent("UNIT_AURA", OnUnitAura)
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	S.oUF.CreatePower(self, unit, ...)
	S.oUF.CreateHealth(self, unit, ...)

	S.oUF.CreateTag(self, unit, ...)
	S.oUF.CreateRaidRoleIndicator(self, unit, ...)
	S.oUF.CreateGroupRoleIndicator(self, unit, ...)
	S.oUF.CreateRaidTargetIndicator(self, unit, ...)

	CreateRaidDebuff(self, ...)
	CreateAuraIndicator(self, ...)
	CreateThreatIndicator(self, ...)
	CreateReadyCheckIndicator(self, ...)

	SetAnchor(self, ...)
	SetCompactRaidFrame(self, ...)
end

local OnPlayerLogin = function(self, event, ...)
	oUF:RegisterStyle("oUF_Sora_Raid", RegisterStyle)
	oUF:SetActiveStyle("oUF_Sora_Raid")

	local anchor = CreateFrame("Frame", "oUF_Sora_Raid_Anchor", UIParent)
	anchor:SetSize(width * 5 + 4 * columnSpacing, height * maxColumns + columnSpacing * (maxColumns - 1))

	do
		local oUFArguments = {}
		table.insert(oUFArguments, "oUF_Sora_Raid")
		table.insert(oUFArguments, "SecureGroupHeaderTemplate")
		table.insert(oUFArguments, "solo,party,raid")
		table.insert(oUFArguments, "point")
		table.insert(oUFArguments, "LEFT")
		table.insert(oUFArguments, "xoffset")
		table.insert(oUFArguments, 8)
		table.insert(oUFArguments, "yoffset")
		table.insert(oUFArguments, -8)
		table.insert(oUFArguments, "maxColumns")
		table.insert(oUFArguments, maxColumns)
		table.insert(oUFArguments, "columnSpacing")
		table.insert(oUFArguments, columnSpacing)
		table.insert(oUFArguments, "unitsPerColumn")
		table.insert(oUFArguments, 5)
		table.insert(oUFArguments, "columnAnchorPoint")
		table.insert(oUFArguments, "TOP")
		table.insert(oUFArguments, "showSolo")
		table.insert(oUFArguments, true)
		table.insert(oUFArguments, "showRaid")
		table.insert(oUFArguments, true)
		table.insert(oUFArguments, "showParty")
		table.insert(oUFArguments, true)
		table.insert(oUFArguments, "showPlayer")
		table.insert(oUFArguments, true)
		table.insert(oUFArguments, "groupBy")
		table.insert(oUFArguments, "GROUP")
		table.insert(oUFArguments, "groupingOrder")
		table.insert(oUFArguments, "1,2,3,4,5,6,7,8")
		table.insert(oUFArguments, "sortMethod")
		table.insert(oUFArguments, "INDEX")
		table.insert(oUFArguments, "oUF-initialConfigFunction")
		table.insert(oUFArguments, ([[ self:SetWidth(%d) self:SetHeight(%d) ]]):format(width, height))
		oUF:SpawnHeader(unpack(oUFArguments)):SetPoint("TOPLEFT", anchor, "TOPLEFT", 0, 0)
	end
end

local OnGroupRosterUpdate = function(self, event, ...)
	local newNum = ceil(GetNumGroupMembers() / 5)

	if groupNum > 0 and groupNum ~= newNum then
		SetAnchor(self, ...)
	end

	groupNum = newNum
end

local OnPlayerTalentUpdate = function(self, event, ...)
	SetAnchor(self, ...)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.GROUP_ROSTER_UPDATE = OnGroupRosterUpdate
EventHandler.Event.PLAYER_TALENT_UPDATE = OnPlayerTalentUpdate
EventHandler.RegisterAllEvents()
