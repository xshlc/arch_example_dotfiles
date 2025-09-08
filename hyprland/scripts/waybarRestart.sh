#!/usr/bin/bash

#Restart Waybar and swaync

killall waybar
killall swaync
waybar -c ~/.config/arch_example_dotfiles/waybar/config -s ~/.config/arch_example_dotfiles/waybar/style.css &
swaync -s ~/.config/arch_example_dotfiles/swaync/style.css -c ~/.config/arch_example_dotfiles/swaync/config.json &
notify-send --app-name=HOME -i ~/.config/arch_example_dotfiles/fastfetch/moon.png Hello
