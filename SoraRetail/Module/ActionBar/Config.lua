-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.ActionBar = C.ActionBar or {}

-- Config
C.ActionBar.Size = 36 -- 动作条按钮大小
C.ActionBar.Space = 8 -- 动作条按钮间距大小
C.ActionBar.MainBarPostion = {"BOTTOM", UIParent, 0, 8} -- 主动作条位置
