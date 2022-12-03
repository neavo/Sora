-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Chat = C.Chat or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.Chat = SoraDB.Chat or {}

    SoraDB.Chat.Width = SoraDB.Chat.Width or 450
    SoraDB.Chat.Height = SoraDB.Chat.Height or 200
    SoraDB.Chat.Postion = SoraDB.Chat.Postion or {"BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 8, 8}

    C.Chat = S.Copy(SoraDB.Chat)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.Chat = C.Config.Chat or {}
    C.Config.Chat.Mover = C.Config.Chat.Mover or {}

    C.Config.Chat.Tab = {index = 4, text = "聊天框体"}

    C.Config.Chat.Menu = {
        {
            type = "slider",
            key = "SoraDB.Chat.Width",
            text = "聊天框体宽度",
            step = 1,
            maxValue = 600,
            minValue = 300,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Chat.Width = data.value
                end
            end
        }, {
            type = "slider",
            key = "SoraDB.Chat.Height",
            text = "聊天框体高度",
            step = 1,
            maxValue = 300,
            minValue = 100,
            OnDataChanged = function(self, data, ...)
                if data.value then
                    SoraDB.Chat.Height = data.value
                end
            end
        }, {
            type = "button",
            text = "切换锚点显示状态",
            OnClick = function(self, btn, ...)
                for k, v in pairs(C.Config.Chat.Mover) do
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
                            table.wipe(SoraDB.Chat)

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

    C.Config.Chat.Mover = {
        SoraChat = {
            OnDragStop = function(self, ...)
                self:StopMovingOrSizing()

                SoraDB.Chat.Postion = {self:GetPoint()}
                SoraDB.Chat.Postion[2] = "UIParent"
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
