import QtQuick
import QtQuick.Layouts
import "../"

// ── Media player w pasku: ⏮ ⏯ ⏭ + tytuł (klik → panel, scroll → głośność) ──
Rectangle {
    id: root

    signal clicked()

    visible: Media.active
    implicitHeight: Theme.barHeight - 8
    implicitWidth: row.implicitWidth + Theme.pillPaddingH * 2
    radius: Theme.pillRadius
    color: Theme.bgSurface

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 10

        IconButton {
            text: String.fromCodePoint(0xF04AE)
            onClicked: Media.previous()
        }

        IconButton {
            text: Media.playing ? String.fromCodePoint(0xF03E4) : String.fromCodePoint(0xF040A)
            baseColor: Media.playing ? Theme.accentGreen : Theme.accentYellow
            onClicked: Media.togglePlaying()
        }

        IconButton {
            text: String.fromCodePoint(0xF04AD)
            onClicked: Media.next()
        }

        Text {
            id: titleText
            Layout.maximumWidth: 260
            elide: Text.ElideRight
            color: Theme.textPrimary
            font.pixelSize: Theme.fontSizeSmall
            font.family: Theme.fontFamily
            font.weight: Theme.fontWeight
            text: {
                const t = Media.artist !== "" && Media.title !== ""
                    ? Media.artist + " – " + Media.title
                    : (Media.title !== "" ? Media.title : Media.artist)
                return t !== "" ? t : "—"
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.clicked()
            }
        }
    }

    // Scroll nad widgetem = głośność odtwarzacza
    WheelHandler {
        onWheel: (e) => Media.changeVolume(e.angleDelta.y > 0 ? 0.05 : -0.05)
    }
}
