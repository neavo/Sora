local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.NamePlates = C.NamePlates or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.NamePlates = SoraDB.NamePlates or {}

    SoraDB.NamePlates.Width = SoraDB.NamePlates.Width or 110
    SoraDB.NamePlates.Height = SoraDB.NamePlates.Height or 6

    C.NamePlates = S.Copy(SoraDB.NamePlates)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.NamePlates = C.Config.NamePlates or {}

    C.Config.NamePlates.Tab = {
        index = 3,
        text = "姓名板"
    }

    C.Config.NamePlates.Menu = {
        {
            type = "slider",
            key = "SoraDB.NamePlates.Width",
            text = "姓名板宽度",
            step = 1,
            maxValue = 256,
            minValue = 64,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.NamePlates.Width = data.value
                end
            end
        },
        {
            type = "slider",
            key = "SoraDB.NamePlates.Height",
            text = "姓名板高度",
            step = 1,
            maxValue = 24,
            minValue = 4,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.NamePlates.Height = data.value
                end
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
                table.wipe(SoraDB.NamePlates)

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
