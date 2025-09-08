#!/usr/bin/bash

#Script to run SCRCPY

if pgrep -x "scrcpy" > /dev/null
then
    pkill -x scrcpy
    exit
fi

# Get connected devices
devices=$(adb devices | awk 'NR>1 && $2=="device" {print $1}')
device_count=$(echo "$devices" | wc -l)

# If no devices are found, exit the script
if [ "$device_count" -eq 0 ]; then
    notify-send "No devices connected."
    exit 1
fi

# If multiple devices are connected, prompt to select one
if [ "$device_count" -gt 1 ]; then
    selected_device=$(echo "$devices" | rofi -dmenu -config ~/.config/arch_example_dotfiles/rofi/config.rasi -p "Select Device: ")
else
    selected_device=$(echo "$devices")
fi

# If no device was selected, exit the script
if [ -z "$selected_device" ]; then
    echo "No device selected."
    exit 1
fi

# Options for SCRCPY modes
options="Video\nNo Video\nVideo & Audio"

# Prompt to select the SCRCPY mode
selected_option=$(echo -e "$options" | rofi -dmenu -config ~/.config/arch_example_dotfiles/rofi/config.rasi -p "Select SCRCPY mode: ")

# Run scrcpy with the selected mode and device
case "$selected_option" in
    "Video")
      scrcpy --serial "$selected_device" -no-audio
        ;;
    "No Video")
      scrcpy --serial "$selected_device" --no-window
        ;;
    "Video & Audio")
      scrcpy --serial "$selected_device" 
        ;;
    *)
        echo "Invalid selection"
        ;;
esac
