-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local void = CreateFrame("Frame", nil, nil)

-- Common
function S.MakeText(parent, size)
    local p = C.Core.Pixel or 1.00

    local fontString = parent:CreateFontString(nil, "ARTWORK")
    fontString:SetTextColor(0.90, 0.90, 0.90)
    fontString:SetShadowOffset(1.00 * p, -1.00 * p)
    fontString:SetShadowColor(0.00, 0.00, 0.00, 0.50)
    fontString:SetFont(STANDARD_TEXT_FONT, size, "OUTLINE")

    return fontString
end

function S.MakeBorder(parent, size)
    local p = C.Core.Pixel or 1.00

    local Border = CreateFrame("Frame", nil, parent)
    Border:SetPoint("TOPLEFT", parent, -size * p, size * p)
    Border:SetPoint("BOTTOMRIGHT", parent, size * p, -size * p)
    Border:SetBackdrop({edgeFile = DB.Border, edgeSize = size * p})
    Border:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    return Border
end

function S.MakeShadow(parent, size)
    local p = C.Core.Pixel or 1.00

    local Shadow = CreateFrame("Frame", nil, parent)
    Shadow:SetPoint("TOPLEFT", parent, -size * p, size * p)
    Shadow:SetPoint("BOTTOMRIGHT", parent, size * p, -size * p)
    Shadow:SetBackdrop({edgeFile = DB.GlowTex, edgeSize = size * p})
    Shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    return Shadow
end

function S.MakeTextureShadow(parent, anchor, size)
    local p = C.Core.Pixel or 1.00

    local Shadow = CreateFrame("Frame", nil, parent)
    Shadow:SetPoint("TOPLEFT", anchor, -size * p, size * p)
    Shadow:SetPoint("BOTTOMRIGHT", anchor, size * p, -size * p)
    Shadow:SetBackdrop({edgeFile = DB.GlowTex, edgeSize = size * p})
    Shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    return Shadow
end

function S.CreateEditBox(parent, size)
    local p = C.Core.Pixel or 1.00

    local editbox = CreateFrame("EditBox", nil, parent)
    editbox:SetTextColor(0.90, 0.90, 0.90)
    editbox:SetShadowOffset(1.00 * p, -1.00 * p)
    editbox:SetShadowColor(0.00, 0.00, 0.00, 0.50)
    editbox:SetFont(STANDARD_TEXT_FONT, size, "OUTLINE")

    return editbox
end

function S.CreateEasyMenu()
    local hanlder = {}

    local menuList = {}
    local menuFrame = CreateFrame("Frame", nil, UIParent, "UIDropDownMenuTemplate")

    local p = C.Core.Pixel or 1.00
    local font = CreateFont("MenuListFont")
    font:SetTextColor(0.90, 0.90, 0.90)
    font:SetShadowOffset(1.00 * p, -1.00 * p)
    font:SetShadowColor(0.00, 0.00, 0.00, 0.50)
    font:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")

    local function Set(i, k, v)
        menuList[i][k] = v
    end

    local function Get(i, k, v)
        return menuList[i][k]
    end

    local function Show()
        EasyMenu(menuList, menuFrame, "cursor", 8, -8, nil, 1.00)
    end

    local function NewLine(text, func, funcArgs, agrs)
        local function funcWithArgs()
            func(unpack(funcArgs or {}))
        end

        local menu = {}
        menu.text = text
        menu.func = funcWithArgs
        menu.fontObject = font
        menu.notCheckable = true

        for k, v in pairs(agrs or {}) do
            menu[k] = v
        end

        table.insert(menuList, menu)
    end

    hanlder.Set = Set
    hanlder.Get = Get
    hanlder.Show = Show
    hanlder.NewLine = NewLine

    return hanlder
end

function S.Copy(target)
    local copy = nil

    if type(target) ~= "table" then
        copy = target
    else
        copy = {}
        for target_key, target_value in next, target, nil do
            copy[S.Copy(target_key)] = S.Copy(target_value)
        end
    end

    return copy
end

function S.Error(str)
    PlaySound(SOUNDKIT.RAID_WARNING, "Master")
    UIErrorsFrame:AddMessage("|cff70C0F5[Sora's] |r" .. str)
end

function S.Print(t)
    local print_r_cache = {}

    local function sub_print_r(t, indent)
        if (print_r_cache[tostring(t)]) then
            print(indent .. "*" .. tostring(t))
        else
            print_r_cache[tostring(t)] = true
            if (type(t) == "table") then
                for pos, val in pairs(t) do
                    if (type(val) == "table") then
                        print(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
                        sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 8))
                        print(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
                    elseif (type(val) == "string") then
                        print(indent .. "[" .. pos .. '] => "' .. val .. '"')
                    else
                        print(indent .. "[" .. pos .. "] => " .. tostring(val))
                    end
                end
            else
                print(indent .. tostring(t))
            end
        end
    end
    if (type(t) == "table") then
        print(tostring(t) .. " {")
        sub_print_r(t, "  ")
        print("}")
    else
        sub_print_r(t, "  ")
    end
end

function S.KillFrame(frame)
    if frame.Show and frame.Hide then
        frame.Show = frame.Hide
    end

    if frame.SetParent then
        frame:SetParent(void)
    end

    if frame.UnregisterAllEvents then
        frame:UnregisterAllEvents()
    end

    do
        frame:Hide()
    end
end

function S.ToBoolean(v)
    local result = nil

    if type(v) == "boolean" then
        result = v
    elseif type(v) == "string" and string.lower(v) == "true" then
        result = true
    elseif type(v) == "string" and string.lower(v) == "false" then
        result = false
    end

    return result
end

function S.SubString(str, lenght, postfix)
    local cache = {}
    local result = ""

    for char in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
        table.insert(cache, char)
    end

    if lenght and lenght < #cache then
        for i = 1, lenght do
            result = result .. cache[i]
        end

        if postfix then
            return result .. postfix
        end
    else
        result = str
    end

    return result
end

function S.CountString(str)
    local num = 0

    for char in string.gmatch(str, "[%z\1-\127\194-\244][\128-\191]*") do
        num = num + 1
    end

    return num
end

function S.FormatTime(Time, Short)
    local Day = floor(Time / 86400)
    local Hour = floor((Time - Day * 86400) / 3600)
    local Minute = floor((Time - Day * 86400 - Hour * 3600) / 60)
    local Second = floor(Time - Day * 86400 - Hour * 3600 - Minute * 60)

    if Time > 86400 then
        return Day .. "d " .. (Short and "" or Hour .. "h")
    elseif Time > 3600 then
        return Hour .. "h " .. (Short and "" or Minute .. "m")
    elseif Time < 3600 and Time > 60 then
        return Minute .. "m " .. (Short and "" or Second .. "s")
    elseif Time < 60 and Time > 0 then
        return Second .. "s"
    else
        return "N/A"
    end
end

function S.FormatMemory(Memory)
    local M = format("%.2f", Memory / 1024)
    local K = floor(Memory - floor(Memory / 1024))
    if Memory > 1024 then
        return M .. "m"
    elseif Memory > 0 and Memory < 1024 then
        return K .. "k"
    else
        return "N/A"
    end
end

function S.FormatInteger(int)
    if int >= 1e6 then
        return ("%.1fm"):format(int / 1e6):gsub("%.?0+([km])$", "%1")
    elseif int >= 1e4 then
        return ("%.1fk"):format(int / 1e3):gsub("%.?0+([km])$", "%1")
    else
        return int
    end
end

function S.CreateEventHandler()
    local handler = CreateFrame("Frame")
    handler.Event = {}

    local Register = function()
        handler:UnregisterAllEvents()

        for k, v in pairs(handler.Event) do
            if k ~= "INITIALIZE" then
                handler:RegisterEvent(k)
            end
        end

        if handler.Event.INITIALIZE then
            handler:RegisterEvent("PLAYER_LOGIN")
        end
    end

    local OnEvent = function(self, event, ...)
        for k, v in pairs(self.Event) do
            if handler.Event.INITIALIZE and k == "PLAYER_LOGIN" then
                handler.Event.INITIALIZE(self, event, ...)
            end

            if k == event then
                v(self, event, ...)
                return 0
            end
        end
    end

    handler:SetScript("OnEvent", OnEvent)
    handler.Register = Register

    return handler
end

