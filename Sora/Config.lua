-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
C.Core = C.Core or {}

-- Pixel
do
    C.Core.Pixel = 1080 / select(2, GetPhysicalScreenSize())
end

-- /rl = /reload
SLASH_RELOAD1 = "/rl"
SlashCmdList.RELOAD = function(...)
    ReloadUI()
end
