#! /bin/bash

# This is the workspace we want to move to currently focused output.
swap_workspace=$1

[[ -z $swap_workspace ]] && exit

json_data=$( swaymsg -t get_workspaces --raw \
  | jq '[.[] | {name: .name, focused: .focused, visible: .visible, output: .output}]' \
  )

current_workspace=$( echo $json_data | jq '.[] | select(.focused==true) | .name' | sed 's/"//g' )
current_output=$( echo $json_data | jq ".[] | select(.name==\"$current_workspace\") | .output" | sed 's/"//g' )
swap_output=$( echo $json_data | jq ".[] | select(.name==\"$swap_workspace\") | .output" | sed 's/"//g' )

is_swap_visible=$( echo $json_data | jq ".[] | select(.name==\"$swap_workspace\") | .visible" | sed 's/"//g' )

visible_workspace_on_swap_output=$( echo $json_data | jq ".[] | select(.output==\"$swap_output\" and .visible==true) | .name" | sed 's/"//g' )


[[ $is_swap_visible == true ]] \
  && {
      swaymsg move workspace to $swap_output
      swaymsg workspace $swap_workspace
      swaymsg move workspace to $current_output
      swaymsg workspace $current_workspace
      swaymsg workspace $swap_workspace
} || {
      swaymsg workspace $swap_workspace
      swaymsg move workspace to $current_output
	  swaymsg workspace $visible_workspace_on_swap_output
      swaymsg workspace $swap_workspace
}

