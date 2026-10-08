import Quickshell
import Quickshell.Hyprland
import QtQuick
import "../"

// ── Aktywne okno: ikona klasy + tytuł ──────────────────────
Pill {
    readonly property var focused: Hyprland.focusedClient

    visible: focused !== null

    // Skróć tytuł jeśli za długi
    label: {
        const title = focused?.title ?? ""
        return title.length > 40 ? title.slice(0, 38) + "…" : title
    }

    icon: {
        const cls = (focused?.resourceClass ?? "").toLowerCase()
        const map = {
            "firefox":          "󰈹",
            "chromium":         "󰊯",
            "google-chrome":    "󰊯",
            "kitty":            "",
            "alacritty":        "",
            "foot":             "󱃖",
            "wezterm":          "",
            "thunar":           "󰉋",
            "nautilus":         "󰉋",
            "code":             "󰨞",
            "code-oss":         "󰨞",
            "obsidian":         "󰇿",
            "discord":          "󰙯",
            "telegram-desktop": "",
            "spotify":          "",
            "vlc":              "󰕼",
            "mpv":              "",
            "gimp-2.10":        "",
            "inkscape":         "",
        }
        return map[cls] ?? "󰀈"
    }

    iconColor: Theme.accentBlue
    bgColor:   Theme.bgSurface
}
