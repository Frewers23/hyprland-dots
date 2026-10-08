import QtQuick
import "../"

// ── Bateria (dane z Battery.qml); klik → szczegóły ──────────
Item {
    id: root

    signal clicked()

    visible: Battery.present
    implicitWidth:  pill.implicitWidth
    implicitHeight: pill.implicitHeight

    Pill {
        id: pill
        clickable: true
        bgColor: Theme.bgSurface

        icon: {
            if (Battery.charging) return String.fromCodePoint(0xF0085)
            const l = Battery.level
            if (l > 90) return String.fromCodePoint(0xF0079)
            if (l > 80) return String.fromCodePoint(0xF0082)
            if (l > 70) return String.fromCodePoint(0xF0081)
            if (l > 60) return String.fromCodePoint(0xF0080)
            if (l > 50) return String.fromCodePoint(0xF007F)
            if (l > 40) return String.fromCodePoint(0xF007E)
            if (l > 30) return String.fromCodePoint(0xF007D)
            if (l > 20) return String.fromCodePoint(0xF007C)
            if (l > 10) return String.fromCodePoint(0xF007B)
            return String.fromCodePoint(0xF007A)
        }

        iconColor: {
            if (Battery.charging)    return Theme.accentGreen
            if (Battery.level <= 15) return Theme.accentRed
            if (Battery.level <= 30) return Theme.accentYellow
            return Theme.textSecondary
        }

        label: Battery.level + "%"
        onClicked: root.clicked()
    }
}
