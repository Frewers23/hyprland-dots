import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../"

// ── Odtwarzacz muzyki: okładka, tytuł, sterowanie, głośność ──
PopupWindow {
    id: popup

    required property var parentWindow
    property bool open: false
    signal closeRequested()

    anchor.window: parentWindow
    anchor.rect.x: (parentWindow.width - width) / 2
    anchor.rect.y: parentWindow.height
    implicitWidth:  400
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
            spacing: 12

            RowLayout {
                Layout.fillWidth: true
                spacing: 14

                Image {
                    Layout.preferredWidth: 96
                    Layout.preferredHeight: 96
                    source: Media.artUrl
                    fillMode: Image.PreserveAspectCrop
                    visible: Media.artUrl !== ""
                    asynchronous: true
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 2

                    Text {
                        Layout.fillWidth: true
                        text: Media.title !== "" ? Media.title : "Nic nie gra"
                        elide: Text.ElideRight
                        color: Theme.textPrimary
                        font.pixelSize: Theme.fontSizeMedium + 2
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }
                    Text {
                        Layout.fillWidth: true
                        text: Media.artist
                        elide: Text.ElideRight
                        color: Theme.textSecondary
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }

                    // ── Sterowanie ──────────────────────────
                    RowLayout {
                        Layout.topMargin: 8
                        spacing: 22

                        IconButton {
                            text: String.fromCodePoint(0xF04AE)
                            font.pixelSize: 24
                            onClicked: Media.previous()
                        }
                        IconButton {
                            text: Media.playing ? String.fromCodePoint(0xF03E4) : String.fromCodePoint(0xF040A)
                            font.pixelSize: 30
                            baseColor: Theme.accentPrimary
                            onClicked: Media.togglePlaying()
                        }
                        IconButton {
                            text: String.fromCodePoint(0xF04AD)
                            font.pixelSize: 24
                            onClicked: Media.next()
                        }
                    }
                }
            }

            // ── Głośność odtwarzacza ────────────────────────
            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Text {
                    text: String.fromCodePoint(0xF057E)
                    color: Media.volumeSupported ? Theme.accentGreen : Theme.textMuted
                    font.pixelSize: Theme.fontSizeMedium
                    font.family: Theme.fontFamily
                }

                VolumeSlider {
                    Layout.fillWidth: true
                    enabled: Media.volumeSupported
                    opacity: enabled ? 1 : 0.4
                    value: Media.volume
                    onMoved: (v) => Media.setVolume(v)
                }

                Text {
                    Layout.preferredWidth: 46
                    horizontalAlignment: Text.AlignRight
                    text: Media.volumeSupported ? Math.round(Media.volume * 100) + "%" : "—"
                    color: Theme.textPrimary
                    font.pixelSize: Theme.fontSizeSmall
                    font.family: Theme.fontFamily
                    font.weight: Theme.fontWeight
                }
            }
        }
    }
}
