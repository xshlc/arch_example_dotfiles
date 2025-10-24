#!/usr/bin/env bash

# Get list of connected monitors
connected=$(hyprctl monitors all | grep "Monitor" | awk '{print $2}')

# Check which outputs are connected
has_hdmi=$(echo "$connected" | grep -q "HDMI-A-1" && echo yes || echo no)
has_dp=$(echo "$connected" | grep -q "DP-1" && echo yes || echo no)
has_edp=$(echo "$connected" | grep -q "eDP-1" && echo yes || echo no)

# Clear existing monitor setup
hyprctl keyword monitor "eDP-1,disable"
hyprctl keyword monitor "HDMI-A-1,disable"
hyprctl keyword monitor "DP-1,disable"

# Logic:
if [[ "$has_hdmi" == "yes" && "$has_dp" == "yes" ]]; then
    # Both external monitors connected: disable laptop screen
    hyprctl keyword monitor "DP-1,2160x1440@60,0x1080,1"
    hyprctl keyword monitor "HDMI-A-1,1920x1080@60,0x0,1"
    hyprctl keyword monitor "eDP-1,disable"
elif [[ "$has_hdmi" == "yes" ]]; then
    # Only HDMI connected: use HDMI + laptop
    hyprctl keyword monitor "HDMI-A-1,1920x1080@60,0x-1080,1"
    hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
elif [[ "$has_dp" == "yes" ]]; then
    # Only DP connected: use DP + laptop
    hyprctl keyword monitor "DP-1,2160x1440@60,0x0,1"
    hyprctl keyword monitor "eDP-1,1920x1080@60,0x1440,1"
else
    # No externals: just laptop
    hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
fi
