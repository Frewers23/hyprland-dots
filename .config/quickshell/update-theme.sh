#!/usr/bin/env bash
python3 ~/.config/quickshell/update_colors.py
# Jeśli quickshell działa w tle, możemy go zrestartować
killall quickshell || true
quickshell &
