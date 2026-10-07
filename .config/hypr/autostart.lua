-- autostart.lua

hl.on("hyprland.start", function()
    -- From hyprland.lua
    hl.exec_cmd("hyprctl setcursor phinger-cursors 24")
    hl.exec_cmd("STEAM_FORCE_DESKTOPUI_SCALING=1.25 steam")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    
    -- From hyprland-custom.lua
    hl.exec_cmd("env LC_TIME=en_US.UTF-8 noctalia --daemon")
end)
