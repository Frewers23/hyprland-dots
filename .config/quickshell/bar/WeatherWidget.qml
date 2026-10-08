import QtQuick
import "../"

// ── Pigułka pogody (dane z Weather.qml – Wrocław) ───────────
Item {
    id: root
    signal clicked()

    implicitWidth:  pill.implicitWidth
    implicitHeight: pill.implicitHeight

    Pill {
        id: pill
        icon:  Weather.loaded ? Weather.iconFor(Weather.code) : Weather.iconFor(3)
        label: Weather.loaded ? Math.round(Weather.temp) + "°C" : "…"
        iconColor: Theme.accentYellow
        bgColor:   Theme.bgSurface
        clickable: true
        onClicked: root.clicked()
    }
}
