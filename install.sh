#!/usr/bin/env bash
# =============================================================================
# Ironbar Islands - Installation Script
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ironbar"

echo -e "\033[1;34m::\033[0m Installing \033[1;36mIronbar Islands\033[0m..."

# Backup existing configuration if present
if [ -d "$TARGET_DIR" ]; then
    BACKUP_DIR="${TARGET_DIR}.backup_$(date +%Y%m%d_%H%M%S)"
    echo -e "\033[1;33m::\033[0m Existing config detected. Creating backup at: \033[0;33m$BACKUP_DIR\033[0m"
    cp -r "$TARGET_DIR" "$BACKUP_DIR"
fi

# Ensure target directory exists
mkdir -p "$TARGET_DIR"

# Copy configuration and stylesheet
echo -e "\033[1;34m::\033[0m Copying configuration files to \033[0;32m$TARGET_DIR\033[0m..."
cp "$SCRIPT_DIR/config.corn" "$TARGET_DIR/config.corn"
cp "$SCRIPT_DIR/style.css" "$TARGET_DIR/style.css"

# Reload ironbar if running
if pgrep -x "ironbar" > /dev/null 2>&1; then
    echo -e "\033[1;34m::\033[0m Reloading running Ironbar instance..."
    ironbar reload || true
fi

echo -e "\033[1;32m✓\033[0m Installation complete! Enjoy your new floating island bar."
