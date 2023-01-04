#! /bin/bash

station=$( echo $1 | tr '[:lower:]' '[:upper:]' )


string=$( curl -s https://w1.weather.gov/xml/current_obs/${station}.xml )

temp=$( echo "${string}" | grep "<temp_f>"  | sed 's/.*>\(.*\)<.*/\1/' | awk '{printf "%d", $1}' )
dewpoint=$( echo "${string}" | grep "<dewpoint_f>"  | sed 's/.*>\(.*\)<.*/\1/' | awk '{printf "%d", $1}' )

text="${station}: ${temp} F, Dewpoint: ${dewpoint} F"

#KAUS: 54.0 F DewPoint: 44.1 F

class="cold"
[[ $temperature -gt 50 ]] && class="mild"
[[ $temperature -gt 90 ]] && class="hot"


tooltip=""
percentage=${temp}
class="class"

cat <<EOT
{"text": "$text", "tooltip": "$tooltip", "class": "$class", "percentage": "$percentage"}
EOT




