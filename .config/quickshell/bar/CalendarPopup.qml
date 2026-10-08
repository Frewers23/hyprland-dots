import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../"

// ── Kalendarz miesięczny (tydzień zaczyna się od poniedziałku) ──
PopupWindow {
    id: popup

    required property var parentWindow
    property bool open: false
    signal closeRequested()

    property var today: new Date()
    property int viewYear:  today.getFullYear()
    property int viewMonth: today.getMonth()

    readonly property var monthNames: [
        "Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec",
        "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"
    ]
    readonly property var dayNames: ["Pn", "Wt", "Śr", "Cz", "Pt", "So", "Nd"]

    // przesunięcie pierwszego dnia miesiąca (0 = poniedziałek)
    readonly property int offset: (new Date(viewYear, viewMonth, 1).getDay() + 6) % 7
    readonly property int daysInMonth: new Date(viewYear, viewMonth + 1, 0).getDate()

    function shiftMonth(delta) {
        let m = viewMonth + delta
        let y = viewYear
        while (m < 0)  { m += 12; y-- }
        while (m > 11) { m -= 12; y++ }
        viewMonth = m
        viewYear  = y
    }

    onOpenChanged: if (open) {
        today     = new Date()
        viewYear  = today.getFullYear()
        viewMonth = today.getMonth()
    }

    anchor.window: parentWindow
    anchor.rect.x: (parentWindow.width - width) / 2
    anchor.rect.y: parentWindow.height
    implicitWidth:  320
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
            spacing: 8

            // ── Nagłówek: ‹ Miesiąc Rok › ───────────────────
            RowLayout {
                Layout.fillWidth: true

                Pill {
                    icon: "‹"
                    iconColor: Theme.accentPrimary
                    clickable: true
                    implicitWidth: 32
                    onClicked: popup.shiftMonth(-1)
                }

                Text {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: popup.monthNames[popup.viewMonth] + " " + popup.viewYear
                    color: Theme.textPrimary
                    font.pixelSize: Theme.fontSizeMedium
                    font.family: Theme.fontFamily
                    font.weight: Theme.fontWeight
                }

                Pill {
                    icon: "›"
                    iconColor: Theme.accentPrimary
                    clickable: true
                    implicitWidth: 32
                    onClicked: popup.shiftMonth(1)
                }
            }

            // ── Dni tygodnia ────────────────────────────────
            GridLayout {
                columns: 7
                columnSpacing: 0
                rowSpacing: 0
                Layout.alignment: Qt.AlignHCenter

                Repeater {
                    model: popup.dayNames
                    Text {
                        required property string modelData
                        Layout.preferredWidth: 40
                        horizontalAlignment: Text.AlignHCenter
                        text: modelData
                        color: Theme.textMuted
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                }
            }

            // ── Siatka dni (6 tygodni) ──────────────────────
            GridLayout {
                columns: 7
                columnSpacing: 0
                rowSpacing: 2
                Layout.alignment: Qt.AlignHCenter

                Repeater {
                    model: 42
                    Rectangle {
                        id: cell
                        required property int index
                        readonly property int  day:   index - popup.offset + 1
                        readonly property bool valid: day >= 1 && day <= popup.daysInMonth
                        readonly property bool isToday: valid
                            && day === popup.today.getDate()
                            && popup.viewMonth === popup.today.getMonth()
                            && popup.viewYear  === popup.today.getFullYear()
                        readonly property bool weekend: index % 7 >= 5

                        Layout.preferredWidth:  40
                        Layout.preferredHeight: 32
                        radius: 10
                        color: isToday ? Theme.accentPrimary : "transparent"

                        Text {
                            anchors.centerIn: parent
                            visible: cell.valid
                            text: cell.day
                            color: cell.isToday ? Theme.bgBase
                                 : cell.weekend ? Theme.accentRed
                                 : Theme.textPrimary
                            font.pixelSize: Theme.fontSizeSmall
                            font.family: Theme.fontFamily
                            font.weight: Theme.fontWeight
                        }
                    }
                }
            }
        }
    }
}
