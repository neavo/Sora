
----------------------
-- 好友面板職業染色
----------------------

local classes = {}

do
    local localClass, class
    for i = 1, GetNumClasses() do
        localClass, class = GetClassInfo(i)
        classes[localClass] = class
    end
end

local pattern = "|cff%02x%02x%02x%s|r |c%s%s|r"

hooksecurefunc("FriendsFrame_UpdateFriendButton", function(button)
    if (not button:IsShown()) then return end
    if (not button.bname) then
        button.bname = button:CreateFontString(nil, "ARTWORK", "FriendsFont_Normal")
        button.bname:SetPoint("TOPRIGHT", -52, -5)
        button.bname:SetJustifyH("RIGHT")
    end
    button.bname:SetText("")
    if (button.buttonType == FRIENDS_BUTTON_TYPE_WOW) then
        local name, level, class, _, connected = GetFriendInfo(button.id)
        if (connected) then
            local color = GetCreatureDifficultyColor(level)
            button.name:SetFormattedText(pattern, color.r*255, color.g*255, color.b*255, level, select(4,GetClassColor(classes[class])), name)
        end
    elseif (button.buttonType == FRIENDS_BUTTON_TYPE_BNET) then
        local _, accountName, _, _, _, bnetIDGameAccount, client, isOnline = BNGetFriendInfo(button.id)
        if (isOnline and client == BNET_CLIENT_WOW and bnetIDGameAccount) then
            local _, name, _, _, _, faction, _, class, _, _, level = BNGetGameAccountInfo(bnetIDGameAccount)
            local color = GetCreatureDifficultyColor(level)
            if (faction == UnitFactionGroup("player")) then
                button.name:SetFormattedText(pattern, color.r*255, color.g*255, color.b*255, level, select(4,GetClassColor(classes[class])), name)
                button.name:SetTextColor(1, 0.82, 0)
            else
                button.name:SetFormattedText("|cffaaaaaa%s %s|r", level, name)
            end
            button.bname:SetFormattedText("|cff82c5ff%s|r",  accountName or UNKNOWN)
        end
    end
end)
