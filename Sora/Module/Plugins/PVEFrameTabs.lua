-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local icon = "Interface\\Icons\\Item_Shop_GiftBox01"
local initialized = false

-- Event
local function HookPVEFrameOnShow(self, ...)
	if initialized then
		return 0
	end

	local button = S.CreateButton(PVEFrame, 20)
	button:SetSize(36, 36)
	button:SetPoint("TOPLEFT", PVEFrame, "TOPRIGHT", 8, 0)
	button:SetFrameLevel(PVEFrame:GetFrameLevel())

	button.icon = button:CreateTexture(nil, "ARTWORK")
	button.icon:SetSize(32, 32)
	button.icon:SetPoint("CENTER", button, "CENTER", 0, 0)
	button.icon:SetTexture(icon)
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

	local function OnEnter(self, ...)
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
		GameTooltip:AddLine("查看宏伟宝库奖励", 0.90, 0.90, 0.90)
		GameTooltip:Show()
	end

	local function OnLeave(self, event, ...)
		GameTooltip:Hide()
	end

	local function OnClick(self, btn, ...)
		if InCombatLockdown() then
			return 0
		end

		if not WeeklyRewardsFrame then
			LoadAddOn("Blizzard_WeeklyRewards")
		end

		ToggleFrame(WeeklyRewardsFrame)
	end
	
	button:HookScript("OnEnter", OnEnter)
	button:HookScript("OnLeave", OnLeave)
	button:HookScript("OnClick", OnClick)

	initialized = true
end

local function OnPlayerLogin(self, event, ...)
	hooksecurefunc("PVEFrame_OnShow", HookPVEFrameOnShow)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
