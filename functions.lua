local ADDON_NAME, ns = ...
local L = ns.L

local CT = C_Timer

---
-- Local Functions
---

--- Toggles a feature with a specified timeout
-- @param {string} toggle
-- @param {number} timeout
local function Toggle(toggle, timeout)
    if not ns.data.toggles[toggle] then
        ns.data.toggles[toggle] = true
        CT.After(math.max(timeout, 0), function()
            ns.data.toggles[toggle] = false
        end)
    end
end

-- Set default values for options which are not yet set.
-- @param {string} option
-- @param {any} default
local function RegisterDefaultOption(option, default)
    if DRC_options[ns.prefix .. option] == nil then
        DRC_options[ns.prefix .. option] = default
    end
end

--- Formats a duration in seconds to a "Xh Xm XXs" string
-- @param {number} duration
-- @param {boolean} long
-- @return {string}
local function Duration(duration)
    local long = ns:OptionValue("timeFormat") == 2
    local hours = math.floor(duration / 3600)
    local minutes = math.floor(math.fmod(duration, 3600) / 60)
    local seconds = math.fmod(duration, 60)
    local h = long and (" hour" .. (hours > 1 and "s" or "")) or "h"
    local m = long and (" minute" .. (minutes > 1 and "s" or "")) or "m"
    local s = long and (" second" .. (seconds > 1 and "s" or "")) or "s"
    if hours > 0 then
        if minutes > 0 then
            return string.format("%d" .. h .. " %d" .. m, hours, minutes)
        end
        return string.format("%d" .. h, hours)
    end
    if minutes > 0 then
        if seconds > 0 then
            return string.format("%d" .. m .. " %d" .. s, minutes, seconds)
        end
        return string.format("%d" .. m, minutes)
    end
    return string.format("%d" .. s, seconds)
end

--- Format a timestamp to a local time string
-- @param {number} timestamp
-- @return {string}
local function TimeFormat(timestamp, includeSeconds)
    local useMilitaryTime = GetCVar("timeMgrUseMilitaryTime") == "1"
    local timeFormat = useMilitaryTime and ("%H:%M" .. (includeSeconds and ":%S" or "")) or ("%I:%M" .. (includeSeconds and ":%S" or "") .. "%p")
    local time = date(timeFormat, timestamp)

    -- Remove starting zero from non-military time
    if not useMilitaryTime then
        time = time:gsub("^0", ""):lower()
    end

    return time
end

local function SecondsUntil()
    return GetQuestResetTime() + 1
end

local function DisplayTimer()
    local time = TimeFormat(now + secondsUntil)
    print("|cff" .. ns.color .. L.TimeString:format(Duration(secondsUntil), time) .. "|r")
end

---
-- Namespaced Functions
---

--- Returns an option from the options table
function ns:OptionValue(option)
    return DRC_options[ns.prefix .. option]
end

--- Sets default options if they are not already set
function ns:SetDefaultOptions()
    DRC_options = DRC_options or {}
    for option, default in pairs(ns.data.defaults) do
        RegisterDefaultOption(option, default)
    end
end

--- Prints a formatted message to the chat
-- @param {string} message
function ns:PrettyPrint(message)
    DEFAULT_CHAT_FRAME:AddMessage("|cff" .. ns.color .. ns.name .. "|r " .. message)
end

--- Opens the Addon settings menu
function ns:OpenSettings()
    Settings.OpenToCategory(ns.Settings:GetID())
end

--- Set timers
function ns:SetTimers()
    local secondsUntil = SecondsUntil()

    -- Set Pre-Defined Alerts
    for option, minutes in pairs(ns.data.timers) do
        if secondsUntil >= (minutes * 60) then
            CT.After(secondsUntil - (minutes * 60), function()
                if ns:OptionValue(option) then
                    ns:ResetCheck()
                end
            end)
        end
    end

    -- Restart the timer after the reset
    CT.After(secondsUntil + 1, function()
        ns:SetTimers()
    end)
end

--- Checks the timer's state
function ns:ResetCheck()
    local now = GetServerTime()
    local secondsUntil = SecondsUntil()
    local time = TimeFormat(now + secondsUntil)
    local message = "|cff" .. ns.color .. L.TimeString:format(Duration(secondsUntil), time) .. "|r"
    if ns:OptionValue("printText") then
        print(message)
    end
    if ns:OptionValue("raidwarning") then
        RaidNotice_AddMessage(RaidWarningFrame, message, ChatTypeInfo["RAID_WARNING"])
    end
end
