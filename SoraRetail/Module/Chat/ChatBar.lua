-- Engine
local S, _, _, DB = unpack(select(2, ...))

-- Variables
local Channel = {"/s ", "/y ", "/p ", "/g ", "/raid ", "/1 ", "/2 "}
local Color = {
	{255 / 255, 255 / 255, 255 / 255},
	{255 / 255, 64 / 255, 64 / 255},
	{170 / 255, 170 / 255, 255 / 255},
	{64 / 255, 255 / 255, 64 / 255},
	{255 / 255, 127 / 255, 0 / 255},
	{210 / 255, 180 / 255, 140 / 255},
	{160 / 255, 120 / 255, 90 / 255},
	{255 / 255, 255 / 255, 0 / 255}
}

-- Begin
local function SetChatbar()
	local preBtn = nil
	local btnSize = 18

	local parent = CreateFrame("Frame", nil, UIParent)
	parent:SetSize(btnSize * 8, btnSize)
	parent:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 84, 4)

	for i = 1, 8 do
		local btn = nil

		if i <= 7 then
			btn = CreateFrame("Button", nil, parent)
			btn:SetScript("OnClick", function(self, event, ...)
				ChatFrame_OpenChat(Channel[i], chatFrame)
			end)
		else
			btn = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate")
			btn:SetAttribute("*type*", "macro")
			btn:SetAttribute("macrotext", "/roll")
		end

		btn:SetAlpha(0.25)
		btn:SetSize(btnSize, btnSize)

		btn:SetScript("OnEnter", function(self, event, ...)
			if not UnitAffectingCombat("player") then
				UIFrameFadeIn(self, 0.25, 0.25, 1.00)
			end
		end)
		btn:SetScript("OnLeave", function(self, event, ...)
			if not UnitAffectingCombat("player") then
				UIFrameFadeOut(self, 0.25, 1.00, 0.25)
			end
		end)

		btn:SetBackdrop({
			bgFile = DB.Statusbar,
			edgeFile = DB.GlowTex,
			insets = {left = 2, right = 2, top = 2, bottom = 2}, edgeSize = 2
		})
		btn:SetBackdropColor(unpack(Color[i]))
		btn:SetBackdropBorderColor(0, 0, 0, 1)

		if i == 1 then
			btn:SetPoint("TOP", parent, "TOP", 0, 0)
		else
			btn:SetPoint("RIGHT", preBtn, "LEFT", 0, 0)
		end

		preBtn = btn
	end
end

local function OnPlayerLogin(self, event, ...)
	SetChatbar()
end

-- Event
local Event = CreateFrame("Frame", nil, UIParent)
Event:RegisterEvent("PLAYER_LOGIN")
Event:SetScript("OnEvent",function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		OnPlayerLogin(self, event, ...)
	end
end)
