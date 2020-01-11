-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Core = C.Core or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.Core = SoraDB.Core or {}
    SoraDB.Core.UIScale = SoraDB.Core.UIScale or 1.00
    SoraDB.Core.Pixel = 1080 / select(2, GetPhysicalScreenSize()) -- 考虑到分辨率会变动，像素尺寸应该在每次加载时实时计算

    C.Core = S.Copy(SoraDB.Core)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.Core = C.Config.Core or {}
    C.Config.Core.Mover = C.Config.Core.Mover or {}

    C.Config.Core.Tab = {index = -1, text = "全局"}

    C.Config.Core.Menu = {
        {
            type = "slider",
            key = "SoraDB.Core.UIScale",
            text = "全局UI缩放比例",
            step = 0.01,
            maxValue = 1.50,
            minValue = 0.50,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Core.UIScale = data.value
                end
            end
        }, {type = "space"}, {
            type = "button",
            text = "重置全部设置至默认值",
            OnClick = function(self, btn, ...)
                local data = {}

                table.insert(
                    data, {
                        title = "确认",
                        detail = "即将为您重置全部 |cff70C0F5Sora's|r 设置选项至默认值，请点击下方按钮确认或取消！",
                        OnNoClick = function(self)
                        end,
                        OnYesClick = function(self)
                            table.wipe(SoraDB)
                            table.wipe(SoraDBPerCharacter)

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