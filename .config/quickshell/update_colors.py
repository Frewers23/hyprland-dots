import json
import os
import sys

def main():
    matugen_colors_path = os.path.expanduser('~/.cache/matugen_colors.json')
    if not os.path.exists(matugen_colors_path):
        print("Matugen colors not found. Please run set-wallpaper first.")
        sys.exit(1)
        
    with open(matugen_colors_path, 'r') as f:
        data = json.load(f)
        
    colors = data.get('colors', {})
    
    qml_content = f"""pragma Singleton
import QtQuick

QtObject {{
    readonly property color bgBase:        "{colors.get('surface', '#1e1e2e')}"
    readonly property color bgSurface:     "{colors.get('surface_container', '#313244')}80"
    readonly property color bgHover:       "{colors.get('surface_variant', '#45475a')}80"

    readonly property color textPrimary:   "{colors.get('on_surface', '#cdd6f4')}"
    readonly property color textSecondary: "{colors.get('on_surface_variant', '#a6adc8')}"
    readonly property color textMuted:     "{colors.get('outline', '#6c7086')}"

    readonly property color accentPrimary: "{colors.get('primary', '#cba6f7')}"
    readonly property color accentGreen:   "{colors.get('secondary', '#a6e3a1')}"
    readonly property color accentRed:     "{colors.get('error', '#f38ba8')}"
    readonly property color accentYellow:  "{colors.get('tertiary', '#f9e2af')}"
    readonly property color accentBlue:    "{colors.get('primary', '#89b4fa')}"
    readonly property color accentPeach:   "{colors.get('tertiary', '#fab387')}"

    readonly property string fontFamily:  "Iosevka Nerd Font"
    readonly property int    fontWeight:   Font.ExtraBold
    readonly property int    fontSizeSmall:  14
    readonly property int    fontSizeMedium: 16

    readonly property color bgBar:  "transparent"
    readonly property color bgPill: "{colors.get('surface_container', '#313244')}80"

    readonly property int barHeight:     40
    readonly property int barRadius:     20
    readonly property int barMarginEdge:  6
    readonly property int barMarginEnds: 12
    readonly property int barPaddingH:   10

    readonly property int pillRadius:    10
    readonly property int pillPaddingH:  10
    readonly property int spacing:        6
}}
"""
    with open(os.path.expanduser('~/.config/quickshell/Theme.qml'), 'w') as f:
        f.write(qml_content)
        
if __name__ == "__main__":
    main()
