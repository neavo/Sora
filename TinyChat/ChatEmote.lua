
-------------------------------------
-- 聊天表情
-- Author:M
-------------------------------------

local addon, ns = ...

local locale = GetLocale()

local emotes = {
    { key = "angel",    zhTW="天使", zhCN="天使" },
	{ key = "angry",    zhTW="生氣", zhCN="生气" },
	{ key = "biglaugh", zhTW="大笑", zhCN="大笑" },
	{ key = "clap",     zhTW="鼓掌", zhCN="鼓掌" },
	{ key = "cool",     zhTW="酷", zhCN="酷" },
	{ key = "cry",      zhTW="哭", zhCN="哭" },
	{ key = "cutie",    zhTW="可愛", zhCN="可爱" },
	{ key = "despise",  zhTW="鄙視", zhCN="鄙视" },
	{ key = "dreamsmile", zhTW="美夢", zhCN="美梦" },
	{ key = "embarrass", zhTW="尷尬", zhCN="尴尬" },
	{ key = "evil",     zhTW="邪惡", zhCN="邪恶" },
	{ key = "excited",  zhTW="興奮", zhCN="兴奋" },
	{ key = "faint",    zhTW="暈", zhCN="晕" },
	{ key = "fight",    zhTW="打架", zhCN="打架" },
	{ key = "flu",      zhTW="流感", zhCN="流感" },
	{ key = "freeze",   zhTW="呆", zhCN="呆" },
	{ key = "frown",    zhTW="皺眉", zhCN="皱眉" },
	{ key = "greet",    zhTW="致敬", zhCN="致敬" },
	{ key = "grimace",  zhTW="鬼臉", zhCN="鬼脸" },
	{ key = "growl",    zhTW="齜牙", zhCN="龇牙" },
	{ key = "happy",    zhTW="開心", zhCN="开心" },
	{ key = "heart",    zhTW="心", zhCN="心" },
	{ key = "horror",   zhTW="恐懼", zhCN="恐惧" },
	{ key = "ill",      zhTW="生病", zhCN="生病" },
	{ key = "innocent", zhTW="無辜", zhCN="无辜" },
	{ key = "kongfu",   zhTW="功夫", zhCN="功夫" },
	{ key = "love",     zhTW="花痴", zhCN="花痴" },
	{ key = "mail",     zhTW="郵件", zhCN="邮件" },
	{ key = "makeup",   zhTW="化妝", zhCN="化妆" },
    { key = "mario",    zhTW="馬里奧", zhCN="马里奥" },
	{ key = "meditate", zhTW="沉思", zhCN="沉思" },
	{ key = "miserable", zhTW="可憐", zhCN="可怜" },
	{ key = "okay",     zhTW="好", zhCN="好" },
	{ key = "pretty",   zhTW="漂亮", zhCN="漂亮" },
	{ key = "puke",     zhTW="吐", zhCN="吐" },
	{ key = "shake",    zhTW="握手", zhCN="握手" },
	{ key = "shout",    zhTW="喊", zhCN="喊" },
	{ key = "shuuuu",   zhTW="閉嘴", zhCN="闭嘴" },
	{ key = "shy",      zhTW="害羞", zhCN="害羞" },
	{ key = "sleep",    zhTW="睡覺", zhCN="睡觉" },
	{ key = "smile",    zhTW="微笑", zhCN="微笑" },
	{ key = "suprise",  zhTW="吃驚", zhCN="吃惊" },
	{ key = "surrender", zhTW="失敗", zhCN="失败" },
	{ key = "sweat",    zhTW="流汗", zhCN="流汗" },
	{ key = "tear",     zhTW="流淚", zhCN="流泪" },
	{ key = "tears",    zhTW="悲劇", zhCN="悲剧" },
	{ key = "think",    zhTW="想", zhCN="想" },
	{ key = "titter",   zhTW="偷笑", zhCN="偷笑" },
	{ key = "ugly",     zhTW="猥瑣", zhCN="猥琐" },
	{ key = "victory",  zhTW="勝利", zhCN="胜利" },
	{ key = "volunteer", zhTW="雷鋒", zhCN="雷锋" },
	{ key = "wronged",  zhTW="委屈", zhCN="委屈" },
    --指定了texture一般用於BLIZ自帶的素材
    { key = "wrong",    zhTW="錯", zhCN="错", texture = "Interface\\RaidFrame\\ReadyCheck-NotReady" },
    { key = "right",    zhTW="對", zhCN="对", texture = "Interface\\RaidFrame\\ReadyCheck-Ready" },
    { key = "question", zhTW="疑問", zhCN="疑问", texture = "Interface\\RaidFrame\\ReadyCheck-Waiting" },
    { key = "skull",    zhTW="骷髏", zhCN="骷髅", texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull" },
    { key = "sheep",    zhTW="羊", zhCN="羊", texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Sheep" },
}

local function ReplaceEmote(value)
    local emote = value:gsub("[%{%}]", "")
    for _, v in ipairs(emotes) do
        if (emote == v.key or emote == v.zhCN or emote == v.zhTW) then
            return "|T".. (v.texture or "Interface\\AddOns\\"..addon.."\\emotes\\".. v.key) ..":16|t"
        end
    end
    return value
end

local function filter(self, event, msg, ...)
    msg = msg:gsub("%{.-%}", ReplaceEmote)
    return false, msg, ...
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", filter)

------------------------
--以下是界面部分
------------------------

local function EmoteButton_OnClick(self, button)
    local editBox = ChatEdit_ChooseBoxForSend()
    ChatEdit_ActivateChat(editBox)
    editBox:SetText(editBox:GetText():gsub("{$","") .. self.emote)
    if (button == "LeftButton") then
        self:GetParent():Hide()
    end
end

local function EmoteButton_OnEnter(self)
    self:GetParent().title:SetText(self.emote)
end

local function EmoteButton_OnLeave(self)
    self:GetParent().title:SetText("")
end

do
    local frame, button
    local width, height, column, space = 20, 20, 10, 6
    local index = 0
    frame = CreateFrame("Frame", "CustomEmoteFrame", UIParent, "UIPanelDialogTemplate")
    frame.title = frame:CreateFontString(nil, "ARTWORK", "ChatFontNormal")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -9)
    frame:SetWidth(column*(width+space) + 24)
    frame:SetClampedToScreen(true)
    frame:SetFrameStrata("DIALOG")
    frame:SetPoint("TOPRIGHT", GeneralDockManager, "TOPRIGHT", 0, 220)  --這裡調整位置
    for _, v in ipairs(emotes) do
        button = CreateFrame("Button", nil, frame)
        button.emote = "{" .. (v[locale] or v.key) .. "}"
        button:SetSize(width, height)
        if (v.texture) then
            button:SetNormalTexture(v.texture)
        else
            button:SetNormalTexture("Interface\\AddOns\\"..addon.."\\emotes\\" .. v.key)
        end
        button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
        button:SetPoint("TOPLEFT", 16+(index%column)*(width+space), -36 - floor(index/column)*(height+space))
        button:SetScript("OnMouseUp", EmoteButton_OnClick)
        button:SetScript("OnEnter", EmoteButton_OnEnter)
        button:SetScript("OnLeave", EmoteButton_OnLeave)
        index = index + 1
    end
    frame:SetHeight(ceil(index/column)*(height+space) + 46)
    frame:SetAlpha(0.8)
    frame:Hide()
    --让输入框支持当输入 { 时自动弹出聊天表情选择框
    hooksecurefunc("ChatEdit_OnTextChanged", function(self, userInput)
        local text = self:GetText()
        if (userInput and strsub(text, -1) == "{") then
            frame:Show()
        end
    end)
end