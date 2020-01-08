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

    C.Config.NamePlates.Tab = {index = 3, text = "姓名板"}

    C.Config.NamePlates.Menu = {
        {
            type = "slider",
            key = "SoraDB.NamePlates.Width",
            text = "姓名板宽度",
            step = 1,
            maxValue = 160,
            minValue = 60,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.NamePlates.Width = data.value
                end
            end
        }, {
            type = "slider",
            key = "SoraDB.NamePlates.Height",
            text = "姓名板高度",
            step = 1,
            maxValue = 12,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.NamePlates.Height = data.value
                end
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
                            table.wipe(SoraDB.NamePlates)

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
