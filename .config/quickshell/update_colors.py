import json
import os
import sys

def main():
    wal_colors_path = os.path.expanduser('~/.cache/wal/colors.json')
    if not os.path.exists(wal_colors_path):
        print("Pywal colors not found. Please run 'wal -i <image>' first.")
        sys.exit(1)
        
    with open(wal_colors_path, 'r') as f:
        data = json.load(f)
        
    special = data.get('special', {})
    colors = data.get('colors', {})
    
    qml_content = f"""pragma Singleton
import QtQuick

QtObject {{
    readonly property color bgBase:        "{special.get('background', '#1e1e2e')}"
    readonly property color bgSurface:     "{colors.get('color0', '#313244')}80"
    readonly property color bgHover:       "{colors.get('color8', '#45475a')}"

    readonly property color textPrimary:   "{special.get('foreground', '#cdd6f4')}"
    readonly property color textSecondary: "{colors.get('color7', '#a6adc8')}"
    readonly property color textMuted:     "{colors.get('color8', '#6c7086')}"

    readonly property color accentPrimary: "{colors.get('color4', '#cba6f7')}"
    readonly property color accentGreen:   "{colors.get('color2', '#a6e3a1')}"
    readonly property color accentRed:     "{colors.get('color1', '#f38ba8')}"
    readonly property color accentYellow:  "{colors.get('color3', '#f9e2af')}"
    readonly property color accentBlue:    "{colors.get('color4', '#89b4fa')}"
    readonly property color accentPeach:   "{colors.get('color5', '#fab387')}"

    readonly property string fontFamily:  "Iosevka Nerd Font"
    readonly property int    fontWeight:   Font.ExtraBold
    readonly property int    fontSizeSmall:  14
    readonly property int    fontSizeMedium: 16

    readonly property color bgBar:  "transparent"
    readonly property color bgPill: "{colors.get('color0', '#313244')}80"

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
