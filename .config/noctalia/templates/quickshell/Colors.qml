pragma Singleton
import QtQuick

QtObject {
    // ── Kolory (Noctalia Material You) ────────────────────────────
    readonly property color bgBase:        "{{colors.background.default.hex}}"
    readonly property color bgSurface:     "{{colors.surface_container.default.hex}}"
    readonly property color bgHover:       "{{colors.surface_container_high.default.hex}}"

    readonly property color textPrimary:   "{{colors.on_surface.default.hex}}"
    readonly property color textSecondary: "{{colors.on_surface_variant.default.hex}}"
    readonly property color textMuted:     "{{colors.outline.default.hex}}"

    readonly property color accentPrimary: "{{colors.primary.default.hex}}"
    readonly property color accentGreen:   "{{colors.secondary.default.hex}}"
    readonly property color accentRed:     "{{colors.error.default.hex}}"
    readonly property color accentYellow:  "{{colors.tertiary.default.hex}}"
    readonly property color accentBlue:    "{{colors.primary_fixed.default.hex}}"
    readonly property color accentPeach:   "{{colors.tertiary_fixed.default.hex}}"

    // ── Typografia ───────────────────────────────────────────
    readonly property string fontFamily:  "Iosevka Nerd Font"
    readonly property int    fontWeight:   Font.ExtraBold
    readonly property int    fontSizeSmall:  14   // tekst
    readonly property int    fontSizeMedium: 16   // ikony i nagłówki

    // ── Tło ──────────────────────────────────────────────────
    readonly property color bgBar:  "transparent"   // pasek przezroczysty – widać tylko pigułki
    readonly property color bgPill: "{{colors.surface_container.default.hex}}"

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
