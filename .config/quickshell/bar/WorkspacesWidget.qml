import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../"

// ── Workspace buttons – Hyprland IPC ───────────────────────
RowLayout {
    spacing: 3

    Repeater {
        // Pokaż workspace 1–10 (lub te które istnieją)
        model: {
            const ids = []
            for (let i = 1; i <= 10; i++) ids.push(i)
            return ids
        }

        delegate: Rectangle {
            required property int modelData
            readonly property var ws: Hyprland.workspaces.values.find(w => w.id === modelData) ?? null
            readonly property bool isActive:   Hyprland.focusedMonitor?.activeWorkspace?.id === modelData
            readonly property bool hasWindows: ws !== null

            // Nie pokazuj pustych workspaces (poza aktywnym)
            visible: isActive || hasWindows

            implicitWidth:  isActive ? 26 : 18
            implicitHeight: isActive ? 18 : 10
            radius: height / 2

            color: isActive
                ? Theme.accentPrimary
                : Theme.bgSurface

            Behavior on implicitWidth  { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }
            Behavior on implicitHeight { NumberAnimation { duration: 150 } }
            Behavior on color          { ColorAnimation  { duration: 100 } }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("workspace " + modelData)
            }
        }
    }
}
