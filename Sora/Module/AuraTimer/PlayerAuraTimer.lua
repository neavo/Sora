-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local auras = {}
local anchor = nil
local spacing, iconSize, maxLines = 4, nil, 8
local whitelist = C.AuraTimer.WhiteList.Player

-- Begin
local OnEnter = function(self)
	if not self:IsVisible() then
		return
	end

	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
	GameTooltip:SetUnitAura(unpack(self.tooltipData))
end

local OnLeave = function(self)
	GameTooltip:Hide()
end

local UpdateAuras = function(unit)
	local data, datas = nil, {}

	for k, v in pairs({"HELPFUL", "HARMFUL"}) do
		for i = 1, 40 do
			local name, texture, count, _, duration, expiration, caster, _, _, spellID = UnitAura(unit, i, v)

			if caster == "player" and ((duration > 0 and duration < 60) or whitelist[spellID]) then
				data = {}
				data.name = name
				data.count = count
				data.caster = caster
				data.texture = texture
				data.spellID = spellID
				data.duration = duration
				data.expiration = expiration
				data.tooltipData = {unit, i, v}

				table.insert(datas, data)
			end
		end
	end

	for k, v in pairs(auras) do
		data = datas[k]

		if not data then
			v:Hide()
		else
			v.tooltipData = data.tooltipData

			v:Show()
			v.icon:SetTexture(data.texture)
			v.count:SetText(data.count > 1 and data.count or nil)
			v.cooldown:SetCooldown(data.expiration - data.duration, data.duration)
		end
	end
end

local CreateAuras = function()
	for i = 1, 8 * maxLines do
		local aura = CreateFrame("Frame", nil, anchor)
		aura:Hide()
		aura:SetSize(iconSize, iconSize)

		aura.cooldown = CreateFrame("Cooldown", "$parentCooldown", aura, "CooldownFrameTemplate")
		aura.cooldown:SetAllPoints()

		aura.icon = aura:CreateTexture("$parentIcon", "OVERLAY")
		aura.icon:SetAllPoints()
		aura.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		aura.shadow = S.MakeShadow(aura, 2)

		local countParent = CreateFrame("Frame", nil, aura)
		countParent:SetAllPoints()
		countParent:SetFrameLevel(aura.cooldown:GetFrameLevel() + 1)

		aura.count = S.MakeText(countParent, 9)
        aura.count:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", 1, -1)

		if i == 1 then
			aura:SetPoint("BOTTOMLEFT")
		elseif mod(i, 8) == 1 then
			aura:SetPoint("BOTTOM", auras[i - 8], "TOP", 0, spacing)
		else
			aura:SetPoint("LEFT", auras[i - 1], "RIGHT", spacing, 0)
		end

		aura:SetScript("OnEnter", OnEnter)
		aura:SetScript("OnLeave", OnLeave)

		table.insert(auras, aura)
	end
end

local OnUnitAura = function(self, event, unit, ...)
	if unit == "player" then
		UpdateAuras("player")
	end
end

local OnPlayerLogin = function(self, event, ...)
	iconSize = (oUF_Sora_Player:GetWidth() - spacing * (8 - 1)) / 8

	anchor = CreateFrame("Frame", "$parentAnchor", UIParent)
	anchor:SetPoint("BOTTOM", oUF_Sora_Player, "TOP", 0, 12)
	anchor:SetSize(oUF_Sora_Player:GetWidth(), iconSize * maxLines + spacing * (maxLines - 1))

	CreateAuras()
end

local OnPlayerEnteringWorld = function(self, event, isInitialLogin, isReloadingUi)
	if isInitialLogin or isReloadingUi then
		UpdateAuras("player")
	end
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.UNIT_AURA = OnUnitAura
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Event.PLAYER_ENTERING_WORLD = OnPlayerEnteringWorld
EventHandler.Register()
