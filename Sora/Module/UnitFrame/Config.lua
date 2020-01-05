-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.UnitFrame = C.UnitFrame or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.UnitFrame = SoraDB.UnitFrame or {}

    SoraDB.UnitFrame.Player = SoraDB.UnitFrame.Player or {}
    SoraDB.UnitFrame.Player.Width = SoraDB.UnitFrame.Player.Width or 220
    SoraDB.UnitFrame.Player.Height = SoraDB.UnitFrame.Player.Height or 36
    SoraDB.UnitFrame.Player.Postion = SoraDB.UnitFrame.Player.Postion or {"CENTER", "UIParent", "CENTER", -384, -128}

    SoraDB.UnitFrame.Target = SoraDB.UnitFrame.Target or {}
    SoraDB.UnitFrame.Target.Width = SoraDB.UnitFrame.Target.Width or 220
    SoraDB.UnitFrame.Target.Height = SoraDB.UnitFrame.Target.Height or 36
    SoraDB.UnitFrame.Target.Postion = SoraDB.UnitFrame.Target.Postion or {"CENTER", "UIParent", "CENTER", 384, -128}

    SoraDB.UnitFrame.Focus = SoraDB.UnitFrame.Focus or {}
    SoraDB.UnitFrame.Focus.Width = SoraDB.UnitFrame.Focus.Width or 220
    SoraDB.UnitFrame.Focus.Height = SoraDB.UnitFrame.Focus.Height or 36
    SoraDB.UnitFrame.Focus.Postion = SoraDB.UnitFrame.Focus.Postion or {"CENTER", "UIParent", "CENTER", 0, 192}

    SoraDB.UnitFrame.Boss = SoraDB.UnitFrame.Boss or {}
    SoraDB.UnitFrame.Boss.Width = SoraDB.UnitFrame.Boss.Width or 220
    SoraDB.UnitFrame.Boss.Height = SoraDB.UnitFrame.Boss.Height or 36
    SoraDB.UnitFrame.Boss.Postion = SoraDB.UnitFrame.Boss.Postion or {"CENTER", "UIParent", "CENTER", 0, 350}

    SoraDB.UnitFrame.Raid = SoraDB.UnitFrame.Raid or {}
    SoraDB.UnitFrame.Raid.Width = SoraDB.UnitFrame.Raid.Width or 96
    SoraDB.UnitFrame.Raid.Height = SoraDB.UnitFrame.Raid.Height or 30
    SoraDB.UnitFrame.Raid.HealerPostion = SoraDB.UnitFrame.Raid.HealerPostion or {"BOTTOM", "UIParent", "BOTTOM", 0, 170}
    SoraDB.UnitFrame.Raid.DefaultPostion = SoraDB.UnitFrame.Raid.DefaultPostion or {"BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -8, 8}

    -- 不同职业下，团队框体边角状态监视
    -- 请自行添加需要监视的技能ID，最大可监视8个技能ID
    SoraDB.UnitFrame.Raid.IndicatorFilters = SoraDB.UnitFrame.Raid.IndicatorFilters or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.MONK = SoraDB.UnitFrame.Raid.IndicatorFilters.MONK or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.MAGE = SoraDB.UnitFrame.Raid.IndicatorFilters.MAGE or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.DRUID = SoraDB.UnitFrame.Raid.IndicatorFilters.DRUID or {774, 33763, 207386, 102351, 48438, 8936, 102342, 157982} -- 回春术，生命绽放，春暖花开，塞纳里奥结界，野性成长，愈合，铁木树皮，宁静
    SoraDB.UnitFrame.Raid.IndicatorFilters.ROGUE = SoraDB.UnitFrame.Raid.IndicatorFilters.ROGUE or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.PRIEST = SoraDB.UnitFrame.Raid.IndicatorFilters.PRIEST or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.HUNTER = SoraDB.UnitFrame.Raid.IndicatorFilters.HUNTER or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.SHAMAN = SoraDB.UnitFrame.Raid.IndicatorFilters.SHAMAN or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.WARLOCK = SoraDB.UnitFrame.Raid.IndicatorFilters.WARLOCK or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.PALADIN = SoraDB.UnitFrame.Raid.IndicatorFilters.PALADIN or {53563}
    SoraDB.UnitFrame.Raid.IndicatorFilters.WARRIOR = SoraDB.UnitFrame.Raid.IndicatorFilters.WARRIOR or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.DEATHKNIGHT = SoraDB.UnitFrame.Raid.IndicatorFilters.DEATHKNIGHT or {}
    SoraDB.UnitFrame.Raid.IndicatorFilters.DEMONHUNTER = SoraDB.UnitFrame.Raid.IndicatorFilters.DEMONHUNTER or {}

    C.UnitFrame = S.Copy(SoraDB.UnitFrame)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.UnitFrame = C.Config.UnitFrame or {}

    C.Config.UnitFrame.Tab = {
        text = "单位框体",
        index = 4
    }

    C.Config.UnitFrame.Menu = {
        {
            type = "slider",
            key = "SoraDB.UnitFrame.Player.Width",
            text = "玩家框体宽度",
            step = 1,
            maxValue = 440,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.UnitFrame.Player.Width = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.UnitFrame.Player.Height",
            text = "玩家框体高度",
            step = 1,
            maxValue = 72,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.UnitFrame.Player.Height = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.UnitFrame.Target.Width",
            text = "目标框体宽度",
            step = 1,
            maxValue = 440,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.UnitFrame.Target.Width = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.UnitFrame.Target.Height",
            text = "目标框体高度",
            step = 1,
            maxValue = 72,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.UnitFrame.Target.Height = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.UnitFrame.Focus.Width",
            text = "焦点框体宽度",
            step = 1,
            maxValue = 440,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.UnitFrame.Focus.Width = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.UnitFrame.Focus.Height",
            text = "焦点框体高度",
            step = 1,
            maxValue = 72,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.UnitFrame.Focus.Height = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.UnitFrame.Raid.Width",
            text = "团队单位框体宽度",
            step = 1,
            maxValue = 192,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.UnitFrame.Raid.Width = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.UnitFrame.Raid.Height",
            text = "团队单位框体高度",
            step = 1,
            maxValue = 60,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.UnitFrame.Raid.Height = data.value
                end
            end
        },
        {
            type = "button",
            text = "切换锚点显示状态",
            OnClick = function(self, btn, ...)
                for k, v in pairs(C.Config.UnitFrame.Mover) do
                    if v.anchor then
                        if v.anchor:IsVisible() then
                            v.anchor:Hide()
                        else
                            v.anchor:Show()
                        end
                    end
                end
            end
        },
        {
            type = "button",
            text = "重置本页设置至默认值",
            OnClick = function(self, btn, ...)
                local data = {}

                table.insert(
                    data,
                    {
                        title = "确认",
                        detail = "即将为您重置本页设置选项至默认值，请点击下方按钮确认或取消！",
                        OnNoClick = function(self)
                        end,
                        OnYesClick = function(self)
                            table.wipe(SoraDB.UnitFrame)

                            self:SetData(data[2])
                            self:Show()
                        end
                    }
                )
                table.insert(
                    data,
                    {
                        title = "确认",
                        detail = "已完成重置，请点击下方按钮重新载入UI！",
                        OnYesClick = function(self)
                            ReloadUI()
                        end
                    }
                )

                local confirm = S.CreateConfirm(UIParent, 12)
                confirm:SetData(data[1])
                confirm:SetConfirmWidth(512)
                confirm:SetPoint("TOP", UIParent, "TOP", 0, -256)

                SoraConfig:Hide()
            end
        }
    }

    C.Config.UnitFrame.Mover = {
        SoraUFPlayer = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.UnitFrame.Player.Postion = {self:GetPoint()}
                SoraDB.UnitFrame.Player.Postion[2] = "UIParent"
            end,
            OnDragStart = function(self, ...)
                self:StartMoving()
            end
        },
        SoraUFTarget = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.UnitFrame.Target.Postion = {self:GetPoint()}
                SoraDB.UnitFrame.Target.Postion[2] = "UIParent"
            end,
            OnDragStart = function(self, ...)
                self:StartMoving()
            end
        },
        SoraUFFocus = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.UnitFrame.Focus.Postion = {self:GetPoint()}
                SoraDB.UnitFrame.Focus.Postion[2] = "UIParent"
            end,
            OnDragStart = function(self, ...)
                self:StartMoving()
            end
        },
        SoraUFBoss = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.UnitFrame.Boss.Postion = {self:GetPoint()}
                SoraDB.UnitFrame.Boss.Postion[2] = "UIParent"
            end,
            OnDragStart = function(self, ...)
                self:StartMoving()
            end
        },
        SoraUFRaidHealer = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.UnitFrame.Raid.HealerPostion = {self:GetPoint()}
                SoraDB.UnitFrame.Raid.HealerPostion[2] = "UIParent"
            end,
            OnDragStart = function(self, ...)
                self:StartMoving()
            end
        },
        SoraUFRaidDefault = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.UnitFrame.Raid.DefaultPostion = {self:GetPoint()}
                SoraDB.UnitFrame.Raid.DefaultPostion[2] = "UIParent"
            end,
            OnDragStart = function(self, ...)
                self:StartMoving()
            end
        }
    }
end

-- Event
local OnAddonLoaded = function(self, event, addon, ...)
    if addon ~= "Sora" then
        return 0
    end

    CreateDB(self, ...)
    CreateConfig(self, ...)
end

-- Handler
local EventHandler = S.CreateEventHandler()
EventHandler.Event.ADDON_LOADED = OnAddonLoaded
EventHandler.Register()
