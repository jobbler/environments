#! /bin/bash

set -f

while getopts ":rc" opt
do
  case ${opt} in
    r )
        cat ~/.weechat_notifications | Xdialog  --wmclass float --ok-label "Clear Log" --textbox - 20 100
        RC=$?

        [[ ${RC} -eq 0 ]] \
          && > ~/.weechat_notifications

        exit
        ;;
    c )
        count=$( cat ~/.weechat_notifications | wc -l )
        [[ ${count} -gt 0 ]] \
          && echo "New IRC Notifications: ${count}" \
          || echo ""
        exit
        ;;
  esac
done

shift $((OPTIND-1))

echo $@ >> ~/.weechat_notifications



