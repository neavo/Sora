-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.UnitFrame = C.UnitFrame or {}

-- Common
local function CreateAuraManager(auras)
    local data = {}
    data.auras = S.Copy(auras or {})

    function data.OnDataChanged(self, data)
        for k, v in pairs(data.auras) do
            auras[k] = v
        end
    end

    local instance = S.CreateAuraManager(UIParent)
    instance:SetData(data)
    instance:SetPoint("CENTER")
    instance:SetManagerWidth(150 * 5 + 12 * 4 + 12 * 2)

    return instance
end

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

    SoraDB.UnitFrame.Raid = SoraDB.UnitFrame.Raid or {
        Width = 96,
        Height = 30,
        HealerPostion = {"BOTTOM", "UIParent", "BOTTOM", 0, 170},
        DefaultPostion = {"BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -8, 8},
        IndicatorMode = 1, -- 1 = 智能，2 = 仅白名单
        IndicatorBlackList = {
            269279 -- 特质，回升防护
        },
        IndicatorWhiteList = {
            974, -- 萨满，大地之盾
            53563 -- 骑士，圣光道标
        }
    }

    C.UnitFrame = S.Copy(SoraDB.UnitFrame)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.UnitFrame = C.Config.UnitFrame or {}

    C.Config.UnitFrame.Tab = {text = "单位框体", index = 4}

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
        }, {
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
        }, {
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
        }, {
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
        }, {
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
        }, {
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
        }, {
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
        }, {
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
        }, {
            type = "dropdown",
            text = "团队边角监视模式",
            key = "SoraDB.UnitFrame.Raid.IndicatorMode",
            options = {["智能"] = 1, ["仅白名单"] = 2},
            OnDataChanged = function(self, data, ...)
                SoraDB.UnitFrame.Raid.IndicatorFilters.Mode = data.value
            end
        }, {type = "space"}, {
            type = "button",
            text = "团队边角监视白名单",
            OnClick = function(self, btn, ...)
                local instance = CreateAuraManager(SoraDB.UnitFrame.Raid.IndicatorWhiteList)
                instance:Set("text", "团队边角监视白名单")
                instance:Show()
                SoraConfig:Hide()
            end
        }, {
            type = "button",
            text = "团队边角监视黑名单",
            OnClick = function(self, btn, ...)
                local instance = CreateAuraManager(SoraDB.UnitFrame.Raid.IndicatorBlackList)
                instance:Set("text", "团队边角监视黑名单")
                instance:Show()
                SoraConfig:Hide()
            end
        }, {
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
        }, {type = "space"}, {
            type = "button",
            text = "重置本页设置至默认值",
            OnClick = function(self, btn, ...)
                local data = {}

                table.insert(
                    data, {
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
                    data, {
                        title = "确认",
                        detail = "已完成重置，请点击下方按钮重新载入UI！",
                        OnYesClick = function(self)
                            ReloadUI()
                        end
                    }
                )

                local confirm = S.CreateConfirm(UIParent, 12)
                confirm:Show()
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
