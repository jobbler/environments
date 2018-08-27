#! /bin/bash



vpn=$( nmcli connection show --active | awk '$(NF-1) ~ /vpn/ {NF=NF-3; print $0}' )

[[ -n "${vpn}" ]] \
    && echo -e "<fc=#00FF66>${vpn}</fc>" \
    || echo -e "<fc=#FF0000>VPN Disconnected</fc>"






