import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../"

// ── Szczegóły baterii ───────────────────────────────────────
PopupWindow {
    id: popup

    required property var parentWindow
    property bool open: false
    signal closeRequested()

    readonly property color levelColor:
        Battery.charging ? Theme.accentGreen
        : Battery.level <= 15 ? Theme.accentRed
        : Battery.level <= 30 ? Theme.accentYellow
        : Theme.accentBlue

    anchor.window: parentWindow
    anchor.rect.x: parentWindow.width - width - Theme.barMarginEnds
    anchor.rect.y: parentWindow.height
    implicitWidth:  300
    implicitHeight: col.implicitHeight + 28
    visible: open
    color: "transparent"

    HyprlandFocusGrab {
        windows: [popup, popup.parentWindow]
        active: popup.open
        onCleared: popup.closeRequested()
    }

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: Theme.bgBase
        border.color: Theme.bgSurface
        border.width: 1

        ColumnLayout {
            id: col
            anchors.fill: parent
            anchors.margins: 14
            spacing: 10

            RowLayout {
                spacing: 12

                Text {
                    text: Battery.charging ? String.fromCodePoint(0xF0085) : String.fromCodePoint(0xF0079)
                    color: popup.levelColor
                    font.pixelSize: 36
                    font.family: Theme.fontFamily
                }
                Text {
                    text: Battery.level + "%"
                    color: Theme.textPrimary
                    font.pixelSize: 30
                    font.family: Theme.fontFamily
                    font.weight: Theme.fontWeight
                }
            }

            // Pasek poziomu
            Rectangle {
                Layout.fillWidth: true
                height: 8
                radius: 4
                color: Theme.bgSurface

                Rectangle {
                    width: parent.width * Math.max(0, Battery.level) / 100
                    height: parent.height
                    radius: 4
                    color: popup.levelColor
                }
            }

            Repeater {
                model: [
                    { k: "Stan",      v: Battery.statusText() },
                    { k: Battery.charging ? "Do pełna" : "Pozostało", v: Battery.fmtHours(Battery.hours) },
                    { k: "Moc",       v: Battery.watts > 0 ? Battery.watts.toFixed(1) + " W" : "—" }
                ]

                RowLayout {
                    required property var modelData
                    Layout.fillWidth: true

                    Text {
                        text: modelData.k
                        color: Theme.textSecondary
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                    Item { Layout.fillWidth: true }
                    Text {
                        text: modelData.v
                        color: Theme.textPrimary
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                }
            }
        }
    }
}
