pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

// ── Bateria z /sys/class/power_supply ───────────────────────
Singleton {
    id: root

    property int    level:  -1          // %, -1 = brak baterii
    property string status: "Unknown"   // Charging / Discharging / Full / Not charging
    property real   watts:  0           // aktualny pobór/ładowanie
    property real   hours:  -1          // czas do rozładowania / naładowania

    readonly property bool present:  level >= 0
    readonly property bool charging: status === "Charging"

    function fmtHours(h) {
        if (h < 0) return "—"
        const total = Math.round(h * 60)
        const hh = Math.floor(total / 60)
        const mm = total % 60
        return hh > 0 ? hh + " h " + String(mm).padStart(2, "0") + " min" : mm + " min"
    }

    function statusText() {
        if (status === "Charging")    return "Ładowanie"
        if (status === "Discharging") return "Rozładowywanie"
        if (status === "Full")        return "Naładowana"
        if (status === "Not charging") return "Nie ładuje"
        return status
    }

    Timer {
        interval: 15000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: proc.running = true
    }

    Process {
        id: proc
        command: ["sh", "-c",
            "for d in /sys/class/power_supply/BAT*; do cd \"$d\" 2>/dev/null; break; done; " +
            "for f in capacity status power_now current_now voltage_now energy_now energy_full charge_now charge_full; do " +
            "echo \"$f=$(cat $f 2>/dev/null)\"; done"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                const m = {}
                for (const line of text.split("\n")) {
                    const i = line.indexOf("=")
                    if (i > 0) m[line.slice(0, i)] = line.slice(i + 1).trim()
                }

                const cap = parseInt(m.capacity)
                root.level  = isNaN(cap) ? -1 : cap
                root.status = m.status || "Unknown"

                const now  = parseFloat(m.energy_now  || m.charge_now)
                const full = parseFloat(m.energy_full || m.charge_full)
                const rate = parseFloat(m.power_now   || m.current_now)

                if (m.power_now)
                    root.watts = parseFloat(m.power_now) / 1e6
                else if (m.current_now && m.voltage_now)
                    root.watts = parseFloat(m.current_now) * parseFloat(m.voltage_now) / 1e12
                else
                    root.watts = 0

                let h = -1
                if (rate > 0 && !isNaN(now)) {
                    if (root.status === "Charging" && !isNaN(full)) h = (full - now) / rate
                    else if (root.status === "Discharging")          h = now / rate
                }
                root.hours = h
            }
        }
    }
}
