#! /bin/bash

text="IRC"
tooltip=""

count=$( cat ~/.weechat_notifications | wc -l )
[[ ${count} -gt 0 ]] \
&& {
  class="new"
  percentage=0
} || {
  class="none"
  percentage=100
}


cat <<EOT
{"text": "$text", "tooltip": "$tooltip", "class": "$class", "percentage": "$percentage"}
EOT

