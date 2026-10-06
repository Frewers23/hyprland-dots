-- rules.lua

hl.window_rule({
    name = "kitty-tiled",
    match = { class = "^(kitty)$" },
    float = false,
    tile = true,
    fullscreen_state = "0 0",
    suppress_event = "maximize",
})

hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.layer_rule({
    name = "bar blur off",
    match = {
        namespace = "noctalia-bar-default",
    },
    blur = false,
    ignore_alpha = 1,
})
