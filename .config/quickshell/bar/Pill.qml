import QtQuick
import QtQuick.Layouts
import "../"

// ── Pomocniczy komponent "pigułka" używany przez widgety ────
Rectangle {
    id: root

    property string icon:      ""
    property string label:     ""
    property color  iconColor:  Theme.accentPrimary
    property color  textColor:  Theme.textPrimary
    property color  bgColor:    Theme.bgSurface
    property bool   clickable:  false
    signal clicked()

    implicitHeight: Theme.barHeight - 8
    implicitWidth:  contentRow.implicitWidth + Theme.pillPaddingH * 2
    radius: Theme.pillRadius
    color:  bgColor

    Behavior on color { ColorAnimation { duration: 120 } }

    RowLayout {
        id: contentRow
        anchors.centerIn: parent
        spacing: 5

        Text {
            visible: root.icon !== ""
            text:    root.icon
            color:   root.iconColor
            font.pixelSize: Theme.fontSizeMedium
            font.family:    Theme.fontFamily
            font.weight:    Theme.fontWeight
        }

        Text {
            visible: root.label !== ""
            text:    root.label
            color:   root.textColor
            font.pixelSize: Theme.fontSizeSmall
            font.family:    Theme.fontFamily
            font.weight:    Theme.fontWeight
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled:      root.clickable
        cursorShape:  Qt.PointingHandCursor
        hoverEnabled: true
        onEntered:  root.color = Theme.bgHover
        onExited:   root.color = root.bgColor
        onClicked:  root.clicked()
    }
}
