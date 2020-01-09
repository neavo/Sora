
-------------------------------------
-- 技能條超出距離紅色顯示
-------------------------------------

hooksecurefunc("ActionButton_OnUpdate", function(self, elapsed)
    if (self.rangeTimer == TOOLTIP_UPDATE_TIME) then
        local valid = IsActionInRange(self.action)
        if (valid == false) then
            self.icon:SetVertexColor(0.8, 0.1, 0.1)
        else
            ActionButton_UpdateUsable(self)
        end
    end
end)
