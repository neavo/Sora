-- A pool of objects for determining what text to display for a given cooldown
-- and notify subscribers when the text change

-- local bindings!
local _, Addon = ...

local After = C_Timer.After
local GetTime = GetTime
local GetTickTime = GetTickTime
local max = math.max
local min = math.min
local next = next

-- time units in ms
local DAY = 86400000
local HOUR = 3600000
local MINUTE = 60000
local SECOND = 1000
local TENTHS = 100

-- rounding values in ms
local HALF_DAY = 43200000
local HALF_HOUR = 1800000
local HALF_MINUTE = 30000
local HALF_SECOND = 500
local HALF_TENTHS = 50

-- transition points in ms
local HOURS_THRESHOLD = 84600000 -- 23.5 hours
local MINUTES_THRESHOLD = 3570000 -- 59.5 minutes
local SECONDS_THRESHOLD = 59500 -- 59.5 seconds

-- internal state!
local active = {}

-- we use a weak table so that inactive timers are cleaned up on gc
local inactive = setmetatable({}, {__mode = "k"})

local Timer = {}

Timer.__index = Timer

function Timer:GetOrCreate(cooldown)
    if not cooldown then
        return
    end

    local endTime = cooldown._tcc_start * SECOND + cooldown._tcc_duration * SECOND
    local key = endTime

    local timer = active[key]
    if not timer then
        timer = self:Restore() or self:Create()

        timer.endTime = endTime
        timer.key = key
        timer.subscribers = {}

        active[endTime] = timer
        timer:Update()
    end

    return timer
end

function Timer:Restore()
    local timer = next(inactive)

    if timer then
        inactive[timer] = nil
    end

    return timer
end

function Timer:Create()
    local timer = setmetatable({}, Timer)

    timer.callback = function()
        timer:Update()
    end

    return timer
end

function Timer:Destroy()
    if not self.key then
        return
    end

    active[self.key] = nil

    -- clear subscribers
    for subscriber in pairs(self.subscribers) do
        subscriber:OnTimerDestroyed(self)
    end

    -- reset fields
    self.duration = nil
    self.finished = nil
    self.key = nil
    self.endTime = nil
    self.state = nil
    self.subscribers = nil
    self.text = nil

    inactive[self] = true
end

function Timer:Update()
    if not self.key then
        return
    end

    local remain = self.endTime - (GetTime() * SECOND)
    if remain > 0 then
        local text, textSleep = self:GetTimerText(remain)
        if self.text ~= text then
            self.text = text
            for subscriber in pairs(self.subscribers) do
                subscriber:OnTimerTextUpdated(self, text)
            end
        end

        local state, stateSleep = self:GetTimerState(remain)
        if self.state ~= state then
            self.state = state
            for subscriber in pairs(self.subscribers) do
                subscriber:OnTimerStateUpdated(self, state)
            end
        end

        local sleep = min(textSleep, stateSleep)
        if sleep < math.huge then
            After((sleep + GetTickTime()) / SECOND, self.callback)
        end
    elseif not self.finished then
        self.finished = true
        self:Destroy()
    end
end

function Timer:Subscribe(subscriber)
    if not self.key then
        return
    end

    if not self.subscribers[subscriber] then
        self.subscribers[subscriber] = true
    end
end

function Timer:Unsubscribe(subscriber)
    if not self.key then
        return
    end

    if self.subscribers[subscriber] then
        self.subscribers[subscriber] = nil

        if not next(self.subscribers) then
            self:Destroy()
        end
    end
end

function Timer:GetTimerText(remain)
    local settings = Addon.Config
    local tenthsThreshold = settings.tenthsDuration or 0
    local mmSSThreshold = settings.mmSSDuration or 0

    if remain < tenthsThreshold then
        -- tenths of seconds
        local tenths = (remain + HALF_TENTHS) - (remain + HALF_TENTHS) % TENTHS
        local sleep = remain - (tenths - HALF_TENTHS)

        if tenths > 0 then
            return settings.tenthsFormat:format(tenths / SECOND), sleep
        end

        return "", sleep
    elseif remain < SECONDS_THRESHOLD then
        -- seconds
        local seconds = (remain + HALF_SECOND) - (remain + HALF_SECOND) % SECOND
        local sleep = remain - max(seconds - HALF_SECOND, tenthsThreshold)

        if seconds > 0 then
            return settings.secondsFormat:format(seconds / SECOND), sleep
        end

        return "", sleep
    elseif remain < mmSSThreshold then
        -- MM:SS
        local seconds = (remain + HALF_SECOND) - (remain + HALF_SECOND) % SECOND
        local sleep = remain - max(seconds - HALF_SECOND, SECONDS_THRESHOLD)

        return settings.mmssFormat:format(seconds / MINUTE, (seconds % MINUTE) / SECOND), sleep
    elseif remain < MINUTES_THRESHOLD then
        -- minutes
        local minutes = (remain + HALF_MINUTE) - (remain + HALF_MINUTE) % MINUTE
        local sleep = remain - max(
            -- transition point of showing one minute versus another (29.5s, 89.5s, 149.5s, ...)
            minutes - HALF_MINUTE,
            -- transition point of displaying minutes to displaying seconds (59.5s)
            SECONDS_THRESHOLD,
            -- transition point of displaying MM:SS (user set)
            mmSSThreshold
        )

        return settings.minutesFormat:format(minutes / MINUTE), sleep
    elseif remain < HOURS_THRESHOLD then
        -- hours
        local hours = (remain + HALF_HOUR) - (remain + HALF_HOUR) % HOUR
        local sleep = remain - max(hours - HALF_HOUR, MINUTES_THRESHOLD)

        return settings.hoursFormat:format(hours / HOUR), sleep
    else
        -- days
        local days = (remain + HALF_DAY) - (remain + HALF_DAY) % DAY
        local sleep = remain - max(days - HALF_DAY, HOURS_THRESHOLD)

        return settings.daysFormat:format(days / DAY), sleep
    end
end

function Timer:GetTimerState(remain)
    local settings = Addon.Config

    if settings.enableStyles then
        local expiringDuration = settings.expiringDuration or 0
        if remain < expiringDuration then
            return "soon", math.huge
        elseif remain < SECONDS_THRESHOLD then
            return "seconds", remain - expiringDuration
        elseif remain < MINUTES_THRESHOLD then
            return "minutes", remain - SECONDS_THRESHOLD
        elseif remain < HOURS_THRESHOLD then
            return "hours", remain - MINUTES_THRESHOLD
        else
            return "days", remain - HOURS_THRESHOLD
        end
    else
        return "seconds", math.huge
    end
end

-- exports
Addon.Timer = Timer
