import QtQuick
import "../"

// ── Czas i data w jednej kapsułce (klik → kalendarz) ────────
Pill {
    id: root

    signal dateClicked()

    icon: String.fromCodePoint(0xF00F0)
    iconColor: Theme.accentPrimary
    bgColor: Theme.bgSurface
    clickable: true
    onClicked: root.dateClicked()

    label: ""

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            const now = new Date()
            root.label = Qt.formatTime(now, "HH:mm") + "  ·  " + Qt.formatDate(now, "ddd, d MMM")
        }
    }
}
