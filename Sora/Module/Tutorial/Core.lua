-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerLogin(self, event, ...)
    if C.Tutorial.Initialized then
        return 0
    end

    local function OnYesClick(self)
        ReloadUI()
    end

    local data = {
        title = "确认",
        detail = "感谢您的认可和使用，请点击下方按钮重新载入UI对 |cff70C0F5Sora's|r 进行初始化。",
        OnYesClick = OnYesClick
    }

    local confirm = S.CreateConfirm(UIParent, 12)
    confirm:SetData(data)
    confirm:SetConfirmWidth(512)
    confirm:SetPoint("TOP", UIParent, "TOP", 0, -256)

    SoraDBPerCharacter.Tutorial.Initialized = true
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
