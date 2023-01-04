#! /bin/bash


password=$( wofi --dmenu --prompt "Enter kerberos password" --password --lines 1 -W 300 )

echo "${password}" | kinit

sleep .25
pkill -RTMIN+4 waybar
