local _, ns = ...

ns.data = {
    defaults = {
        alert1Minute =  true,
        alert2Minutes =  true,
        alert5Minutes =  true,
        alert10Minutes =  true,
        alert30Minutes =  true,
        alert60Minutes = true,
        alert120Minutes = true,
        printText = true,
        raidwarning = true,
        displayOnLogin = true,
        timeFormat = 3,
    },
    timers = {
        alert1Minute = 1,
        alert2Minutes = 2,
        alert5Minutes = 5,
        alert10Minutes = 10,
        alert30Minutes = 30,
        alert60Minutes = 60,
    },
    timeouts = {
        short = 10,
        long = 300,
    },
    toggles = {
        recentlyOutput = false,
        timerActive = false,
    },
}
