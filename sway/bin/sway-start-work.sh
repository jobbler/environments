#! /bin/bash

. $1

wifi=$( nmcli connection show --active | awk '$(NF-1) ~ /wifi/ {NF=NF-3; print $0}' )
vpn=$( nmcli connection show --active | awk '$(NF-1) ~ /vpn/ {NF=NF-3; print $0}' )

[[ -n "${wifi}" ]] || {
    swaynag --message "Not connected to a Wifi Connection"
    exit
    }

[[ -z "${vpn}" ]] && {
    vpn-toggle.sh
    }

while [[ timeout -ne 15 ]]
do
  echo ${timeout}
  sleep 2
  host ${resolvable_host} \
    && timeout=15 \
    || (( timeout++ ))
done

host ${resolvable_host} || {
    swaynag --message "Failed to establish a VPN connection"
    exit
    }

krb-init.sh

workspace_focused=$( swaymsg -t get_workspaces --raw | jq '.[] | select(.focused==true) | .name' | sed 's/"//g' )

swaymsg workspace 1
kitty --class communications weechat &

/usr/bin/google-chrome --new-window ${browser_tabs} &
swaymsg workspace ${workspace_focused}



