#! /bin/bash

while getopts ":u" opt
do
  case ${opt} in
    u )
        sudo dnf list updates | Xdialog  --wmclass float --ok-label "Update" --textbox - 20 100
        RC=$?

        [[ ${RC} -eq 0 ]] \
          && sudo dnf -y update | Xdialog  --wmclass float --no-cancel --ok-label "Close" --tailbox - 20 100

        exit
        ;;
  esac
done

count=$( sudo dnf list updates | sed -e '/^Last meta/d' -e '/^Upgraded Pac/d' | wc -l )
[[ ${count} -gt 0 ]] \
  && echo "Updates Available: ${count}" \
  || echo ""


