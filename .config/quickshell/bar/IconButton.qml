import QtQuick
import "../"

// ── Klikalna ikona (przycisk tekstowy) ──────────────────────
Text {
    id: root

    signal clicked()
    property color baseColor: Theme.textPrimary
    property color hoverColor: Theme.accentPrimary

    color: area.containsMouse ? hoverColor : baseColor
    font.pixelSize: Theme.fontSizeMedium
    font.family: Theme.fontFamily
    font.weight: Theme.fontWeight
    verticalAlignment: Text.AlignVCenter

    MouseArea {
        id: area
        anchors.fill: parent
        anchors.margins: -4
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
