pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

// ── Pogoda dla Wrocławia (Open-Meteo, bez API key) ──────────
Singleton {
    id: root

    readonly property string city:      "Wrocław"
    readonly property real   latitude:  51.1079
    readonly property real   longitude: 17.0385

    property bool loaded: false
    property real temp:   0
    property int  code:   0
    property var  days:   []      // [{ label, code, max, min }]

    readonly property string url:
        "https://api.open-meteo.com/v1/forecast"
        + "?latitude=" + latitude + "&longitude=" + longitude
        + "&current=temperature_2m,weather_code"
        + "&daily=weather_code,temperature_2m_max,temperature_2m_min"
        + "&timezone=Europe%2FWarsaw&forecast_days=7"

    readonly property var weekdays: ["Nd", "Pn", "Wt", "Śr", "Cz", "Pt", "So"]

    function glyph(cp) { return String.fromCodePoint(cp) }

    // Ikony Nerd Font (Material Design Icons)
    function iconFor(c) {
        if (c === 0)                 return glyph(0xF0599)  // słońce
        if (c <= 2)                  return glyph(0xF0595)  // częściowe zachmurzenie
        if (c === 3)                 return glyph(0xF0590)  // pochmurno
        if (c === 45 || c === 48)    return glyph(0xF0591)  // mgła
        if (c >= 51 && c <= 57)      return glyph(0xF0597)  // mżawka
        if (c >= 61 && c <= 65)      return glyph(0xF0597)  // deszcz
        if (c === 66 || c === 67)    return glyph(0xF067F)  // marznący deszcz
        if (c >= 71 && c <= 77)      return glyph(0xF0598)  // śnieg
        if (c >= 80 && c <= 82)      return glyph(0xF0596)  // przelotny deszcz
        if (c === 85 || c === 86)    return glyph(0xF0598)  // przelotny śnieg
        if (c >= 95)                 return glyph(0xF067E)  // burza
        return glyph(0xF0590)
    }

    function descFor(c) {
        if (c === 0)                 return "Bezchmurnie"
        if (c === 1)                 return "Prawie bezchmurnie"
        if (c === 2)                 return "Częściowe zachmurzenie"
        if (c === 3)                 return "Pochmurno"
        if (c === 45 || c === 48)    return "Mgła"
        if (c >= 51 && c <= 57)      return "Mżawka"
        if (c >= 61 && c <= 65)      return "Deszcz"
        if (c === 66 || c === 67)    return "Marznący deszcz"
        if (c >= 71 && c <= 77)      return "Śnieg"
        if (c >= 80 && c <= 82)      return "Przelotny deszcz"
        if (c === 85 || c === 86)    return "Przelotny śnieg"
        if (c >= 95)                 return "Burza"
        return "—"
    }

    function refresh() { fetch.running = true }

    Timer {
        interval: 1800000          // co 30 min
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.refresh()
    }

    Process {
        id: fetch
        command: ["curl", "-sf", "--max-time", "15", root.url]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const j = JSON.parse(text)
                    root.temp = j.current.temperature_2m
                    root.code = j.current.weather_code

                    const d = j.daily
                    const out = []
                    for (let i = 0; i < d.time.length; i++) {
                        const dt = new Date(d.time[i] + "T12:00:00")
                        out.push({
                            label: i === 0 ? "Dziś" : root.weekdays[dt.getDay()],
                            date:  dt.getDate() + "." + String(dt.getMonth() + 1).padStart(2, "0"),
                            code:  d.weather_code[i],
                            max:   Math.round(d.temperature_2m_max[i]),
                            min:   Math.round(d.temperature_2m_min[i])
                        })
                    }
                    root.days = out
                    root.loaded = true
                } catch (e) {
                    console.warn("Weather: błąd parsowania odpowiedzi: " + e)
                }
            }
        }
    }
}
