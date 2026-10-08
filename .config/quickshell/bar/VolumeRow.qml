import QtQuick
import QtQuick.Layouts
import "../"

// ── Karta z suwakiem głośności (Output / Input / aplikacja) ──
Rectangle {
    id: root

    property string title: ""
    property string subtitle: ""
    property real   volume: 0
    property bool   muted: false
    property string iconOn: ""
    property string iconOff: ""

    signal volumeRequested(real v)
    signal muteRequested()

    radius: 14
    color: Theme.bgSurface
    implicitWidth: 200
    implicitHeight: inner.implicitHeight + 24

    ColumnLayout {
        id: inner
        anchors.fill: parent
        anchors.margins: 12
        spacing: 6

        Text {
            Layout.fillWidth: true
            text: root.title
            elide: Text.ElideRight
            color: Theme.textPrimary
            font.pixelSize: Theme.fontSizeMedium
            font.family: Theme.fontFamily
            font.weight: Theme.fontWeight
        }

        Text {
            Layout.fillWidth: true
            visible: root.subtitle !== ""
            text: root.subtitle
            elide: Text.ElideRight
            color: Theme.textSecondary
            font.pixelSize: Theme.fontSizeSmall
            font.family: Theme.fontFamily
            font.weight: Theme.fontWeight
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            VolumeSlider {
                Layout.fillWidth: true
                value: root.volume
                onMoved: (v) => root.volumeRequested(v)
            }

            Text {
                Layout.preferredWidth: 46
                horizontalAlignment: Text.AlignRight
                text: root.muted ? "mute" : Math.round(root.volume * 100) + "%"
                color: root.muted ? Theme.accentRed : Theme.textPrimary
                font.pixelSize: Theme.fontSizeSmall
                font.family: Theme.fontFamily
                font.weight: Theme.fontWeight
            }

            IconButton {
                text: root.muted ? root.iconOff : root.iconOn
                baseColor: root.muted ? Theme.accentRed : Theme.accentGreen
                onClicked: root.muteRequested()
            }
        }
    }
}
