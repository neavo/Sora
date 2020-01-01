-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local size = 15
local channels = {"/s ", "/y ", "/p ", "/g ", "/raid ", "/1 ", "/2 "}
local colors = {
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
local function CreateChatbar()
	local preBtn = nil

	local parent = CreateFrame("Frame", nil, UIParent)
	parent:SetSize(size * 9, size)
	parent:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 84, 6)

	local function OnEnter(self, ...)
		if InCombatLockdown() then
			self:SetAlpha(1.00)
		else
			UIFrameFadeIn(self, 0.25, 0.25, 1.00)
		end
	end

	local function OnLeave(self, ...)
		if InCombatLockdown() then
			self:SetAlpha(0.25)
		else
			UIFrameFadeOut(self, 0.25, 1.00, 0.25)
		end
	end

	for i = 1, 9 do
		local btn = nil

		if i <= 7 then
			local function OnMouseUp(self, btn, ...)
				ChatFrame_OpenChat(channels[i])
			end

			btn = CreateFrame("Button", nil, parent)
			btn:SetSize(size, size)
			btn:SetScript("OnMouseUp", OnMouseUp)
		elseif i == 8 then
			btn = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate")
			btn:SetSize(size, size)
			btn:SetAttribute("*type*", "macro")
			btn:SetAttribute("macrotext", "/roll")
		else
			btn = _G["ChatFrameChannelButton"]
			btn:ClearAllPoints()
			btn:SetSize(size + 2, size + 2)
		end

		btn:SetAlpha(0.25)
		btn:SetScript("OnEnter", OnEnter)
		btn:SetScript("OnLeave", OnLeave)

		if i <= 8 then
			btn.backgourd = CreateFrame("StatusBar", nil, btn)
			btn.backgourd:SetAllPoints()
			btn.backgourd:SetFrameLevel(UIParent:GetFrameLevel() + 2)
			btn.backgourd:SetStatusBarTexture(DB.Statusbar)
			btn.backgourd:SetStatusBarColor(unpack(colors[i]))

			btn.backgourd.shadow = S.MakeShadow(btn.backgourd, 2)
			btn.backgourd.shadow:SetFrameLevel(UIParent:GetFrameLevel() + 1)
		end

		if i == 1 then
			btn:SetPoint("TOP", parent, "TOP", 0, 0)
		else
			btn:SetPoint("RIGHT", preBtn, "LEFT", -4, 0)
		end

		preBtn = btn
	end
end

local function OnPlayerLogin(self, event, ...)
	CreateChatbar()
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
