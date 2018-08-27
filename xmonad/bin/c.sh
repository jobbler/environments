#! /bin/bash

## This does not yet work. I need to finish it.


host=$1
conntype=$2

#connection=( $(grep -E "^\s*${host}\s+" ~/bin/clist-expanded.conn) )
grep -cE "^\s*${host}\s+" ~/bin/clist-expanded.conn

## Get count of lines, if greater than 1, then notify of connection types else connect

#ccount=$( grep -cE "^\s*${host}\s+" ~/bin/clist-expanded.conn )
#[[ ${ccount} -gt 1 ]] \
#  && echo "More than one" \
#  && ctypes=$( grep -E "^\s*${host}\s+" ~/bin/clist-expanded.conn | awk '{print $2}' )

ctypes=( $( grep -E "^\s*${host}\s+" ~/bin/clist-expanded.conn | awk '{print $2}' ) )

[[ ${#ctypes[@]} -gt 1 ]] \
  && {
       echo "Multiple connection types exist for ${host}"
       echo "Which type of connection do you wish to make?"
       select sel in ${ctypes[@]}
       do
         echo "+${sel}"
         break
       done
     }
echo "---: ${#ctypes[@]}"


echo ${ctypes}
exit

read name connection host options <<< $( grep -E "^\s*$1\s+" ~/bin/clist-expanded.conn )

[[ $2 ]] && connection=$2


echo "---: $name :--"
echo "--:: $connection :--"
echo "-::: $host :--"
echo ":::: $options :--"

exit

[[ ${host} ]] && {

  [[ ${connection} = ssh ]] && {
    echo ssh ${options} ${host}
    }

  [[ ${connection} = vnc ]] && {
    echo vncviewer ${options} ${host}
    }

  [[ ${connection} = html ]] && {
    echo firefox ${options} ${host}
    }

  [[ ${connection} = ff ]] && {
    echo firefox ${options} ${host}
    }

  [[ ${connection} = chrome ]] && {
    echo google-chrome ${options} ${host}
    }

  [[ ${connection} = vv ]] && {
    echo vivaldi ${options} ${host}
    }

  }

