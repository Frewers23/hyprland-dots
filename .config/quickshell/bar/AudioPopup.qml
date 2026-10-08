import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "../"

// ── Panel audio: Output / Input / głośność aplikacji ────────
PopupWindow {
    id: popup

    required property var parentWindow
    property bool open: false
    signal closeRequested()

    readonly property var sink:   Pipewire.defaultAudioSink
    readonly property var source: Pipewire.defaultAudioSource
    readonly property var apps: Pipewire.nodes.values.filter(
        n => n.isStream && n.type === PwNodeType.AudioOutStream)

    function nodeName(n) {
        if (!n) return "Brak urządzenia"
        return n.nickname || n.description || n.name || "—"
    }
    function appName(n) {
        const p = n.properties
        return (p && (p["application.name"] || p["node.name"])) || n.nickname || n.name || "Aplikacja"
    }
    function appSubtitle(n) {
        const p = n.properties
        return (p && p["media.name"]) || ""
    }

    anchor.window: parentWindow
    anchor.rect.x: parentWindow.width - width - Theme.barMarginEnds
    anchor.rect.y: parentWindow.height
    implicitWidth:  560
    implicitHeight: col.implicitHeight + 28
    visible: open
    color: "transparent"

    // Potrzebne żeby węzły PipeWire miały dostępne audio/properties
    PwObjectTracker {
        objects: Pipewire.nodes.values
    }

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

            Text {
                text: "Audio"
                color: Theme.textPrimary
                font.pixelSize: Theme.fontSizeMedium + 2
                font.family: Theme.fontFamily
                font.weight: Theme.fontWeight
            }

            // ── Output + Input ──────────────────────────────
            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                VolumeRow {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    title: "Output"
                    subtitle: popup.nodeName(popup.sink)
                    volume: popup.sink && popup.sink.audio ? popup.sink.audio.volume : 0
                    muted:  popup.sink && popup.sink.audio ? popup.sink.audio.muted : false
                    iconOn:  String.fromCodePoint(0xF057E)
                    iconOff: String.fromCodePoint(0xF0581)
                    onVolumeRequested: (v) => { if (popup.sink && popup.sink.audio) popup.sink.audio.volume = v }
                    onMuteRequested:   { if (popup.sink && popup.sink.audio) popup.sink.audio.muted = !popup.sink.audio.muted }
                }

                VolumeRow {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    title: "Input"
                    subtitle: popup.nodeName(popup.source)
                    volume: popup.source && popup.source.audio ? popup.source.audio.volume : 0
                    muted:  popup.source && popup.source.audio ? popup.source.audio.muted : false
                    iconOn:  String.fromCodePoint(0xF036C)
                    iconOff: String.fromCodePoint(0xF036D)
                    onVolumeRequested: (v) => { if (popup.source && popup.source.audio) popup.source.audio.volume = v }
                    onMuteRequested:   { if (popup.source && popup.source.audio) popup.source.audio.muted = !popup.source.audio.muted }
                }
            }

            // ── Głośność aplikacji ──────────────────────────
            Rectangle {
                Layout.fillWidth: true
                radius: 14
                color: Theme.bgSurface
                implicitHeight: apps.implicitHeight + 24

                ColumnLayout {
                    id: apps
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    Text {
                        text: "Application Volumes"
                        color: Theme.textPrimary
                        font.pixelSize: Theme.fontSizeMedium
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }

                    Text {
                        visible: popup.apps.length === 0
                        text: "Żadna aplikacja nie odtwarza teraz dźwięku"
                        color: Theme.textMuted
                        font.pixelSize: Theme.fontSizeSmall
                        font.family: Theme.fontFamily
                        font.weight: Theme.fontWeight
                    }

                    Repeater {
                        model: popup.apps

                        VolumeRow {
                            required property var modelData
                            Layout.fillWidth: true
                            color: Theme.bgBase
                            title: popup.appName(modelData)
                            subtitle: popup.appSubtitle(modelData)
                            volume: modelData.audio ? modelData.audio.volume : 0
                            muted:  modelData.audio ? modelData.audio.muted : false
                            iconOn:  String.fromCodePoint(0xF057E)
                            iconOff: String.fromCodePoint(0xF0581)
                            onVolumeRequested: (v) => { if (modelData.audio) modelData.audio.volume = v }
                            onMuteRequested:   { if (modelData.audio) modelData.audio.muted = !modelData.audio.muted }
                        }
                    }
                }
            }
        }
    }
}
