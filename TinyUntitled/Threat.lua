
----------------------
-- 名条tank仇恨颜色
----------------------

-- UnitThreatSituation("player", unit) or 0

local ThreatReference = {
    [0] = "LOW",
    [1] = "MEDIUM",
    [2] = "MEDIUM",
    [3] = "HIGH",
}

local Plates = {}

local function ColorPlatebar(plate, threat)
    plate.healthBar:SetVertexColor(1,1,1,1)
    print(plate:GetName())
end
    
local frame = CreateFrame("Frame", nil, UIParent)
--frame:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
--frame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
--frame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
--frame:RegisterEvent("NAME_PLATE_CREATED")
--frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", function(self, event, ...)
    local unit = ...
    local plate = C_NamePlate.GetNamePlateForUnit(unit)
    if (event == "UNIT_THREAT_SITUATION_UPDATE") then
        if (plate) then
            
        end
    end
    if (event == "NAME_PLATE_UNIT_ADDED") then
        if not UnitIsUnit("player", unit) then 
            Plates[plate] = unit
            ColorPlatebar(plate)
        end
    end
    if (event == "NAME_PLATE_UNIT_REMOVED") then
        Plates[plate] = nil
    end
end)

