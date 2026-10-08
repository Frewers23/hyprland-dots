import QtQuick
import "../"

// ── Własny suwak głośności ──────────────────────────────────
Item {
    id: root

    property real value: 0              // 0.0 – 1.0
    signal moved(real v)

    implicitWidth:  120
    implicitHeight: 22

    readonly property real clamped: Math.max(0, Math.min(1, value))

    Rectangle {
        id: track
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 6
        radius: 3
        color: Theme.bgHover

        Rectangle {
            width: parent.width * root.clamped
            height: parent.height
            radius: 3
            color: Theme.accentPrimary
        }
    }

    Rectangle {
        id: handle
        width: 16
        height: 16
        radius: 8
        anchors.verticalCenter: parent.verticalCenter
        x: Math.max(0, Math.min(root.width - width, root.width * root.clamped - width / 2))
        color: Theme.textPrimary
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        onPressed:         (m) => root.moved(Math.max(0, Math.min(1, m.x / root.width)))
        onPositionChanged: (m) => { if (pressed) root.moved(Math.max(0, Math.min(1, m.x / root.width))) }
    }

    WheelHandler {
        onWheel: (e) => root.moved(Math.max(0, Math.min(1, root.clamped + (e.angleDelta.y > 0 ? 0.05 : -0.05))))
    }
}
