-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local spacing, iconSize = nil, nil

-- Begin
local function SetAuras(self, ...)
	local auras = CreateFrame("Frame", nil, self)
	auras:SetAllPoints()
	
	auras.num = 16
	auras.size = iconSize
	auras.spacing = spacing
	auras["growth-y"] = "UP"
	auras["growth-x"] = "RIGHT"
	auras.disableCooldown = false
	auras.initialAnchor = "TOPLEFT"
	
	auras.PostCreateIcon = function(self, button)
		if not button.shadow then
			button.shadow = S.MakeShadow(button, 2)
			
			button.icon:SetAllPoints()
			button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			
			button.count = S.MakeText(button, 10)
			button.count:SetPoint("BOTTOMRIGHT", 3, 0)
		end
	end
	
	auras.CustomFilter = function(self, unit, button, name, _, count, _, duration, expiration, caster, _, _, spellID, _, _, _, _, _, _, _, _)
		local flag = false
		
		if caster == "player" and duration > 0 and (duration < 60 or C.AuraTimer.WhiteList.Player[spellID]) then
			flag = true
		end
		
		return flag
	end
	
	self.Auras = auras
end

local function RegisterStyle(self, ...)    
	spacing = 4
	iconSize = (oUF_Sora_Player:GetWidth() - 4 * 7) / 8
	
	self:SetSize(oUF_Sora_Player:GetWidth(), iconSize)
	self:SetPoint("BOTTOMLEFT", oUF_Sora_Player, "TOPLEFT", 0, 12)
	
	SetAuras(self, ...)
end

local function OnPlayerLogin(self, event, ...)
	oUF:RegisterStyle("oUF_Sora_PlayerAuraTimer", RegisterStyle)
	oUF:SetActiveStyle("oUF_Sora_PlayerAuraTimer")
	
	oUF:Spawn("player", "oUF_Sora_PlayerAuraTimer")
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent", function(self, event, unit, ...)
	if event == "PLAYER_LOGIN" then
		OnPlayerLogin(self, event, ...)
	end
end)
