pragma Singleton
import QtQuick

QtObject {
    // ── Kolory (Noctalia Material You) ────────────────────────────
    readonly property color bgBase:        "#111318"
    readonly property color bgSurface:     "#1d2024"
    readonly property color bgHover:       "#282a2f"

    readonly property color textPrimary:   "#e2e2e9"
    readonly property color textSecondary: "#c4c6cf"
    readonly property color textMuted:     "#8e9099"

    readonly property color accentPrimary: "#a9c7ff"
    readonly property color accentGreen:   "#bdc7dc"
    readonly property color accentRed:     "#ffb4ab"
    readonly property color accentYellow:  "#dcbce1"
    readonly property color accentBlue:    "#d6e3ff"
    readonly property color accentPeach:   "#f9d8fd"

    // ── Typografia ───────────────────────────────────────────
    readonly property string fontFamily:  "Iosevka Nerd Font"
    readonly property int    fontWeight:   Font.ExtraBold
    readonly property int    fontSizeSmall:  14   // tekst
    readonly property int    fontSizeMedium: 16   // ikony i nagłówki

    // ── Tło ──────────────────────────────────────────────────
    readonly property color bgBar:  "transparent"   // pasek przezroczysty – widać tylko pigułki
    readonly property color bgPill: "#1d2024"

    // ── Wymiary – bar ────────────────────────────────────────
    readonly property int barHeight:     40   // wysokość paska
    readonly property int barRadius:     20   // zaokrąglenie paska (half-height = pełna pigułka)
    readonly property int barMarginEdge:  6   // dystans od krawędzi ekranu (góra)
    readonly property int barMarginEnds: 12   // wcięcie z lewej i prawej strony
    readonly property int barPaddingH:   10   // padding wewnątrz paska do widgetów

    // ── Wymiary – pigułki ─────────────────────────────────────
    readonly property int pillRadius:    10
    readonly property int pillPaddingH:  10
    readonly property int spacing:        6
}
