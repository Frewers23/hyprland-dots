import Quickshell
import Quickshell.Io
import QtQuick
import "../"

// ── Sieć: WiFi / Ethernet via nmcli ─────────────────────────

Item {
    id: root
    property string ssid:        "…"
    property string netType:     "unknown"   // wifi | ethernet | none
    property int    signalLevel: 0           // 0-100

    implicitWidth:  netPill.implicitWidth
    implicitHeight: netPill.implicitHeight

    Timer {
        interval: 10000
        running:  true
        repeat:   true
        onTriggered: netProc.running = true
        Component.onCompleted: triggered()
    }

    Process {
        id: netProc
        // nmcli -t -f TYPE,DEVICE,NAME,SIGNAL dev wifi
        command: ["sh", "-c",
            "nmcli -t -f ACTIVE,SSID,SIGNAL dev wifi 2>/dev/null | grep '^yes' | head -1 || echo 'none'"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                const line = text.trim()
                if (line === "none" || line === "") {
                    // Sprawdź ethernet
                    ethProc.running = true
                    return
                }
                // Format: yes:SSID:signal
                const parts = line.split(":")
                root.ssid        = parts[1] ?? "WiFi"
                root.signalLevel = parseInt(parts[2] ?? "0")
                root.netType     = "wifi"
            }
        }
    }

    Process {
        id: ethProc
        command: ["sh", "-c",
            "nmcli -t -f STATE,CONNECTION general 2>/dev/null | head -1 || echo 'none'"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                const line = text.trim()
                if (line.startsWith("connected")) {
                    root.ssid    = "Ethernet"
                    root.netType = "ethernet"
                } else {
                    root.ssid    = "Brak sieci"
                    root.netType = "none"
                }
            }
        }
    }

    Pill {
        id: netPill
        bgColor: Theme.bgSurface

        icon: {
            if (root.netType === "ethernet") return "󰈀"
            if (root.netType === "none")     return "󰤭"
            // WiFi – siła sygnału
            const s = root.signalLevel
            if (s > 75) return "󰤨"
            if (s > 50) return "󰤥"
            if (s > 25) return "󰤢"
            return "󰤟"
        }

        iconColor: root.netType === "none"
            ? Theme.accentRed
            : Theme.accentBlue

        label: root.netType === "wifi" ? root.ssid : ""
    }
}
