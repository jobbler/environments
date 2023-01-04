#! /bin/bash

while getopts "d" opt
do
  case ${opt} in
    d )
        display_log=1
        ;;
  esac
done

shift $((OPTIND-1))


[[ ${display_log} ]] \
  && {
      clear_log=$( echo "Clear Notifications" | cat - ~/.weechat_notifications \
        | wofi --show dmenu )
      }

[[ ${clear_log} == "Clear Notifications" ]] \
  && truncate --size 0 ~/.weechat_notifications


[[ $# -gt 0 ]] \
    && echo "$@" >> ~/.weechat_notifications \
    || echo >/dev/null

sleep .25
pkill -RTMIN+2 waybar
