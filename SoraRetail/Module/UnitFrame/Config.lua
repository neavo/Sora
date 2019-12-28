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
C.UnitFrame.Boss.Postion = {"CENTER", UIParent, "CENTER", 0, 350} -- 首领框体位置

C.UnitFrame.Raid = {}
C.UnitFrame.Raid.Width = 96 -- 团队框体宽度
C.UnitFrame.Raid.Height = 30 -- 团队框体高度
C.UnitFrame.Raid.HealerPostion = {"BOTTOM", UIParent, "BOTTOM", 0, 170} -- 治疗模式时，玩家框体位置
C.UnitFrame.Raid.DefaultPostion = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -8, 8} -- 默认模式时，团队框体位置

-- 不同职业下，团队框体边角状态监视
-- 请自行添加需要监视的技能ID，最大可监视8个技能ID
C.UnitFrame.Raid.IndicatorFilters = {}
C.UnitFrame.Raid.IndicatorFilters.MONK = {}
C.UnitFrame.Raid.IndicatorFilters.MAGE = {}
C.UnitFrame.Raid.IndicatorFilters.DRUID = {774, 33763, 207386, 102351, 48438, 8936, 102342, 157982} -- 回春术，生命绽放，春暖花开，塞纳里奥结界，野性成长，愈合，铁木树皮，宁静
C.UnitFrame.Raid.IndicatorFilters.ROGUE = {}
C.UnitFrame.Raid.IndicatorFilters.PRIEST = {}
C.UnitFrame.Raid.IndicatorFilters.HUNTER = {}
C.UnitFrame.Raid.IndicatorFilters.SHAMAN = {}
C.UnitFrame.Raid.IndicatorFilters.WARLOCK = {}
C.UnitFrame.Raid.IndicatorFilters.PALADIN = {}
C.UnitFrame.Raid.IndicatorFilters.WARRIOR = {}
C.UnitFrame.Raid.IndicatorFilters.DEATHKNIGHT = {}
C.UnitFrame.Raid.IndicatorFilters.DEMONHUNTER = {}
