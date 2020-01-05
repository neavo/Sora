-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Tutorial = C.Tutorial or {}

-- Common
local function CreateDB(self, ...)
    SoraDBPerCharacter = SoraDBPerCharacter or {}
    SoraDBPerCharacter.Tutorial = SoraDBPerCharacter.Tutorial or {}
    SoraDBPerCharacter.Tutorial.Initialized = SoraDBPerCharacter.Tutorial.Initialized or false

    C.Tutorial = S.Copy(SoraDBPerCharacter.Tutorial)
end

local function CreateConfig(self, ...)
    C.Config = C.Config or {}
    C.Config.Tutorial = C.Config.Tutorial or {}
    C.Config.Tutorial.Mover = C.Config.Tutorial.Mover or {}

    C.Config.Tutorial.Tab = {
        index = -1,
        text = "向导"
    }

    C.Config.Tutorial.Menu = {
        {
            type = "button",
            text = "重置全部设置至默认值",
            OnClick = function(self, btn, ...)
                local data = {}

                table.insert(
                    data,
                    {
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
