local ADDON_NAME, ns = ...
local L = ns.L

local CT = C_Timer

---
-- Local Functions
---

local function SecondsUntil()
    return GetQuestResetTime() + 1
end

---
-- Namespaced Functions
---

--- Sets default options if they are not already set
function ns:SetOptionDefaults()
    DRC_options = DRC_options or {}
    for option, default in pairs(ns.data.defaults) do
        ns:SetOptionDefault(DRC_options, option, default)
    end
end

--- Set timers
function ns:SetTimers()
    local secondsUntil = SecondsUntil()

    -- Set Pre-Defined Alerts
    for option, minutes in pairs(ns.data.timers) do
        if secondsUntil >= (minutes * 60) then
            CT.After(secondsUntil - (minutes * 60), function()
                if ns:OptionValue(DRC_options, option) then
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
    local time = ns:TimeFormat(now + secondsUntil)
    local message = "|cff" .. ns.color .. L.TimeString:format(ns:DurationFormat(DRC_options, secondsUntil), time) .. "|r"
    if ns:OptionValue(DRC_options, "printText") then
        print(message)
    end
    if ns:OptionValue(DRC_options, "raidwarning") then
        RaidNotice_AddMessage(RaidWarningFrame, message, ChatTypeInfo["RAID_WARNING"])
    end
end
