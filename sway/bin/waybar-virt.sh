#! /bin/bash

running=$( sudo virsh list --state-running | grep -vE "State|-----|^$" | wc -l )
total=$( sudo virsh list --all | grep -vE "State|-----|^$" | wc -l )


text="VMs ${running}/${total}"


[[ ${running} > 0 ]] \
  && class="running" \
  || class="notrunning"

tooltip=""
percentage=0


cat <<EOT
{"text": "$text", "tooltip": "$tooltip", "class": "$class", "percentage": "$percentage"}
EOT

