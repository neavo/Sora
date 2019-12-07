-- Engines
local _, ns = ...
local oUF = ns.oUF or oUF
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local todo = nil

-- Begin
local function RegisterStyle(self, unit, ...)
    self:RegisterForClicks("AnyUp")
    self:SetPoint(unpack(C.UnitFrame.Player.Postion))
    self:SetSize(C.UnitFrame.Player.Width, C.UnitFrame.Player.Height)

    S.oUF.CreatePower(self, unit, ...)
    S.oUF.CreateHealth(self, unit, ...)

    S.oUF.CreateTag(self, unit, ...)
    S.oUF.CreateAuras(self, unit, ...)
    S.oUF.CreateRunes(self, unit, ...)
    S.oUF.CreateTotems(self, unit, ...)
    S.oUF.CreateCastbar(self, unit, ...)
    S.oUF.CreatePortrait(self, unit, ...)
    S.oUF.CreateClassPowers(self, unit, ...)

    S.oUF.CreateRaidRoleIndicator(self, unit, ...)
    S.oUF.CreateGroupRoleIndicator(self, unit, ...)
    S.oUF.CreateRaidTargetIndicator(self, unit, ...)
end

local function OnPlayerLogin(self, event, ...)
    oUF:RegisterStyle("oUF_Sora_Player", RegisterStyle)
    oUF:SetActiveStyle("oUF_Sora_Player")
    oUF:Spawn("player", "oUF_Sora_Player")

    PlayerPowerBarAlt:SetMovable(true)
    PlayerPowerBarAlt:SetUserPlaced(true)
    PlayerPowerBarAlt:SetFrameStrata("HIGH")

    local OnPlayerPowerBarAltMouseUp = function(self, button, ...)
        self:StopMovingOrSizing()
    end

    local OnPlayerPowerBarAltMouseDown = function(self, button, ...)
        self:StartMoving()
    end

    PlayerPowerBarAlt:SetScript("OnMouseUp", OnPlayerPowerBarAltMouseUp)
    PlayerPowerBarAlt:SetScript("OnMouseDown", OnPlayerPowerBarAltMouseDown)
end

-- EventHandler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.RegisterAllEvents()