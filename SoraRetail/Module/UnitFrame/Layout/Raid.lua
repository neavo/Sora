-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local mapId = -1
local maxAuras = 64
local raidAuras = C.UnitFrame.RaidAuras

-- Begin
local function IsHealer()
    local _, class = UnitClass("player")
    local specialization = GetSpecialization()
    
    local result = false
        or
        (class == "MONK" and specialization == 2)
        or
        (class == "DRUID" and specialization == 4)
        or
        (class == "SHAMAN" and specialization == 3)
        or
        (class == "PALADIN" and specialization == 1)
        or
        (class == "PRIEST" and (specialization == 1 or specialization == 2))
    
    return result
end

local function UpdateIndicator(self, event, unit, ...)
	local auras = {}
	local _, class = UnitClass("player")
	
	for i = 1, maxAuras do
		local name, texture, count, _, duration, expiration, caster, _, _, spellID = UnitAura(unit, i)
		
		if not C.UnitFrame.Raid.IndicatorFilters[class] then
			break
		end 

		if not spellID or caster ~= "player" or #C.UnitFrame.Raid.IndicatorFilters[class] == 0 then
			break
		end
		
		for i = 1, #self.Indicators do
			if spellID == C.UnitFrame.Raid.IndicatorFilters[class][i] then
				auras[i] = {
					show = true,
					texture = texture,
					duration = duration, expiration = expiration,
				}
			elseif not auras[i] then
				auras[i] = {
					show = false,
					texture = nil,
					duration = 0, expiration = 0,
				}
			end
		end
	end
	
	for i = 1, #self.Indicators do
		local aura = auras[i]
		local indicator = self.Indicators[i]
		
		if aura and aura.show then
			indicator:Show()
			indicator.shadow:Show()
			indicator.icon:SetTexture(aura.texture)
			
			indicator.duration = aura.duration
			indicator.expiration = aura.expiration
			
			indicator.timer = 0
			indicator:SetScript("OnUpdate", function(self, elapsed, ...)
				self.timer = self.timer + elapsed
				
				if self.timer > 0.10 then
					self.timer = 0
					
					if indicator.expiration > 0 and (indicator.expiration - GetTime() < indicator.duration * 0.3) then
						indicator.icon:SetVertexColor(1.00, 0.00, 0.00)
					else
						indicator.icon:SetVertexColor(1.00, 1.00, 1.00)
					end
				end
			end)
		else
			indicator:Hide()
			indicator:SetScript("OnUpdate", nil)
		end
	end
end

local function UpdateRaidDebuff(self, event, unit, ...)
	local auras = {}
	
	for i = 1, maxAuras do
		local name, texture, count, _, duration, expiration, caster, _, _, spellID = UnitAura(unit, i)

		if not spellID then
			break
		end

		local priority = raidAuras[spellID]
		
		if priority then
			table.insert(auras, {
				priority = priority,
				count = count, texture = texture,
				duration = duration, expiration = expiration,
			})
		end
	end
	
	table.sort(auras, function(l, r)
		return l.priority < r.priority
	end)
	
	if #auras == 0 then
		self.RaidDebuff:Hide()
		self.NameTag:SetAlpha(1.00)
		self.StatusTag:SetAlpha(1.00)
	else
		local aura = auras[1]
		local count, texture, duration, expiration = aura.count, aura.texture, aura.duration, aura.expiration
		
		if count and count > 0 then
			self.RaidDebuff.count:SetText(count)
		end
		
		self.RaidDebuff.icon:SetTexture(texture)
		self.RaidDebuff.cooldown:SetCooldown(expiration - duration, duration)
		
		self.RaidDebuff:Show()
		self.NameTag:SetAlpha(0.25)
		self.StatusTag:SetAlpha(0.25)
	end
end

local function OnUnitAura(self, event, unit, ...)
	if self.unit ~= unit then
		return
	end
	
	UpdateIndicator(self, event, unit, ...)
	UpdateRaidDebuff(self, event, unit, ...)
end

local function SetAnchor(self, ...)
	if oUF_Sora_Raid_Anchor and not UnitAffectingCombat("player") then
		oUF_Sora_Raid_Anchor:ClearAllPoints()
		if not IsHealer() then
			oUF_Sora_Raid_Anchor:SetPoint(unpack(C.UnitFrame.Raid.Postion))
		else
			oUF_Sora_Raid_Anchor:SetPoint(unpack(C.UnitFrame.Raid.HealerPostion))
		end
	end
end

local function SetThreatIndicator(self, ...)
	local anchor = CreateFrame("Frame", nil, self)
	anchor:SetAllPoints()
	anchor:SetFrameLevel(self.Health:GetFrameLevel() + 1)
	
	local indicator = anchor:CreateTexture(nil, "ARTWORK")
	indicator.PostUpdate = function(indicator, unit, status, r, g, b)
		local alpha = 1.00

		if status and status > 1 then
			alpha = 0.75
		else
			r, g, b = 0.00, 0.00, 0.00
		end
		
		self.Power.shadow:SetBackdropBorderColor(r, g, b, alpha)
		self.Health.shadow:SetBackdropBorderColor(r, g, b, alpha)
	end
	
	self.ThreatIndicator = indicator
end

local function SetAuraIndicator(self, ...)
	local indicators = {}
	
	for i = 1, 6 do
		local indicator = CreateFrame("Frame", nil, self)
		indicator:Hide()
		indicator:SetSize(8, 8)
		indicator:SetFrameStrata("HIGH")
		
		indicator.icon = indicator:CreateTexture(nil, "OVERLAY")
		indicator.icon:SetAllPoints()
		indicator.shadow = S.MakeShadow(indicator, 1)
		
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

local function SetRaidDebuff(self, ...)
	local raidDebuff = CreateFrame("Frame", nil, self.Health)
	raidDebuff:Hide()
	raidDebuff:SetSize(20, 20)
	raidDebuff:SetFrameStrata("HIGH")
	raidDebuff:SetPoint("CENTER", 0, 0)
	
	raidDebuff.cooldown = CreateFrame("Cooldown", "$parentCooldown", raidDebuff, "CooldownFrameTemplate")
	raidDebuff.cooldown:SetAllPoints()
	
	raidDebuff.icon = raidDebuff:CreateTexture(nil, "OVERLAY")
	raidDebuff.icon:SetAllPoints()
	
	raidDebuff.count = S.MakeText(raidDebuff, 8)
	raidDebuff.count:SetPoint("BOTTOMRIGHT", raidDebuff, "BOTTOMRIGHT", 1, 1)
	
	raidDebuff.shadow = S.MakeShadow(raidDebuff, 1)
	
	self.RaidDebuff = raidDebuff
end

local function SetCompactRaidFrame(self, ...)
	if not UnitAffectingCombat("player") then
		CompactRaidFrameManager:UnregisterAllEvents()
		CompactRaidFrameManager.Show = function() end
		CompactRaidFrameManager:Hide()
		
		CompactRaidFrameContainer:UnregisterAllEvents()
		CompactRaidFrameContainer.Show = function() end
		CompactRaidFrameContainer:Hide()
	end
end

local function SetReadyCheckIndicator(self, ...)
	local anchor = CreateFrame("Frame", nil, self.Health)
	anchor:SetAllPoints()
	anchor:SetFrameLevel(self.Health:GetFrameLevel() + 1)
	
	local indicator = anchor:CreateTexture(nil, "ARTWORK")
	indicator:SetSize(16, 16)
	indicator:SetPoint("CENTER", anchor, "CENTER", 0, 0)
	
	self.ReadyCheckIndicator = indicator
end

local function RegisterStyle(self, unit, ...)
	self.Range = {
		insideAlpha = 1.00,
		outsideAlpha = 0.40,
	}
	self:RegisterForClicks("AnyUp")
	self:RegisterEvent("UNIT_AURA", OnUnitAura)
	self:SetScript("OnEnter", UnitFrame_OnEnter)
    self:SetScript("OnLeave", UnitFrame_OnLeave)

	S.oUF.CreatePower(self, unit, ...)
	S.oUF.CreateHealth(self, unit, ...)

	S.oUF.CreateTag(self, unit, ...)
	S.oUF.CreateGroupRoleIndicator(self, unit, ...)
	S.oUF.CreateRaidRoleIndicator(self, unit, ...)
	S.oUF.CreateRaidTargetIndicator(self, unit, ...)

	SetAnchor(self, ...)
	SetThreatIndicator(self, ...)
	SetAuraIndicator(self, ...)
	SetRaidDebuff(self, ...)
	-- SetCompactRaidFrame(self, ...)
	SetReadyCheckIndicator(self, ...)
end

local function OnPlayerLogin(self, event, ...)
	oUF:RegisterStyle("oUF_Sora_Raid", RegisterStyle)
	oUF:SetActiveStyle("oUF_Sora_Raid")
	
	local width = C.UnitFrame.Raid.Width
	local height = C.UnitFrame.Raid.Height
	local anchor = CreateFrame("Frame", "oUF_Sora_Raid_Anchor", UIParent)
	anchor:SetSize(width * 5 + 8 * 4, height * 6 + 8 * 5)

	local frame = oUF:SpawnHeader("oUF_Sora_Raid", nil, "raid,party,solo",
		"showSolo", true, "showRaid", true, "showParty", true, "showPlayer", true,
		"xoffset", 8, "yoffset", -8,
		"sortMethod", "INDEX", "point", "LEFT",
		"groupBy", "GROUP", "groupFilter", "1,2,3,4,5,6", "groupingOrder", "1,2,3,4,5,6",
		"maxColumns", 6, "columnSpacing", 8, "unitsPerColumn", 5, "columnAnchorPoint", "TOP",
		"oUF-initialConfigFunction", ([[ self:SetWidth(%d) self:SetHeight(%d) ]]):format(width, height)
	)
	frame:SetPoint("TOPLEFT", anchor, "TOPLEFT", 0, 0)
end

local function OnPlayerTalentUpdate(self, event, ...)
	SetAnchor(self, ...)
end

local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:RegisterEvent("PLAYER_TALENT_UPDATE")
Event:RegisterEvent("PLAYER_ENTERING_WORLD")
Event:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		OnPlayerLogin(self, event, ...)
	elseif event == "PLAYER_TALENT_UPDATE" then
		OnPlayerTalentUpdate(self, event, ...)
	end
end)
