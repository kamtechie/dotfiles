#!/usr/bin/env bash

choice=$(printf "Shutdown\nReboot\nSuspend\nLogout\nLock" | fuzzel --dmenu --prompt="Power:")

case "$choice" in
    Shutdown) systemctl poweroff ;;
    Reboot)   systemctl reboot ;;
    Suspend)  systemctl suspend ;;
    Logout)   hyprctl dispatch exit ;;
    Lock)     loginctl lock-session ;;
esac
