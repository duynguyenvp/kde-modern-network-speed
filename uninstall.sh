#!/usr/bin/env bash
set -euo pipefail

PLUGIN_ID="com.modern.networkspeed"
LOCAL_PLASMOID_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/plasma/plasmoids/$PLUGIN_ID"

if kpackagetool6 --type Plasma/Applet --show "$PLUGIN_ID" >/dev/null 2>&1; then
    echo "Removing $PLUGIN_ID via kpackagetool6..."
    kpackagetool6 --type Plasma/Applet --remove "$PLUGIN_ID"
else
    echo "$PLUGIN_ID is not registered in kpackagetool6."
fi

if [[ -d "$LOCAL_PLASMOID_DIR" ]]; then
    echo "Cleaning up leftover directory: $LOCAL_PLASMOID_DIR"
    rm -rf "$LOCAL_PLASMOID_DIR"
fi

if [[ "${1:-}" == "--restart" ]]; then
    echo "Restarting plasmashell..."
    if command -v systemctl >/dev/null 2>&1 && systemctl --user is-active plasma-plasmashell.service >/dev/null 2>&1; then
        systemctl --user restart plasma-plasmashell.service
    else
        kquitapp6 plasmashell 2>/dev/null || killall plasmashell 2>/dev/null || true
        nohup plasmashell >/dev/null 2>&1 &
    fi
    echo "Completely uninstalled and restarted plasmashell!"
else
    echo "Completely uninstalled $PLUGIN_ID!"
    echo "Tip: Remove the widget from your panel/desktop if it is still open, or run './uninstall.sh --restart'."
fi
