#!/bin/sh


# Single Monitor and laptop screen
# xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal    \
#     --output HDMI-3 --off                                                        \
#     --output HDMI-2 --off                                                        \
#     --output HDMI-1 --off                                                        \
#     --output DP-3-1 --off                                                        \
#     --output DP-3-3 --off                                                        \
#     --output DP-3-2 --mode 1920x1080 --pos 0x0 --rotate normal                   \
#     --output DP-3 --off                                                          \
#     --output DP-2 --off                                                          \
#     --output DP-1 --off



# Dual Monitor and laptop screen
xrandr \
    --output eDP-1 --mode 1920x1080 --pos 1024x1080 --rotate normal \
    --output HDMI-3 --off \
    --output HDMI-2 --off \
    --output HDMI-1 --off \
    --output DP-3-1 --off \
    --output DP-3-3 --mode 1920x1080 --pos 1920x0 --rotate normal \
    --output DP-3-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
    --output DP-3 --off \
    --output DP-2 --off \
    --output DP-1 --off

