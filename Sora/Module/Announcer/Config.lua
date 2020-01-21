-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Announcer = C.Announcer or {}

-- Common
local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.Announcer = SoraDB.Announcer or {}

    SoraDB.Announcer.AlertMode = SoraDB.Announcer.AlertMode or 2
    SoraDB.Announcer.OnlyPlayer = SoraDB.Announcer.OnlyPlayer ~= nil and SoraDB.Announcer.OnlyPlayer or false
    SoraDB.Announcer.AlertForPlayer = SoraDB.Announcer.AlertForPlayer ~= nil and SoraDB.Announcer.AlertForPlayer or false

    C.Announcer = S.Copy(SoraDB.Announcer)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.Announcer = C.Config.Announcer or {}

    C.Config.Announcer.Tab = {index = 4, text = "信息通报"}

    C.Config.Announcer.Menu = {
        {
            type = "dropdown",
            text = "通报范围",
            key = "SoraDB.Announcer.OnlyPlayer",
            options = {["全部"] = false, ["仅玩家施放的技能"] = true},
            OnDataChanged = function(self, data, ...)
                if S.ToBoolean(data.value) ~= nil then
                    SoraDB.Announcer.OnlyPlayer = S.ToBoolean(data.value)
                end
            end
        },
        {
            type = "dropdown",
            text = "通报频道",
            key = "SoraDB.Announcer.AlertForPlayer",
            options = {["智能"] = false, ["仅玩家个人频道"] = true},
            OnDataChanged = function(self, data, ...)
                if S.ToBoolean(data.value) ~= nil then
                    SoraDB.Announcer.AlertForPlayer = S.ToBoolean(data.value)
                end
            end
        },
        {
            type = "dropdown",
            text = "通报方式",
            key = "SoraDB.Announcer.AlertMode",
            options = {["仅文字"] = 1, ["文字 + 声音"] = 2},
            OnDataChanged = function(self, data, ...)
                if data.value ~= nil then
                    SoraDB.Announcer.AlertMode = data.value
                end
            end
        },
        {type = "space"},
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
                            table.wipe(SoraDB.Announcer)

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
