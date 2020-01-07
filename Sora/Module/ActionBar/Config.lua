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
            type = "button",
            text = "切换锚点显示状态",
            OnClick = function(self, btn, ...)
                for k, v in pairs(C.Config.ActionBar.Mover) do
                    if v.anchor then
                        if v.anchor:IsVisible() then
                            v.anchor:Hide()
                        else
                            v.anchor:Show()
                        end
                    end
                end
            end
        },
        {
            type = "button",
            text = "重置本页设置至默认值",
            OnClick = function(self, btn, ...)
                local data = {}

                table.insert(
                    data,
                    {
                        title = "确认",
                        detail = "即将为您重置本页设置选项至默认值，请点击下方按钮确认或取消！",
                        OnNoClick = function(self)
                        end,
                        OnYesClick = function(self)
                            table.wipe(SoraDB.ActionBar)

                            self:SetData(data[2])
                            self:Show()
                        end
                    }
                )
                table.insert(
                    data,
                    {
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

    C.Config.ActionBar.Mover = {
        SoraActionBar = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.ActionBar.Postion = {self:GetPoint()}
                SoraDB.ActionBar.Postion[2] = "UIParent"
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
