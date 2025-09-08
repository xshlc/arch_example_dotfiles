#!/bin/bash

#Script for lockscreen

sleep 2
powerprofilesctl set power-saver
hyprlock -c ~/.config/arch_examples_dotfiles/hyprland/hyprlock/hyprlock.conf
powerprofilesctl set performance
