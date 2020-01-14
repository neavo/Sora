-- /sorareset
SLASH_SORARESET1 = "/sorareset"
SlashCmdList.SORARESET = function(...)
    table.wipe(SoraDB)
    table.wipe(SoraDBPerCharacter)

    StaticPopupDialogs["SORARESET"] = {
        text = "|cff70C0F5[Sora's] |r" .. "已完成重置，请点击确认重载UI！",
        button1 = "确认",
        OnAccept = function()
            ReloadUI()
        end
    }
    StaticPopup_Show("SORARESET")
end
