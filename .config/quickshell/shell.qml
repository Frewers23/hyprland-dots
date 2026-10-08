//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1

import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire
import QtQuick
import "bar"

ShellRoot {
    Bar {}
}
