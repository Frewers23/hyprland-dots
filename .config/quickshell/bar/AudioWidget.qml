import Quickshell.Services.Pipewire
import QtQuick
import "../"

// ── Audio: klik → panel, scroll → głośność, prawy/środkowy klik → mute ──
Item {
    id: root

    signal clicked()

    readonly property var  sink:   Pipewire.defaultAudioSink
    readonly property real volume: sink && sink.audio ? Math.round(sink.audio.volume * 100) : 0
    readonly property bool muted:  sink && sink.audio ? sink.audio.muted : false

    implicitWidth:  pill.implicitWidth
    implicitHeight: pill.implicitHeight

    Pill {
        id: pill
        clickable: true
        bgColor: Theme.bgSurface

        icon: root.muted ? String.fromCodePoint(0xF075F)
            : root.volume > 66 ? String.fromCodePoint(0xF057E)
            : root.volume > 33 ? String.fromCodePoint(0xF0580)
            : String.fromCodePoint(0xF057F)
        iconColor: root.muted ? Theme.accentRed : Theme.accentGreen
        label: root.muted ? "mute" : root.volume + "%"

        onClicked: root.clicked()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton | Qt.MiddleButton
        onClicked: { if (root.sink && root.sink.audio) root.sink.audio.muted = !root.sink.audio.muted }
    }

    WheelHandler {
        onWheel: (e) => {
            if (!root.sink || !root.sink.audio) return
            const d = e.angleDelta.y > 0 ? 0.05 : -0.05
            root.sink.audio.volume = Math.max(0, Math.min(1.0, root.sink.audio.volume + d))
        }
    }
}
