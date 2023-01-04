#! /bin/bash

declare -A vpns vpns_active

vpn_get() {
  local connection
  local uuid
 
  while read -r connection uuid
  do
    vpns[${connection}]=${uuid}

  done < <( nmcli c show | awk '$3 == "vpn" {print $1 " " $2}' )
}

vpn_active() {
  while read -r connection uuid
  do
    vpns_active[${connection}]=${uuid}
  done < <( nmcli c show --active | awk '$3 == "vpn" {print $1 " " $2}' )
}

menu() {
  local vpn

  for vpn in ${!vpns[*]} 
  do
    [[ " ${!vpns_active[@]} " =~ " ${vpn} " ]] \
      && vpn=$( printf "<span foreground=\"green\">%-25s %s</span>" "${vpn}" "active" )
    echo -e "${vpn}"
  done | wofi --dmenu \
           --lines 3 \
           -W 300 \
           --prompt "Toggle VPN Connection" \
           --allow-markup
}

toggle() {
  local connection
  local password

  connection=$1

  [[ $( nmcli -f general.state connection show ${connection} ) ]] \
    && nmcli connection down ${connection} \
    || {
        password="$(vpn_get_password)"

        echo "vpn.secrets.password:${password}" > $HOME/.tmp$$

        nmcli connection up ${connection} passwd-file $HOME/.tmp$$

        rm -f $HOME/.tmp$$
       }
}

vpn_get_password() {

  local password

  password=$( wofi --dmenu --prompt "Enter pin + token" --password --lines 1 -W 300 )

  echo "${password}"
}



vpn_get
vpn_active

# Strip pango formatting from output.
selection=$( menu | sed 's/<.*>\(.*\)<.*>/\1/g' )

[[ ! -z ${selection} ]] && toggle ${selection} 

sleep .25
pkill -RTMIN+3 waybar

