-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Begin
local function OnPlayerEnteringWorld(self, ...)
    if not UnitAffectingCombat("player") then
        self.timer = 0
        UIParent:SetAlpha(0)
        
        self:SetScript("OnUpdate", function(self, elasped)
            self.timer = self.timer + elasped
            
            if self.timer > 1.5 then
                self:SetScript("OnUpdate", nil)
                
                if not UnitAffectingCombat("player") then
                    UIFrameFadeIn(UIParent, 1.00, 0.00, 1.00)
                end
            end
        end)
    end
end

-- Event
local Event = CreateFrame("Frame")
Event:RegisterEvent("PLAYER_ENTERING_WORLD")
Event:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        OnPlayerEnteringWorld(self, ...)
    end
end)
