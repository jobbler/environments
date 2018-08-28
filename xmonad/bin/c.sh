#! /bin/bash


# This function is withing this script for use by xmonad when assigning custom keys.
# The function c() can be added to the .bashrc to allow opening connection by typing "c connection"
# .bash_completion for this function canbe enabled as well by addinf the following to .bash_completion
#
#     _c()
#     {
#       local cur 
#       cur="${COMP_WORDS[COMP_CWORD]}"
#       opts="$( grep ^${cur} ~/bin/clist-expanded.conn | grep -v -E '^#|^;' | awk '{print $1}' )"
# 
#         COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
#     }
# 
#     complete -F _c c





c() {

    declare -A executable=(
        [ssh]=/usr/bin/ssh
        [vnc]=/usr/bin/vncviewer
        [html]=/usr/bin/xdg-open
        [firefox]=/usr/bin/firefox
        [chrome]=/usr/bin/google-chrome
        [vivaldi]=/usr/bin/vivaldi
    )


    read name connection host options <<< $( grep -E "^\s*$1\s+" ~/bin/clist-expanded.conn );
    [[ -n $2 ]] && connection=$2;
    [[ -n ${host} ]] && {
        eval "${executable[${connection}]} ${options} ${host}"
    }
}


c $1

