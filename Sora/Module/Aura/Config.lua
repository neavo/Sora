-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Aura = C.Aura or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.Aura = SoraDB.Aura or {}

    SoraDB.Aura.Size = SoraDB.Aura.Size or 36
    SoraDB.Aura.Space = SoraDB.Aura.Space or 12
    SoraDB.Aura.Postion = SoraDB.Aura.Postion or {"TOPRIGHT", "UIParent", "TOPRIGHT", -8, -8}

    C.Aura = S.Copy(SoraDB.Aura)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.Aura = C.Config.Aura or {}
    C.Config.Aura.Mover = C.Config.Aura.Mover or {}

    C.Config.Aura.Tab = {index = 2, text = "状态"}

    C.Config.Aura.Menu = {
        {
            type = "slider",
            key = "SoraDB.Aura.Size",
            text = "状态图标尺寸",
            step = 1,
            maxValue = 72,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Aura.Size = data.value
                end
            end
        }, {
            type = "slider",
            key = "SoraDB.Aura.Space",
            text = "状态图标间距",
            step = 1,
            maxValue = 24,
            minValue = 0,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Aura.Space = data.value
                end
            end
        }, {
            type = "button",
            text = "切换锚点显示状态",
            OnClick = function(self, btn, ...)
                for k, v in pairs(C.Config.Aura.Mover) do
                    if v.anchor then
                        if v.anchor:IsVisible() then
                            v.anchor:Hide()
                        else
                            v.anchor:Show()
                        end
                    end
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
                            table.wipe(SoraDB.Aura)

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

    C.Config.Aura.Mover = {
        SoraAura = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.Aura.Postion = {self:GetPoint()}
                SoraDB.Aura.Postion[2] = "UIParent"
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
