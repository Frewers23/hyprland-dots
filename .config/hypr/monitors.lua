-- monitors.lua

-- Specific monitor
hl.monitor({
    output = "eDP-1",
    disabled = false,
    mode = "2560x1440@240.00Hz",
    position = "0x0",
    scale = 1.25,
    cm = "srgb",
})

-- Fallback for any other output
hl.monitor({
    output = "",
    mode = "2560x1440@240",
    position = "0x0",
    scale = "1.25",
})
