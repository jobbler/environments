#! /bin/bash

vpn=$( nmcli connection show --active | awk '$(NF-1) ~ /vpn/ {NF=NF-3; print $0}' )

[[ -n "${vpn}" ]] \
    && {
        text="${vpn}"
        tooltip="$( \
          nmcli -f general.state,general.devices,ip4.address c show PHX2 \
            | awk '{print $2}' ORS=' ' \
            | awk '{print $1 " on " $2 " with ip " $3}'
          )"
        class="connected"
        percentage=100
    } || {
        text="vpn"
        tooltip="disconnected"
        class="disconnected"
        percentage=0
    }

cat <<EOT
{"text": "$text", "tooltip": "$tooltip", "class": "$class", "percentage": "$percentage"}
EOT


