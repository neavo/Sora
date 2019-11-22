
------------------
-- 队友DEBUFF顯示
------------------

hooksecurefunc("RefreshDebuffs", function(frame, unit, numDebuffs, suffix, checkCVar)
    if (SHOW_DISPELLABLE_DEBUFFS and SHOW_DISPELLABLE_DEBUFFS ~= "1") then
        return
    end
    if (not string.find(unit, "^party")) then
        return
    end
    local frameName = frame:GetName()
    local name, icon, count, debuffType, duration, expirationTime
    local debuffName, debuffIcon, debuffCooldown, debuffBorder, debuffColor
    numDebuffs = numDebuffs or MAX_PARTY_DEBUFFS
    suffix = suffix or "Debuff"
    for i = 1, numDebuffs do
        debuffName = frameName..suffix..i
        name, icon, count, debuffType, duration, expirationTime = UnitDebuff(unit, i)
        if (icon) then
            debuffIcon = _G[debuffName.."Icon"]
            debuffIcon:SetTexture(icon)
            debuffBorder = _G[debuffName.."Border"]
            debuffColor = DebuffTypeColor[debuffType] or DebuffTypeColor["none"]
            debuffBorder:SetVertexColor(debuffColor.r, debuffColor.g, debuffColor.b)
            debuffCooldown = _G[debuffName.."Cooldown"]
            if (debuffCooldown) then
                CooldownFrame_Set(debuffCooldown, expirationTime - duration, duration, duration > 0, true)
                if (duration and duration <= 60) then
                    debuffCooldown:SetHideCountdownNumbers(false)
                else
                    debuffCooldown:SetHideCountdownNumbers(true)
                end
            end
            _G[debuffName]:Show()
        else
            _G[debuffName]:Hide()
        end
    end
end)
