-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Variables
local void = CreateFrame("Frame", nil, nil)

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

function S.MakeText(parent, size)
    local fontString = nil

    if not parent.GetDrawLayer then
        fontString = parent:CreateFontString("$parentText", "ARTWORK")
    elseif parent:GetDrawLayer() == "BACKGROUND" then
        fontString = parent:GetParent():CreateFontString("$parentText", "BORDER")
    elseif parent:GetDrawLayer() == "BORDER" then
        fontString = parent:GetParent():CreateFontString("$parentText", "ARTWORK")
    else
        fontString = parent:GetParent():CreateFontString("$parentText", "OVERLAY")
    end

    fontString:SetTextColor(0.90, 0.90, 0.90)
    fontString:SetShadowOffset(1, -1)
    fontString:SetShadowColor(0.00, 0.00, 0.00, 0.50)
    fontString:SetFont(STANDARD_TEXT_FONT, size, "OUTLINE")

    return fontString
end

function S.MakeBorder(parent, size)
    local Border = CreateFrame("Frame", "$parentBorder", parent)
    Border:SetFrameLevel(0)
    Border:SetPoint("TOPLEFT", parent, -size, size)
    Border:SetPoint("BOTTOMRIGHT", parent, size, -size)
    Border:SetBackdrop({edgeFile = DB.Border, edgeSize = size})
    Border:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    return Border
end

function S.MakeShadow(parent, size)
    local Shadow = CreateFrame("Frame", "$parentShadow", parent)
    Shadow:SetFrameLevel(0)
    Shadow:SetPoint("TOPLEFT", parent, -size, size)
    Shadow:SetPoint("BOTTOMRIGHT", parent, size, -size)
    Shadow:SetBackdrop({edgeFile = DB.GlowTex, edgeSize = size})
    Shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    return Shadow
end

function S.MakeTextureShadow(parent, anchor, size)
    local Shadow = CreateFrame("Frame", "$parentTextureShadow", parent)
    Shadow:SetPoint("TOPLEFT", anchor, -size, size)
    Shadow:SetPoint("BOTTOMRIGHT", anchor, size, -size)
    Shadow:SetBackdrop({edgeFile = DB.GlowTex, edgeSize = size})
    Shadow:SetBackdropBorderColor(0.00, 0.00, 0.00, 1.00)

    return Shadow
end

function S.CreateEasyMenu()
    local hanlder = {}
    local menuList = {}
    local menuFrame = CreateFrame("Frame", nil, UIParent, "UIDropDownMenuTemplate")

    local font = CreateFont("MenuListFont")
    font:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    font:SetTextColor(0.90, 0.90, 0.90)
    font:SetShadowColor(0.00, 0.00, 0.00, 0.50)
    font:SetShadowOffset(1, -1)

    local function Set(i, k, v)
        menuList[i][k] = v
    end

    local function Show()
        EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
    end

    local function NewLine(text, func, args)
        local function funcWithArgs()
            if not args then
                func()
            else
                func(unpack(args))
            end
        end

        table.insert(menuList, {text = text, fontObject = font, func = funcWithArgs})
    end

    hanlder.Set = Set
    hanlder.Show = Show
    hanlder.NewLine = NewLine

    return hanlder
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

function S.FormatInteger(int)
    if int >= 1e6 then
        return ("%.1fm"):format(int / 1e6):gsub("%.?0+([km])$", "%1")
    elseif int >= 1e4 then
        return ("%.1fk"):format(int / 1e3):gsub("%.?0+([km])$", "%1")
    else
        return int
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

function S.KillFrame(frame)
    if not frame.UnregisterAllEvents then
        frame.Show = frame.Hide
    else
        frame:SetParent(void)
        frame:UnregisterAllEvents()
    end

    do
        frame:Hide()
    end
end

function S.CreateEventHandler()
    local Handler = CreateFrame("Frame")
    Handler.Event = {}

    local Register = function()
        Handler:UnregisterAllEvents()

        for k, v in pairs(Handler.Event) do
            Handler:RegisterEvent(k, v)
        end
    end

    local OnEvent = function(self, event, ...)
        for k, v in pairs(self.Event) do
            if k == event then
                v(self, event, ...)
                return 0
            end
        end
    end

    Handler:SetScript("OnEvent", OnEvent)
    Handler.Register = Register

    return Handler
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
