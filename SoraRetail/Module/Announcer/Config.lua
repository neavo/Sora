-- Engine
local S, C, L, DB = unpack(select(2, ...))

-- Variables
if not C.Announcer then
    C.Announcer = {}
end

C.Announcer.OnlyPlayer = false