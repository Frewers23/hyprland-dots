import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../"

// ── Prognoza na tydzień dla Wrocławia ───────────────────────
PopupWindow {
    id: popup

    required property var parentWindow
    property bool open: false
    signal closeRequested()

    anchor.window: parentWindow
    anchor.rect.x: (parentWindow.width - width) / 2
    anchor.rect.y: parentWindow.height
    implicitWidth:  360
    implicitHeight: col.implicitHeight + 28
    visible: open
    color: "transparent"

    onOpenChanged: if (open) Weather.refresh()

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
            spacing: 8

            // ── Aktualna pogoda ─────────────────────────────
            RowLayout {
                Layout.fillWidth: true
                spacing: 14

                Text {
                    text: Weather.iconFor(Weather.code)
                    color: Theme.accentYellow
                    font.pixelSize: 40
                    font.family: Theme.fontFamily
                }

                ColumnLayout {
                    spacing: 0
                    Text {
                        text: Weather.loaded ? Math.round(Weather.temp) + "°C" : "…"
                        color: Theme.textPrimary
                        font.pixelSize: 26
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                    Text {
                        text: Weather.city + " · " + (Weather.loaded ? Weather.descFor(Weather.code) : "ładowanie…")
                        color: Theme.textSecondary
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Theme.bgSurface
            }

            // ── 7 dni ───────────────────────────────────────
            Repeater {
                model: Weather.days

                RowLayout {
                    required property var modelData
                    Layout.fillWidth: true
                    spacing: 10

                    Text {
                        Layout.preferredWidth: 44
                        text: modelData.label
                        color: Theme.textPrimary
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                    Text {
                        Layout.preferredWidth: 48
                        text: modelData.date
                        color: Theme.textMuted
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                    Text {
                        text: Weather.iconFor(modelData.code)
                        color: Theme.accentYellow
                        font.pixelSize: Theme.fontSizeMedium
                        font.family: Theme.fontFamily
                    }
                    Text {
                        Layout.fillWidth: true
                        text: Weather.descFor(modelData.code)
                        elide: Text.ElideRight
                        color: Theme.textSecondary
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                    Text {
                        text: modelData.max + "°"
                        color: Theme.accentPeach
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                    Text {
                        text: modelData.min + "°"
                        color: Theme.accentBlue
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                }
            }
        }
    }
}
