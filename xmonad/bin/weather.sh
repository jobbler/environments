#! /bin/bash

station=$( echo $1 | tr '[:lower:]' '[:upper:]' )



string=$( curl -s http://w1.weather.gov/xml/current_obs/${station}.xml | sed -n -e 's/<temp_f>\(.*\)<.*/\1 F/p' -e 's/<dewpoint_f>\(.*\)<.*/DewPoint: \1 F/p' )

echo ${station}: ${string}
#echo ${string}
