-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Aura = C.Aura or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.Aura = SoraDB.Aura or {}

    SoraDB.Aura.Size = SoraDB.Aura.Size or 36
    SoraDB.Aura.Spacing = SoraDB.Aura.Spacing or 12
    SoraDB.Aura.Postion = SoraDB.Aura.Postion or {"TOPRIGHT", "UIParent", "TOPRIGHT", -8, -8}

    C.Aura = S.Copy(SoraDB.Aura)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.Aura = C.Config.Aura or {}

    C.Config.Aura.Tab = {
        index = 2,
        text = "增益"
    }

    C.Config.Aura.Menu = {
        {
            type = "slider",
            key = "SoraDB.Aura.Size",
            text = "增益图标尺寸",
            step = 1,
            maxValue = 72,
            minValue = 8,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Aura.Size = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.Aura.Spacing",
            text = "增益图标间距",
            step = 1,
            maxValue = 72,
            minValue = 8,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Aura.Spacing = data.value
                end
            end
        },
        {
            type = "postion",
            key = "SoraDB.Aura.Postion",
            text = "增益锚点位置（注意：横轴偏移量、纵轴偏移量仅限输入数字值，非数字值将不会被保存）",
            OnDataChanged = function(self, data, ...)
                SoraDB.Aura.Postion = data.value
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
                table.wipe(SoraDB.Aura)

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
