-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local buttons = {}

-- Event
local function OnTradeSkillShow(self, event, ...)
	local datas = {}
	local professions = {GetProfessions()}

	for k, v in pairs(professions) do
		local name, icon, _, _, _, spelloffset = GetProfessionInfo(v)

		local data = {}
		data.icon = icon
		data.spelloffset = spelloffset

		table.insert(datas, data)
	end

	for k, v in pairs(datas) do
		local button = S.CreateButton(TradeSkillFrame, 20)
		button:SetSize(36, 36)
		button:SetFrameLevel(TradeSkillFrame:GetFrameLevel())

		button.icon = button:CreateTexture(nil, "ARTWORK")
		button.icon:SetSize(36, 36)
		button.icon:SetPoint("CENTER", button, "CENTER", 0, 0)
		button.icon:SetTexture(v.icon)
		button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

		local function OnClick(self, btn, ...)
			CastSpell(v.spelloffset + 1, BOOKTYPE_PROFESSION)
		end

		button:HookScript("OnClick", OnClick)

		if k == 1 then
			button:SetPoint("TOPLEFT", TradeSkillFrame, "TOPRIGHT", 8, 0)
		else
			button:SetPoint("TOPLEFT", TradeSkillFrame, "TOPRIGHT", 8, -(35 + 8) * (k - 1))
		end

		table.insert(buttons, button)
	end
end

local function OnTradeSkillClose(self, event, ...)
	for k, v in pairs(buttons) do
		S.KillFrame(v)
	end

	table.wipe(buttons)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.TRADE_SKILL_SHOW = OnTradeSkillShow
EventHandler.Event.TRADE_SKILL_CLOSE = OnTradeSkillClose
EventHandler.Register()
