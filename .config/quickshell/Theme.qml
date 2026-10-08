pragma Singleton
import QtQuick

QtObject {
    readonly property color bgBase:        "{'dark': {'color': '#101418'}, 'default': {'color': '#101418'}, 'light': {'color': '#f7f9ff'}}"
    readonly property color bgSurface:     "{'dark': {'color': '#1c2024'}, 'default': {'color': '#1c2024'}, 'light': {'color': '#eceef4'}}80"
    readonly property color bgHover:       "{'dark': {'color': '#42474e'}, 'default': {'color': '#42474e'}, 'light': {'color': '#dee3eb'}}80"

    readonly property color textPrimary:   "{'dark': {'color': '#e0e2e8'}, 'default': {'color': '#e0e2e8'}, 'light': {'color': '#181c20'}}"
    readonly property color textSecondary: "{'dark': {'color': '#c2c7cf'}, 'default': {'color': '#c2c7cf'}, 'light': {'color': '#42474e'}}"
    readonly property color textMuted:     "{'dark': {'color': '#8c9199'}, 'default': {'color': '#8c9199'}, 'light': {'color': '#72777f'}}"

    readonly property color accentPrimary: "{'dark': {'color': '#9ccbfb'}, 'default': {'color': '#9ccbfb'}, 'light': {'color': '#30628c'}}"
    readonly property color accentGreen:   "{'dark': {'color': '#b9c8da'}, 'default': {'color': '#b9c8da'}, 'light': {'color': '#52606f'}}"
    readonly property color accentRed:     "{'dark': {'color': '#ffb4ab'}, 'default': {'color': '#ffb4ab'}, 'light': {'color': '#ba1a1a'}}"
    readonly property color accentYellow:  "{'dark': {'color': '#d4bee6'}, 'default': {'color': '#d4bee6'}, 'light': {'color': '#68577a'}}"
    readonly property color accentBlue:    "{'dark': {'color': '#9ccbfb'}, 'default': {'color': '#9ccbfb'}, 'light': {'color': '#30628c'}}"
    readonly property color accentPeach:   "{'dark': {'color': '#d4bee6'}, 'default': {'color': '#d4bee6'}, 'light': {'color': '#68577a'}}"

    readonly property string fontFamily:  "Iosevka Nerd Font"
    readonly property int    fontWeight:   Font.ExtraBold
    readonly property int    fontSizeSmall:  14
    readonly property int    fontSizeMedium: 16

    readonly property color bgBar:  "transparent"
    readonly property color bgPill: "{'dark': {'color': '#1c2024'}, 'default': {'color': '#1c2024'}, 'light': {'color': '#eceef4'}}80"

    readonly property int barHeight:     40
    readonly property int barRadius:     20
    readonly property int barMarginEdge:  6
    readonly property int barMarginEnds: 12
    readonly property int barPaddingH:   10

    readonly property int pillRadius:    10
    readonly property int pillPaddingH:  10
    readonly property int spacing:        6
}
