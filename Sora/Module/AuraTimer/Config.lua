-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.AuraTimer = C.AuraTimer or {}

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
    SoraDB.AuraTimer = SoraDB.AuraTimer or {}

    SoraDB.AuraTimer.Player = SoraDB.AuraTimer.Player or {
        WhiteList = {
            188370 -- 奉献
        },
        BlackList = {}
    }

    SoraDB.AuraTimer.Target = SoraDB.AuraTimer.Target or {
        WhiteList = {
            188370 -- 奉献
        },
        BlackList = {}
    }

    C.AuraTimer = S.Copy(SoraDB.AuraTimer)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.AuraTimer = C.Config.AuraTimer or {}

    C.Config.AuraTimer.Tab = {index = 5, text = "状态计时器"}

    C.Config.AuraTimer.Menu = {
        {
            type = "button",
            text = "玩家框体计时器白名单",
            OnClick = function(self, btn, ...)
                local instance = CreateAuraManager(SoraDB.AuraTimer.Player.WhiteList)
                instance:Set("text", "玩家框体计时器白名单")
                instance:Show()
                SoraConfig:Hide()
            end
        }, {
            type = "button",
            text = "玩家框体计时器黑名单",
            OnClick = function(self, btn, ...)
                local instance = CreateAuraManager(SoraDB.AuraTimer.Player.BlackList)
                instance:Set("text", "玩家框体计时器黑名单")
                instance:Show()
                SoraConfig:Hide()
            end
        }, {
            type = "button",
            text = "目标框体计时器白名单",
            OnClick = function(self, btn, ...)
                local instance = CreateAuraManager(SoraDB.AuraTimer.Target.WhiteList)
                instance:Set("text", "目标框体计时器白名单")
                instance:Show()
                SoraConfig:Hide()
            end
        }, {
            type = "button",
            text = "目标框体计时器黑名单",
            OnClick = function(self, btn, ...)
                local instance = CreateAuraManager(SoraDB.AuraTimer.Target.BlackList)
                instance:Set("text", "目标框体计时器黑名单")
                instance:Show()
                SoraConfig:Hide()
            end
        }, {
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
                            table.wipe(SoraDB.AuraTimer)

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
