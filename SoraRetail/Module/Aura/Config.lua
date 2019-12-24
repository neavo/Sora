-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Aura = C.Aura or {}

-- Config
C.Aura.Size = 36 -- 状态图标大小
C.Aura.Spacing = 12 -- 状态图标间距大小
C.Aura.Postion = {"TOPRIGHT", UIParent, -8, -8} -- 状态图标位置
