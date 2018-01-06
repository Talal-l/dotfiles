#!/bin/bash

pad1="$(xsetwacom --list | grep PAD | awk 'FNR==1{print $0}' | sed 's/[^0-9]//g')"
pad2="$(xsetwacom --list | grep PAD | awk 'FNR==2{print $0}' | sed 's/[^0-9]//g')"

mapping="/home/eris/dotfiles/bin/wacom-button-map.sh"

setIndicator="key +Shift_L +Control_L +Alt_L +t"  # if this is there then the mapping is active

stat="$(xsetwacom get $pad1 button 2 | awk '{$1=$1;print}')" # awk will strip any leading or trailing spaces 
echo $stat


if [[ $stat == "key +Shift_L +Control_L +Alt_L +t" ]]; 
then
    while read p; do 
        c=$(echo $p |cut -d " " -f -5) # cut the line
        c="$c 0" # replace the with 0 so the button is disabled
        echo $c
        eval $c
    done<$mapping
else 
    while read p; do
      echo $p
      eval $p
    done <$mapping

fi


