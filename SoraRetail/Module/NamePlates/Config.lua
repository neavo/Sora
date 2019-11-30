-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
if not C.NamePlates then
    C.NamePlates = {}
end

C.NamePlates.Width = 128
C.NamePlates.Height = 8