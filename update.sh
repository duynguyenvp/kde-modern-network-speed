#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ID="com.modern.networkspeed"

if kpackagetool6 --type Plasma/Applet --show "$PLUGIN_ID" >/dev/null 2>&1; then
    echo "Updating $PLUGIN_ID..."
    kpackagetool6 --type Plasma/Applet --upgrade "$SCRIPT_DIR"
else
    echo "$PLUGIN_ID is not installed yet. Installing..."
    kpackagetool6 --type Plasma/Applet --install "$SCRIPT_DIR"
fi

if [[ "${1:-}" == "--restart" ]]; then
    echo "Restarting plasmashell..."
    if command -v systemctl >/dev/null 2>&1 && systemctl --user is-active plasma-plasmashell.service >/dev/null 2>&1; then
        systemctl --user restart plasma-plasmashell.service
    else
        kquitapp6 plasmashell 2>/dev/null || killall plasmashell 2>/dev/null || true
        nohup plasmashell >/dev/null 2>&1 &
    fi
    echo "Updated and restarted plasmashell!"
else
    echo "Updated successfully!"
    echo "Tip: Run './update.sh --restart' to reload plasmashell immediately so UI changes take effect."
fi
