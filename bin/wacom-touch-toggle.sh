#!/bin/bash

# Toggle touch on/off

device="$(xsetwacom --list | grep TOUCH | sed -r "s/[^0-9]//g")" 
echo $device



stat="`xsetwacom get "$device" touch`" # You need this to run a string as a command


if [ "$stat" == 'on' ]; then
       xsetwacom set "$device" touch off
   else 
           xsetwacom set "$device" touch on

       fi

