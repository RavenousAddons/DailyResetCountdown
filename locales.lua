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
L.Units = {
    hour = {
        s = "hour",
        p = "hours",
        a = "hr.",
        t = "h",
    },
    minute = {
        s = "minute",
        p = "minutes",
        a = "min.",
        t = "m",
    },
    second = {
        s = "second",
        p = "seconds",
        a = "sec.",
        t = "s",
    },
}
L.AddonCompartmentTooltip1 = "|cff" .. ns.color .. "Left-Click:|r Check Reset"
L.AddonCompartmentTooltip2 = "|cff" .. ns.color .. "Right-Click:|r Open Settings"
L.OptionsTitle1 = "When do you want to be alerted?"
L.OptionsWhenTooltip = "Sets up an alert for %s the next daily reset." -- string
L.OptionsWhen = {
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
}
L.OptionsTitle2 = "How do you want to be alerted?"
L.OptionsHowTooltip = "When important alerts go off, they will be accompanied by a %s."
L.OptionsHow = {
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
}
L.OptionsTitle3 = "Extra Options:"
L.OptionsExtra = {
    [1] = {
        key = "displayOnLogin",
        name = "Display countdown on login",
        tooltip = "Prints the daily reset countdown in the chat box when you log in.",
    },
    [2] = {
        key = "timeFormat",
        name = "Time Format",
        tooltip = "Choose a short or long time formatting.",
        fn = function()
            local container = Settings.CreateControlTextContainer()
            container:Add(1, "12" .. L.Units.minute.t .. " 34" .. L.Units.second.t)
            container:Add(2, "12 " .. L.Units.minute.a .. " 34 " .. L.Units.second.a)
            container:Add(3, "12 " .. L.Units.minute.p .. " 34 " .. L.Units.second.p)
            return container:GetData()
        end,
    },
}

-- Check locale and apply appropriate changes below
local CURRENT_LOCALE = GetLocale()

-- XXXX
-- if CURRENT_LOCALE == "xxXX" then return end