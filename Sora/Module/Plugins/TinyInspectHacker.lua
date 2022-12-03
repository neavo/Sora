-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local LibEvent = nil

-- Common
local function OnItemLevelFrameShown(self, frame, parent, category, ...)
    if (TinyInspectDB and not TinyInspectDB["EnableItemLevel" .. category]) then
        return frame:Hide()
    end

    if (TinyInspectDB and TinyInspectDB.PaperDollItemLevelOutsideString) then
        return 0
    end

    frame.slotString:SetPoint("BOTTOM", 0, 2)
    frame.slotString:SetWidth(frame:GetWidth())
    frame.slotString:SetJustifyH("CENTER")
    frame.slotString:SetShadowOffset(1.00, -1.00)
    frame.slotString:SetShadowColor(0.00, 0.00, 0.00, 1.00)
    frame.slotString:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")

    frame.levelString:SetPoint("TOP", 0, -2)
    frame.levelString:SetShadowOffset(1.00, -1.00)
    frame.levelString:SetShadowColor(0.00, 0.00, 0.00, 1.00)
    frame.levelString:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
end

-- Event
local function OnInitialize(self, event, ...)
    if not IsAddOnLoaded("TinyInspect") then
        return 0
    end

    LibEvent = LibStub:GetLibrary("LibEvent.7000")
end

local function OnPlayerLogin(self, event, ...)
    if not LibEvent then
        return 0
    end

    LibEvent:attachTrigger("ITEMLEVEL_FRAME_SHOWN", OnItemLevelFrameShown)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.INITIALIZE = OnInitialize
EventHandler.Event.PLAYER_LOGIN = OnPlayerLogin
EventHandler.Register()
