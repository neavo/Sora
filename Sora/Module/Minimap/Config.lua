-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Minimap = C.Minimap or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.Minimap = SoraDB.Minimap or {}

    SoraDB.Minimap.Size = SoraDB.Minimap.Size or 150
    SoraDB.Minimap.Postion = SoraDB.Minimap.Postion or {"TOPLEFT", "UIParent", "TOPLEFT", 8, -8}

    C.Minimap = S.Copy(SoraDB.Minimap)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.Minimap = C.Config.Minimap or {}
    C.Config.Minimap.Mover = C.Config.Minimap.Mover or {}

    C.Config.Minimap.Tab = {index = 3, text = "小地图"}

    C.Config.Minimap.Menu = {
        {
            type = "slider",
            key = "SoraDB.Minimap.Size",
            text = "小地图尺寸",
            step = 1,
            maxValue = 250,
            minValue = 50,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Minimap.Size = data.value
                end
            end
        }, {type = "space"}, {
            type = "button",
            text = "切换锚点显示状态",
            OnClick = function(self, btn, ...)
                for k, v in pairs(C.Config.Minimap.Mover) do
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
                            table.wipe(SoraDB.Minimap)

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

    C.Config.Minimap.Mover = {
        SoraMinimap = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.Minimap.Postion = {self:GetPoint()}
                SoraDB.Minimap.Postion[2] = "UIParent"
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
