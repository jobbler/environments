#! /bin/bash

text="DNF"
tooltip="this is the tooltip"

dnf check-update >/dev/null
RC=$?

[[ ${RC} -eq 100 ]] \
&& {
  class="updates"
  percentage=0
} || {
  class="noupdates"
  percentage=100
}


cat <<EOT
{"text": "$text", "tooltip": "$tooltip", "class": "$class", "percentage": "$percentage"}
EOT
