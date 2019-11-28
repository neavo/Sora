-- Engines
local S, C, L, DB = unpack(select(2, ...))

-- Begin
function S.Dump(target)
    local getIndent, quoteStr, wrapKey, wrapVal, isArray, dumpObj

    getIndent = function(level)
        return string.rep("    ", level)
    end

    quoteStr = function(str)
        str =
            string.gsub(
            str,
            '[%c\\"]',
            {
                ["\t"] = "\\t",
                ["\r"] = "\\r",
                ["\n"] = "\\n",
                ['"'] = '\\"',
                ["\\"] = "\\\\"
            }
        )
        return '"' .. str .. '"'
    end

    wrapKey = function(val)
        if type(val) == "number" then
            return "[" .. val .. "]"
        elseif type(val) == "string" then
            return "[" .. quoteStr(val) .. "]"
        else
            return "[" .. tostring(val) .. "]"
        end
    end

    wrapVal = function(val, level)
        if type(val) == "table" then
            return dumpObj(val, level)
        elseif type(val) == "number" then
            return val
        elseif type(val) == "string" then
            return quoteStr(val)
        else
            return tostring(val)
        end
    end

    isArray = function(arr)
        local count = 0
        for k, v in pairs(arr) do
            count = count + 1
        end
        for i = 1, count do
            if arr[i] == nil then
                return false
            end
        end
        return true, count
    end

    dumpObj = function(obj, level)
        if type(obj) ~= "table" then
            return wrapVal(obj)
        end
        level = level + 1
        local tokens = {}
        tokens[#tokens + 1] = "{"
        local ret, count = isArray(obj)
        if ret then
            for i = 1, count do
                tokens[#tokens + 1] = getIndent(level) .. wrapVal(obj[i], level) .. ","
            end
        else
            for k, v in pairs(obj) do
                tokens[#tokens + 1] = getIndent(level) .. wrapKey(k) .. " = " .. wrapVal(v, level) .. ","
            end
        end
        tokens[#tokens + 1] = getIndent(level - 1) .. "}"
        return table.concat(tokens, "\n")
    end

    return dumpObj(target, 0)
end

--[[
print_dump是一个用于调试输出数据的函数，能够打印出nil,boolean,number,string,table类型的数据，以及table类型值的元表
参数data表示要输出的数据
参数showMetatable表示是否要输出元表
参数lastCount用于格式控制，用户请勿使用该变量
]]
function S.Dump(data, showMetatable, lastCount)

end

function S.MakeText(parent, size)
    local Text = parent:CreateFontString(nil, "ARTWORK")
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

function S.RGBToHex(r, g, b)
    if r then
        if type(r) == "table" then
            if r.r then
                r, g, b = r.r, r.g, r.b
            else
                r, g, b = unpack(r)
            end
        end
        return ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
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
