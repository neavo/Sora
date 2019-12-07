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
    local Text = parent:CreateFontString(nil, "ARTWORK")
    Text:SetShadowOffset(1, -1)
    Text:SetShadowColor(0, 0, 0, 0.5)
    Text:SetFont(STANDARD_TEXT_FONT, (C.Core and C.Core.FontScale) and C.Core.FontScale * size or size, "OUTLINE")

    return Text
end

function S.MakeBorder(parent, size)
    local Border = CreateFrame("Frame", nil, parent)
    Border:SetFrameLevel(0)
    Border:SetPoint("TOPLEFT", -size, size)
    Border:SetPoint("BOTTOMRIGHT", size, -size)
    Border:SetBackdropBorderColor(0, 0, 0, size)
    Border:SetBackdrop({edgeFile = DB.Solid, edgesize = size})

    return Border
end

function S.MakeShadow(parent, size)
    local Shadow = CreateFrame("Frame", nil, parent)
    Shadow:SetFrameLevel(0)
    Shadow:SetPoint("TOPLEFT", parent, -size, size)
    Shadow:SetPoint("BOTTOMRIGHT", parent, size, -size)
    Shadow:SetBackdrop(
        {
            edgeSize = size,
            edgeFile = DB.GlowTex
        }
    )
    Shadow:SetBackdropBorderColor(0, 0, 0, 1)

    return Shadow
end

function S.MakeTextureShadow(parent, anchor, size)
    local Shadow = CreateFrame("Frame", nil, parent)
    Shadow:SetFrameLevel(1)
    Shadow:SetPoint("TOPLEFT", anchor, -size, size)
    Shadow:SetPoint("BOTTOMRIGHT", anchor, size, -size)
    Shadow:SetBackdrop(
        {
            edgeSize = size,
            edgeFile = DB.GlowTex
        }
    )
    Shadow:SetBackdropBorderColor(0, 0, 0, 1)

    return Shadow
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
    if not Short then
        if Time > 86400 then
            return Day .. "d " .. Hour .. "m"
        elseif Time > 3600 then
            return Hour .. "h " .. Minute .. "m"
        elseif Time < 3600 and Time > 60 then
            return Minute .. "m " .. Second .. "s"
        elseif Time < 60 and Time > 0 then
            return Second .. "s"
        else
            return "N/A"
        end
    else
        if Time > 86400 then
            return Day .. "d"
        elseif Time > 3600 then
            return Hour .. "h"
        elseif Time < 3600 and Time > 60 then
            return Minute .. "m"
        elseif Time < 60 and Time > 0 then
            return Second .. "s"
        else
            return "N/A"
        end
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

    frame:Hide()
end

function S.CreateEventHandler()
    local Handler = CreateFrame("Frame")
    Handler.Event = {}

    local RegisterAllEvents = function()
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
    Handler.RegisterAllEvents = RegisterAllEvents

    return Handler
end

function S.CreateTimerHandler()
    local Handler = CreateFrame("Frame")
    Handler.timer = 0.00

    local OnUpdate = function(self, elapsed, ...)
        if not self.Interval or not self.OnUpdate then
            return 0
        end

        self.timer = self.timer + elapsed
        if self.timer > self.Interval then
            self.timer = 0.00

            self.OnUpdate(self, elapsed, ...)
        end
    end

    Handler:SetScript("OnUpdate", OnUpdate)

    return Handler
end
