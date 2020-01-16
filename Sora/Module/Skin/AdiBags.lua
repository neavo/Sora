-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Common
local function Dummy()
end

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

			btn.__skined = true
			btn.border = S.MakeBorder(btn, 1)
			btn.border:SetFrameLevel(btn:GetFrameLevel() + 1)

			local p = C.Core.Pixel or 1.00
			count:SetPoint("BOTTOMRIGHT", 0, 0)
			count:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
			count:SetShadowOffset(1.00 * p, -1.00 * p)
			count:SetShadowColor(0.00, 0.00, 0.00, 0.50)

			icon.__SetTexCoord = icon.SetTexCoord
			icon.SetTexCoord = Dummy

			S.KillFrame(normalTex)
			S.KillFrame(iconQuestTex)
		end

		local border = btn.border
		local link = GetContainerItemLink(btn.bag or 999, btn.slot or 999)

		if not link then
			icon:__SetTexCoord(0.25, 0.75, 0.25, 0.75)
			border:SetBackdropBorderColor(1.00, 1.00, 1.00, 1.00)
		else
			local _, _, color = string.find(link, "|?c?f?f?(%x*)|?H?")
			local r, g, b = S.HexToRGB(color)

			icon:__SetTexCoord(0.08, 0.92, 0.08, 0.92)
			border:SetBackdropBorderColor(r, g, b, 1.00)
		end
	end
end

local function SkinBag()
	DoSkin(1)
end

local function SkinBank()
	DoSkin(2)
end

-- Event
local function OnBagUpdate(self, event, ...)
	if not IsAddOnLoaded("AdiBags") then
		return 0
	end

	C_Timer.NewTicker(0.25, SkinBag, 1)
	C_Timer.NewTicker(0.25, SkinBank, 1)
end

local function OnPlayerLogin(self, event, ...)
	if not IsAddOnLoaded("AdiBags") then
		return 0
	end

	local datas = {
		"AdiBagsContainer1",
		"AdiBagsContainer2"
	}

	for k, v in pairs(datas) do
		local function OnShowSkin()
			DoSkin(k)
		end

		local function OnShow(self, ...)
			C_Timer.NewTicker(0.25, OnShowSkin, 1)
		end

		local function OnTicker(self, ...)
			local container = _G[v]

			if not container then
				return 0
			end

			self:Cancel()

			container.shadow = S.MakeShadow(container, 2)
			container.shadow:SetFrameLevel(container:GetFrameLevel())

			DoSkin(k)
			container:HookScript("OnShow", OnShow)
		end

		C_Timer.NewTicker(1.00, OnTicker)
	end
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.BAG_UPDATE = OnBagUpdate
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
