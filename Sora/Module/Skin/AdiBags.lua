-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local bags = {
	"AdiBagsContainer1",
	"AdiBagsContainer2"
}

local function DoSkin(i)
	local prefix = ""

	if i == 1 then
		prefix = "AdiBagsItemButton"
	elseif i == 2 then
		prefix = "AdiBagsBankItemButton"
	end

	for i = 1, 999 do
		local btn = _G[prefix .. i]

		if not btn then
			break
		end

		local icon = btn.IconTexture

		if not btn.__skined then
			local count = btn.Count
			local normalTex = btn.NormalTexture
			local iconQuestTex = btn.IconQuestTexture

			icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

			btn.__skined = true
			btn.border = S.MakeBorder(btn, 1)
			btn.border:SetFrameLevel(btn:GetFrameLevel() + 1)

			local p = C.Core.Pixel or 1.00
			count:SetPoint("BOTTOMRIGHT", 0, 0)
			count:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
			count:SetShadowOffset(1.00 * p, -1.00 * p)
			count:SetShadowColor(0.00, 0.00, 0.00, 0.50)

			S.KillFrame(normalTex)
			S.KillFrame(iconQuestTex)
		end

		local border = btn.border
		local link = GetContainerItemLink(btn.bag or 999, btn.slot or 999)

		if not link then
			icon:SetColorTexture(0.15, 0.15, 0.15, 0.85)
			border:SetBackdropBorderColor(1.00, 1.00, 1.00, 1.00)
		else
			local _, _, color = string.find(link, "|?c?f?f?(%x*)|?H?")
			local r, g, b = S.HexToRGB(color)

			border:SetBackdropBorderColor(r, g, b, 1.00)
		end
	end
end

local function CheckAdiBagsContainer(k, v)
	local function OnTicker(self, ...)
		local bag = _G[v]

		if not bag then
			return 0
		end

		local function OnShowDoSkin()
			DoSkin(k)
		end

		local function OnShow(self, ...)
			C_Timer.After(1 / 30, OnShowDoSkin)
		end

		bag.shadow = S.MakeShadow(bag, 2)
		bag.shadow:SetFrameLevel(bag:GetFrameLevel())
		bag:HookScript("OnShow", OnShow)

		OnShow()
		self:Cancel()
	end

	C_Timer.NewTicker(1 / 30, OnTicker, nil)
end

local function OnPlayerLogin(self, event, ...)
	if not IsAddOnLoaded("AdiBags") then
		return 0
	end

	for k, v in pairs(bags) do
		CheckAdiBagsContainer(k, v)
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
