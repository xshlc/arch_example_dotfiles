#!/bin/bash
# Auto-manage eDP-1 display on Hyprland Arch
LOGFILE="$HOME/.local/share/monitor-hotplug.log"

# Get connected monitors
connected=$(hyprctl monitors | grep "^Monitor" | awk '{print $2}')

# Function to get eDP-1 native resolution and refresh rate
get_edp_resolution() {
    hyprctl monitors | grep -A1 "Monitor eDP-1" | grep -oP '[0-9]+x[0-9]+@[0-9]+' | head -n1
}

EDP_RES=$(get_edp_resolution)
[ -z "$EDP_RES" ] && EDP_RES="1920x1080@60"  # fallback

# Decide desired state
if echo "$connected" | grep -q "HDMI-A-1" && echo "$connected" | grep -q "DP-1"; then
    desired="disable"
else
    desired="enable"
fi

# Check current state of eDP-1
if echo "$connected" | grep -q "eDP-1"; then
    current="enable"
else
    current="disable"
fi

# Apply change only if needed
if [ "$current" != "$desired" ]; then
    if [ "$desired" = "disable" ]; then
        hyprctl keyword monitor "eDP-1,disable"
        echo "$(date) - Laptop display disabled (HDMI-A-1 + DP-1 connected)" >> "$LOGFILE"
    else
        hyprctl keyword monitor "eDP-1,${EDP_RES},0x0,1"
        echo "$(date) - Laptop display enabled with resolution ${EDP_RES}" >> "$LOGFILE"
    fi
else
    echo "$(date) - No change needed (eDP-1 already $current)" >> "$LOGFILE"
fi