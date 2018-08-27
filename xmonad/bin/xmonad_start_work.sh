#! /bin/bash

. $1

wifi=$( nmcli connection show --active | awk '$(NF-1) ~ /wifi/ {NF=NF-3; print $0}' )
vpn=$( nmcli connection show --active | awk '$(NF-1) ~ /vpn/ {NF=NF-3; print $0}' )

[[ -n "${wifi}" ]] || {
    Xdialog --wmclass float --msgbox "Not connected to a Wifi Connection" 10 100
    exit
    }

kpass=$( Xdialog --wmclass float --password --inputbox "Enter kerberos password:" 0 0 2>&1 )

[[  -z "${vpn}" ]] && {
    echo "${wifi}" | grep -iE "tcp_vpns" \
      && nmcli con up id "${tcp_vpn_connection}" \
      || nmcli con up id "${udp_vpn_connection}"
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
    Xdialog --wmclass float --msgbox "Failed to establish a VPN connection" 10 100
    exit
    }

terminator --layout weechat &

echo ${kpass} | kinit

/usr/bin/google-chrome ${browser_tabs} &





