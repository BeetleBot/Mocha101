#!/usr/bin/env bash

WALLPAPER_DIR="/home/nkr/Pictures/Wallpapers/Catpuccin/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

hyprctl hyprpaper reload ,"$WALLPAPER"
