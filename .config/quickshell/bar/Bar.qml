import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "../"

// ── Główny bar – jeden na każdy monitor ─────────────────────
Scope {
    id: root

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow
            required property var modelData

            // Który popup jest otwarty: "", "calendar", "weather", "media", "audio", "battery"
            property string openPopup: ""

            function toggle(name) { openPopup = (openPopup === name) ? "" : name }
            function closed(name) { if (openPopup === name) openPopup = "" }

            screen:  modelData
            anchors { top: true; left: true; right: true }

            implicitHeight: Theme.barHeight + Theme.barMarginEdge * 2
            color: "transparent"

            Rectangle {
                id: barRect

                anchors {
                    top:    parent.top
                    left:   parent.left
                    right:  parent.right
                    topMargin:   Theme.barMarginEdge
                    leftMargin:  Theme.barMarginEnds
                    rightMargin: Theme.barMarginEnds
                }

                height: Theme.barHeight
                radius: Theme.barRadius
                color:  Theme.bgBar

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin:  Theme.barPaddingH
                    anchors.rightMargin: Theme.barPaddingH
                    spacing: 0

                    // ── LEWA ────────────────────────────────
                    RowLayout {
                        spacing: Theme.spacing
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

                        Pill {
                            icon:      String.fromCodePoint(0xF303)
                            iconColor: Theme.accentPrimary
                            bgColor:   Theme.bgPill
                        }

                        WorkspacesWidget {}
                        ActiveWindowWidget {}
                    }

                    Item { Layout.fillWidth: true }

                    // ── ŚRODEK: czas+data | pogoda | muzyka ──
                    RowLayout {
                        spacing: Theme.spacing
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                        ClockWidget   { onDateClicked: barWindow.toggle("calendar") }
                        WeatherWidget { onClicked:     barWindow.toggle("weather") }
                        MediaWidget   { onClicked:     barWindow.toggle("media") }
                    }

                    Item { Layout.fillWidth: true }

                    // ── PRAWA: sieć | audio | bateria ───────
                    RowLayout {
                        spacing: Theme.spacing
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

                        NetworkWidget {}
                        AudioWidget   { onClicked: barWindow.toggle("audio") }
                        BatteryWidget { onClicked: barWindow.toggle("battery") }
                    }
                }
            }

            // ── Popupy ──────────────────────────────────────
            CalendarPopup {
                parentWindow: barWindow
                open: barWindow.openPopup === "calendar"
                onCloseRequested: barWindow.closed("calendar")
            }

            WeatherPopup {
                parentWindow: barWindow
                open: barWindow.openPopup === "weather"
                onCloseRequested: barWindow.closed("weather")
            }

            MediaPopup {
                parentWindow: barWindow
                open: barWindow.openPopup === "media"
                onCloseRequested: barWindow.closed("media")
            }

            AudioPopup {
                parentWindow: barWindow
                open: barWindow.openPopup === "audio"
                onCloseRequested: barWindow.closed("audio")
            }

            BatteryPopup {
                parentWindow: barWindow
                open: barWindow.openPopup === "battery"
                onCloseRequested: barWindow.closed("battery")
            }
        }
    }
}
