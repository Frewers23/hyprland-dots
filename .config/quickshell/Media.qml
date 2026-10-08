pragma Singleton
import Quickshell
import Quickshell.Services.Mpris
import QtQuick

// ── Aktywny odtwarzacz MPRIS (natywnie, bez playerctl) ──────
Singleton {
    id: root

    // Preferuj odtwarzacz który aktualnie gra, w przeciwnym razie pierwszy
    readonly property var player: {
        const list = Mpris.players.values
        if (!list || list.length === 0) return null
        for (const p of list) {
            if (p.playbackState === MprisPlaybackState.Playing) return p
        }
        return list[0]
    }

    readonly property bool   active: player !== null
    readonly property bool   playing: player ? player.playbackState === MprisPlaybackState.Playing : false
    readonly property string title:   player ? (player.trackTitle  ?? "") : ""
    readonly property string artist:  player ? (player.trackArtist ?? "") : ""
    readonly property string artUrl:  player ? (player.trackArtUrl ?? "") : ""
    readonly property bool   volumeSupported: player ? player.volumeSupported : false
    readonly property real   volume:  (player && player.volumeSupported) ? player.volume : 0

    function togglePlaying() { if (player) player.togglePlaying() }
    function next()          { if (player) player.next() }
    function previous()      { if (player) player.previous() }

    function setVolume(v) {
        if (player && player.volumeSupported)
            player.volume = Math.max(0, Math.min(1, v))
    }
    function changeVolume(delta) { setVolume(volume + delta) }
}
