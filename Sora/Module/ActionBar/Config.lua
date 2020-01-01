-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.ActionBar = C.ActionBar or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.ActionBar = SoraDB.ActionBar or {}

    SoraDB.ActionBar.Size = SoraDB.ActionBar.Size or 36
    SoraDB.ActionBar.Space = SoraDB.ActionBar.Space or 8
    SoraDB.ActionBar.Postion = SoraDB.ActionBar.Postion or {"BOTTOM", "UIParent", "BOTTOM", 0, 8}

    C.ActionBar = S.Copy(SoraDB.ActionBar)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.ActionBar = C.Config.ActionBar or {}

    C.Config.ActionBar.Tab = {
        index = 3,
        text = "动作条"
    }

    C.Config.ActionBar.Menu = {
        {
            type = "slider",
            key = "SoraDB.ActionBar.Size",
            text = "动作条按钮尺寸",
            step = 1,
            maxValue = 72,
            minValue = 8,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.ActionBar.Size = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.ActionBar.Space",
            text = "动作条按钮间距",
            step = 1,
            maxValue = 32,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.ActionBar.Space = data.value
                end
            end
        },
        {
            type = "space"
        },
        {
            type = "postion",
            key = "SoraDB.ActionBar.Postion",
            text = "锚点位置（注意：横轴偏移量、纵轴偏移量仅限输入数字值，非数字值将不会被保存）",
            OnDataChanged = function(self, data, ...)
                SoraDB.ActionBar.Postion = data.value
            end
        },
        {
            type = "space"
        },
        {
            type = "button",
            text = "重置本页设置至默认值",
            OnClick = function(self, btn, ...)
                SoraConfig:Hide()
                table.wipe(SoraDB.ActionBar)

                local alert = S.CreateAlert(UIParent, 12)
                alert:SetData(
                    {
                        title = "确认",
                        detail = "已为您重置设置，即将重新载入UI，请点击下方按钮确认！",
                        positiveText = "确认",
                        OnPositiveClick = function(self, btn, ...)
                            ReloadUI()
                        end
                    }
                )
                alert:SetPoint("TOP", UIParent, "TOP", 0, -256)
                alert:SetAlterWidth(512)
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
