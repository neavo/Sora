-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function Dummy()
end

local function HookDBTCreateBar(self, ...)
	for v in self:GetBarIterator() do
		if not v.__skined then
			local frame = v.frame
			local bar = _G[frame:GetName() .. "Bar"]
			local spark = _G[frame:GetName() .. "BarSpark"]
			local icon1 = _G[frame:GetName() .. "BarIcon1"]
			local icon2 = _G[frame:GetName() .. "BarIcon2"]
			local name = _G[frame:GetName() .. "BarName"]
			local timer = _G[frame:GetName() .. "BarTimer"]

			bar.shadow = S.MakeShadow(bar, 2)
			bar:SetStatusBarTexture(DB.Statusbar)
			bar.SetStatusBarTexture = Dummy

			icon1:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			icon1.shadow = S.MakeTextureShadow(icon1:GetParent(), icon1, 2)

			icon2:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			icon2.shadow = S.MakeTextureShadow(icon2:GetParent(), icon2, 2)

			v.__skined = true
		end
	end
end

local function OnPlayerLogin(self, event, ...)
	if not IsAddOnLoaded("DBM-Core") then
		return 0
	end

	hooksecurefunc(DBT, "CreateBar", HookDBTCreateBar)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
