-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
if not C.MiniMap then
    C.MiniMap = {}
end

C.MiniMap.Width = 150 -- 小地图框体
C.MiniMap.Height = 150 -- 小地图高度
C.MiniMap.BarHeight = 6 -- 小地图信息条高度
C.MiniMap.Postion = {"TOPLEFT", UIParent, 8, -8} -- 小地图位置