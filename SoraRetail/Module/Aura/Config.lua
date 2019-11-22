-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
if not C.Aura then
    C.Aura = {}
end

C.Aura.Size = 36 -- 状态图标大小
C.Aura.Space = 8 -- 状态图标间距大小
C.Aura.Postion = {"TOPRIGHT", UIParent, -C.Aura.Space, -C.Aura.Space} -- 状态图标位置