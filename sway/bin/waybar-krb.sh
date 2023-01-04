#! /bin/bash


if klist &> /dev/null
then
  class="ticket"
  percentage=100
  text="KRB"
  tooltip=""
else
  class="noticket"
  percentage=0
  text="krb"
  tooltip=""
fi

cat <<EOT
{"text": "$text", "tooltip": "$tooltip", "class": "$class", "percentage": "$percentage"}
EOT
