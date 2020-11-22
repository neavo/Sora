-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Core = C.Core or {}

-- Common
local function ResetCVar(self, ...)
    ConsoleExec("cvar_default")
    SetAddonVersionCheck(false) -- 保持加载过期插件，避免禁用自己
end

local function ResetSora(self, ...)
    table.wipe(SoraDB)
    table.wipe(SoraDBPerCharacter)
end

local function CreateDB(self, ...)
    SoraDB = SoraDB or {}
    SoraDB.Core = SoraDB.Core or {}

    SoraDB.Core.UIScale = SoraDB.Core.UIScale or 1.00
    SoraDB.Core.FontShadow = SoraDB.Core.FontShadow == nil and true or SoraDB.Core.FontShadow
    SoraDB.Core.FontOutline = SoraDB.Core.FontOutline == nil and true or SoraDB.Core.FontOutline
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
        },
        {type = "space"},
        {
            type = "checkbox",
            key = "SoraDB.Core.FontShadow",
            text = "全局字体阴影",
            OnDataChanged = function(self, data, ...)
                if S.ToBoolean(data.value) ~= nil then
                    SoraDB.Core.FontShadow = data.value
                end
            end
        },
        {
            type = "checkbox",
            key = "SoraDB.Core.FontOutline",
            text = "全局字体描边",
            OnDataChanged = function(self, data, ...)
                if S.ToBoolean(data.value) ~= nil then
                    SoraDB.Core.FontOutline = data.value
                end
            end
        },
        {
            type = "button",
            text = "重置全部设置至默认值",
            OnClick = function(self, btn, ...)
                local datas = {}

                table.insert(
                    datas,
                    {
                        title = "确认",
                        detail = "即将为您重置全部 |cff70C0F5Sora's|r 设置选项至默认值，请点击下方按钮确认或取消！",
                        OnNoClick = function(self)
                        end,
                        OnYesClick = function(self)
                            self:SetData(datas[2])
                            self:Show()
                        end
                    }
                )

                table.insert(
                    datas,
                    {
                        title = "选择",
                        noText = "重置所有设置",
                        yesText = "仅重置 |cff70C0F5Sora's|r",
                        detail = "选择您要重置的设置的范围，如您是第一次使用 |cff70C0F5Sora's|r 强烈建议对所有设置进行重置!",
                        OnNoClick = function(self)
                            ResetCVar()
                            ResetSora()

                            self:SetData(datas[3])
                            self:Show()
                        end,
                        OnYesClick = function(self)
                            ResetSora()

                            self:SetData(datas[3])
                            self:Show()
                        end
                    }
                )

                table.insert(
                    datas,
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
                confirm:SetData(datas[1])
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

-- CMD
do
    SLASH_SORARESET1 = "/sorareset"
    SlashCmdList.SORARESET = function(...)
        ResetCVar()
        ResetSora()

        StaticPopupDialogs["SORARESET"] = {
            text = "|cff70C0F5[Sora's] |r" .. "已完成重置，请点击确认重载UI！",
            button1 = "确认",
            OnAccept = function()
                ReloadUI()
            end
        }
        StaticPopup_Show("SORARESET")
    end
end
