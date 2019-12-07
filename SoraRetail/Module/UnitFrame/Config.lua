-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
if not C.UnitFrame then
    C.UnitFrame = {}
end

C.UnitFrame.Player = {}
C.UnitFrame.Player.Width = 220 -- 玩家框体宽度
C.UnitFrame.Player.Height = 36 -- 玩家框体高度
C.UnitFrame.Player.Postion = {"CENTER", UIParent, "CENTER", -384, -128} -- 玩家框体位置

C.UnitFrame.Target = {}
C.UnitFrame.Target.Width = 220 -- 目标框体宽度
C.UnitFrame.Target.Height = 36 -- 目标框体高度
C.UnitFrame.Target.Postion = {"CENTER", UIParent, "CENTER", 384, -128} -- 目标框体位置

C.UnitFrame.Focus = {}
C.UnitFrame.Focus.Width = 220 -- 焦点框体宽度
C.UnitFrame.Focus.Height = 36 -- 焦点框体高度
C.UnitFrame.Focus.Postion = {"CENTER", UIParent, "CENTER", 0, 192} -- 焦点框体位置

C.UnitFrame.Boss = {}
C.UnitFrame.Boss.Width = 220 -- 首领框体宽度
C.UnitFrame.Boss.Height = 36 -- 首领框体高度
C.UnitFrame.Boss.Postion = {"CENTER", UIParent, "CENTER", 0, 360} -- 首领框体位置

C.UnitFrame.Raid = {}
C.UnitFrame.Raid.Width = 96 -- 团队框体宽度
C.UnitFrame.Raid.Height = 30 -- 团队框体高度
C.UnitFrame.Raid.Postion = {"BOTTOMRIGHT", UIParent,"BOTTOMRIGHT", -8, 8} -- 默认模式时，团队框体位置
C.UnitFrame.Raid.HealerPostion = {"BOTTOM", UIParent, "BOTTOM", 0, 150} -- 治疗模式时，玩家框体位置
C.UnitFrame.Raid.IndicatorFilters = {
        -- 不同职业下，团队框体边角状态监视，请自行添加需要监视的技能ID
        ["DRUID"] = {
            -- 回春术，回春术（萌芽），生命绽放，野性成长，愈合，铁木树皮
            774, 155777, 33763, 48438, 8936, 102342,
        },
        ["MONK"] = {},
        ["MAGE"] = {},
        ["ROGUE"] = {},
        ["PRIEST"] = {},
        ["HUNTER"] = {},
        ["SHAMAN"] = {
            61295, 53390
        },
        ["WARLOCK"] = {},
        ["PALADIN"] = {
            -- 提尔的拯救，无，无，无，圣光道标，信仰道标，无
            200654, 0, 0, 53563, 156910, 0,
        },
        ["WARRIOR"] = {},
        ["DEATHKNIGHT"] = {},
        ["DEMONHUNTER"] = {},
}
