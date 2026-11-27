#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ID="com.modern.networkspeed"

if kpackagetool6 --type Plasma/Applet --show "$PLUGIN_ID" >/dev/null 2>&1; then
    echo "Upgrading $PLUGIN_ID..."
    kpackagetool6 --type Plasma/Applet --upgrade "$SCRIPT_DIR"
else
    echo "Installing $PLUGIN_ID..."
    kpackagetool6 --type Plasma/Applet --install "$SCRIPT_DIR"
fi

echo "Done! You can now add 'Modern Network Speed' (Tốc độ mạng hiện đại) to your panel or desktop."
