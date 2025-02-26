local _, ns = ...
local L = {}
ns.L = L

setmetatable(L, { __index = function(t, k)
    local v = tostring(k)
    t[k] = v
    return v
end })

-- Global

-- English
L.Version = "%s is the current version." -- ns.version
L.Install = "Thanks for installing version |cff%1$s%2$s|r!" -- ns.color, ns.version
L.TimeString = "Daily quests reset in %s at %s."
L.AddonCompartmentTooltip1 = "|cff" .. ns.color .. "Left-Click:|r Check Reset"
L.AddonCompartmentTooltip2 = "|cff" .. ns.color .. "Right-Click:|r Open Settings"

L.OptionsWhenTooltip = "Sets up an alert for %s the next daily reset." -- string
L.OptionsHowTooltip = "When important alerts go off, they will be accompanied by a %s."
L.Settings = {
    [1] = {
        title = "When do you want to be alerted?",
        options = {
            [1] = {
                key = "alert1Minute",
                name = "1 minute before",
                tooltip = L.OptionsWhenTooltip:format("1 minute before"),
            },
            [2] = {
                key = "alert2Minutes",
                name = "2 minutes before",
                tooltip = L.OptionsWhenTooltip:format("2 minutes before"),
            },
            [3] = {
                key = "alert5Minutes",
                name = "5 minutes before",
                tooltip = L.OptionsWhenTooltip:format("5 minutes before"),
            },
            [4] = {
                key = "alert10Minutes",
                name = "10 minutes before",
                tooltip = L.OptionsWhenTooltip:format("10 minutes before"),
            },
            [5] = {
                key = "alert30Minutes",
                name = "30 minutes before",
                tooltip = L.OptionsWhenTooltip:format("30 minutes before"),
            },
            [6] = {
                key = "alert60Minutes",
                name = "1 hour before",
                tooltip = L.OptionsWhenTooltip:format("1 hour before"),
            },
            [7] = {
                key = "alert120Minutes",
                name = "2 hours before",
                tooltip = L.OptionsWhenTooltip:format("2 hours before"),
            },
        },
    },
    [2] = {
        title = "How do you want to be alerted?",
        options = {
            [1] = {
                key = "printText",
                name = "Chat Messages",
                tooltip = L.OptionsHowTooltip:format("chat message"),
            },
            [2] = {
                key = "raidwarning",
                name = "Raid Warnings",
                tooltip = L.OptionsHowTooltip:format("Raid Warning"),
            },
        },
    },
    [3] = {
        title = "Extra Options:",
        options = {
            [1] = {
                key = "displayOnLogin",
                name = "Display countdown on login",
                tooltip = "Prints the daily reset countdown in the chat box when you log in.",
            },
            [2] = {
                key = "timeFormat",
                name = "Time Format",
                tooltip = "Choose a short or long time formatting.",
                choices = {
                    [1] = ns:DurationFormat(nil, 754, 1),
                    [2] = ns:DurationFormat(nil, 754, 2),
                    [3] = ns:DurationFormat(nil, 754, 3),
                },
            },
        },
    },
}

-- Check locale and apply appropriate changes below
local CURRENT_LOCALE = GetLocale()

-- XXXX
-- if CURRENT_LOCALE == "xxXX" then return end