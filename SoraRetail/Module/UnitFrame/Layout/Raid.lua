-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local oUFAnchor = nil
local width = C.UnitFrame.Raid.Width
local height = C.UnitFrame.Raid.Height
local oldRows, maxColumns, columnSpacing = -1, 6, 8
local raidAuras, indicatorFilters = C.UnitFrame.RaidAuras, C.UnitFrame.Raid.IndicatorFilters

-- Initialize
S.UnitFrame.Raid = S.UnitFrame.Raid or {}

-- Common
local function IsHealer()
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
local function UpdateRaidDebuff(self, event, unit, ...)
	local aura = nil

	for k, v in pairs({"HELPFUL", "HARMFUL"}) do
		for i = 1, 40 do
			local name, texture, count, _, duration, expiration, _, _, _, spellID = UnitAura(unit, i, v)

			if not spellID then
				break
			end

			local priority = raidAuras[spellID]

			if priority and (not aura or priority > aura.priority) then
				aura = {}
				aura.priority = priority
				aura.count = count
				aura.texture = texture
				aura.duration = duration
				aura.expiration = expiration
			end
		end
	end

	local raidDebuff = self.RaidDebuff
	local nameTag, statusTag = self.NameTag, self.StatusTag

	if not aura then
		raidDebuff:Hide()

		nameTag:SetAlpha(1.00)
		statusTag:SetAlpha(1.00)
	else
		local count, texture, duration, expiration = aura.count, aura.texture, aura.duration, aura.expiration

		raidDebuff.icon:SetTexture(texture)
		raidDebuff.count:SetText(count > 1 and count or "")
		raidDebuff.cooldown:SetCooldown(expiration - duration, duration)

		raidDebuff:Show()

		nameTag:SetAlpha(0.25)
		statusTag:SetAlpha(0.25)
	end
end

local function CreateRaidDebuff(self, ...)
	local raidDebuff = CreateFrame("Frame", nil, self.Health)
	raidDebuff:Hide()
	raidDebuff:SetSize(20, 20)
	raidDebuff:SetPoint("CENTER", 0, 0)
	raidDebuff:SetFrameLevel(self.Health:GetFrameLevel() + 1)

	raidDebuff.icon = raidDebuff:CreateTexture(nil, "OVERLAY")
	raidDebuff.icon:SetAllPoints()
	raidDebuff.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

	raidDebuff.cooldown = CreateFrame("Cooldown", "$parentCooldown", raidDebuff, "CooldownFrameTemplate")
	raidDebuff.cooldown:SetAllPoints()
	raidDebuff.cooldown:SetFrameLevel(self.Health:GetFrameLevel() + 2)

	raidDebuff.border = S.MakeBorder(raidDebuff, 1)
	raidDebuff.border:SetFrameLevel(self.Health:GetFrameLevel() + 1)

	local parent = CreateFrame("Frame", nil, raidDebuff)
	parent:SetAllPoints()
	parent:SetFrameLevel(self.Health:GetFrameLevel() + 3)

	raidDebuff.count = S.MakeText(parent, 7)
	raidDebuff.count:SetPoint("BOTTOMRIGHT", raidDebuff, "BOTTOMRIGHT", 2, -1)

	self.RaidDebuff = raidDebuff
end

-- AuraIndicator
local function OnIndicatorUpdate(self, elapsed, ...)
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

		if expiration > 0 and durationLeft < 3.00 then
			self.icon:SetVertexColor(1.00, 0.00, 0.00)
		else
			self.icon:SetVertexColor(1.00, 1.00, 1.00)
		end
	end
end

local function UpdateAuraIndicator(self, event, unit, ...)
	local _, class = UnitClass("player")
	local indicators = self.Indicators
	local filters = indicatorFilters[class]

	for k, v in pairs({"HELPFUL", "HARMFUL"}) do
		for i = 1, 40 do
			local name, texture, count, _, duration, expiration, caster, _, _, spellID = UnitAura(unit, i, v)

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
end

local function CreateAuraIndicator(self, ...)
	local indicators = {}

	for i = 1, 6 do
		local indicator = CreateFrame("Frame", nil, self)
		indicator:Hide()
		indicator:SetSize(9, 9)

		indicator.icon = indicator:CreateTexture(nil, "OVERLAY")
		indicator.icon:SetAllPoints()
		indicator.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

		indicator.border = S.MakeBorder(indicator, 1)
		indicator.border:SetFrameLevel(indicator:GetFrameLevel() + 1)

		if i == 1 then
			indicator:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 2, 0)
		elseif i == 4 then
			indicator:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT", -2, 0)
		elseif i == 2 or i == 3 then
			indicator:SetPoint("LEFT", indicators[i - 1], "RIGHT", 2, 0)
		elseif i == 5 or i == 6 then
			indicator:SetPoint("RIGHT", indicators[i - 1], "LEFT", -2, 0)
		end

		indicators[i] = indicator
	end

	self.Indicators = indicators
end

-- ThreatIndicator
local function CreateThreatIndicator(self, ...)
	local anchor = CreateFrame("Frame", nil, self)
	anchor:SetAllPoints()
	anchor:SetFrameLevel(self.Health:GetFrameLevel() + 255)

	local function PostUpdate(indicator, unit, status, r, g, b)
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
local function CreateReadyCheckIndicator(self, ...)
	local anchor = CreateFrame("Frame", nil, self.Health)
	anchor:SetAllPoints()
	anchor:SetFrameLevel(self.Health:GetFrameLevel() + 1)

	local indicator = anchor:CreateTexture(nil, "ARTWORK")
	indicator:SetSize(16, 16)
	indicator:SetPoint("CENTER", anchor, "CENTER", 0, 0)

	self.ReadyCheckIndicator = indicator
end

-- Begin
local function SetAnchor(self, newRows, ...)
	if not oUFAnchor then
		return 0
	end

	if InCombatLockdown() then
		return 0
	end

	if oldRows > 0 and oldRows == newRows then
		return 0
	end

	oldRows = newRows
	oUFAnchor:ClearAllPoints()

	if not IsHealer() then
		oUFAnchor:SetPoint(unpack(C.UnitFrame.Raid.Postion))
	elseif oldRows < 6 then
		oUFAnchor:SetPoint(unpack(C.UnitFrame.Raid.HealerPostion))
	else
		local point, relativeTo, relativePoint, xOfs, yOfs = unpack(C.UnitFrame.Raid.HealerPostion)
		yOfs = yOfs - height * (maxColumns - oldRows - 1) - columnSpacing * (maxColumns - 1 - oldRows - 1)

		oUFAnchor:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
	end
end

local function RegisterStyle(self, unit, ...)
	self.Range = {}
	self.Range.insideAlpha = 1.00
	self.Range.outsideAlpha = 0.40

	local function OnUnitAura(self, event, unit, ...)
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

	S.UnitFrame.CreatePower(self, unit, ...)
	S.UnitFrame.CreateHealth(self, unit, ...)

	S.UnitFrame.CreateTag(self, unit, ...)
	S.UnitFrame.CreateRaidRoleIndicator(self, unit, ...)
	S.UnitFrame.CreateGroupRoleIndicator(self, unit, ...)
	S.UnitFrame.CreateRaidTargetIndicator(self, unit, ...)

	CreateRaidDebuff(self, ...)
	CreateAuraIndicator(self, ...)
	CreateThreatIndicator(self, ...)
	CreateReadyCheckIndicator(self, ...)
end

local function OnPlayerLogin(self, event, ...)
	S.KillFrame(CompactRaidFrameManager)
	S.KillFrame(CompactRaidFrameContainer)

	oUF:RegisterStyle("oUF_Sora_Raid", RegisterStyle)
	oUF:SetActiveStyle("oUF_Sora_Raid")

	oUFAnchor = CreateFrame("Frame", nil, UIParent)
	oUFAnchor:SetSize(width * 5 + 4 * columnSpacing, height * maxColumns + columnSpacing * (maxColumns - 1))

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
		table.insert(oUFArguments, "ASSIGNEDROLE")
		table.insert(oUFArguments, "groupingOrder")
		table.insert(oUFArguments, "TANK,HEALER,DAMAGER,NONE")
		table.insert(oUFArguments, "sortMethod")
		table.insert(oUFArguments, "INDEX")
		table.insert(oUFArguments, "oUF-initialConfigFunction")
		table.insert(oUFArguments, ([[ self:SetWidth(%d) self:SetHeight(%d) ]]):format(width, height))
		oUF:SpawnHeader(unpack(oUFArguments)):SetPoint("TOPLEFT", oUFAnchor, "TOPLEFT", 0, 0)
	end
end

local function OnGroupRosterUpdate(self, event, ...)
	SetAnchor(self, ceil(GetNumGroupMembers() / 5))
end

local function OnPlayerTalentUpdate(self, event, ...)
	oldRows = -1
	SetAnchor(self, ceil(GetNumGroupMembers() / 5))
end

local function OnPlayerEnteringWorld(self, event, ...)
	oldRows = -1
	SetAnchor(self, ceil(GetNumGroupMembers() / 5))
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.GROUP_ROSTER_UPDATE = OnGroupRosterUpdate
EventHandler.Event.PLAYER_TALENT_UPDATE = OnPlayerTalentUpdate
EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
EventHandler.Register()
