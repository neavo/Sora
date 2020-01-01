-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Minimap = C.Minimap or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.Minimap = SoraDB.Minimap or {}

    SoraDB.Minimap.Width = SoraDB.Minimap.Width or 150
    SoraDB.Minimap.Height = SoraDB.Minimap.Height or 150
    SoraDB.Minimap.Postion = SoraDB.Minimap.Postion or {"TOPLEFT", "UIParent", "TOPLEFT", 8, -8}

    C.Minimap = S.Copy(SoraDB.Minimap)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.Minimap = C.Config.Minimap or {}

    C.Config.Minimap.Tab = {
        index = 3,
        text = "小地图"
    }

    C.Config.Minimap.Menu = {
        {
            type = "slider",
            key = "SoraDB.Minimap.Width",
            text = "小地图宽度",
            step = 1,
            maxValue = 250,
            minValue = 50,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Minimap.Width = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.Minimap.Height",
            text = "小地图高度",
            step = 1,
            maxValue = 250,
            minValue = 50,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Minimap.Height = data.value
                end
            end
        },
        {
            type = "space"
        },
        {
            type = "postion",
            key = "SoraDB.Minimap.Postion",
            text = "锚点位置（注意：横轴偏移量、纵轴偏移量仅限输入数字值，非数字值将不会被保存）",
            OnDataChanged = function(self, data, ...)
                SoraDB.Minimap.Postion = data.value
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
                table.wipe(SoraDB.Minimap)

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
