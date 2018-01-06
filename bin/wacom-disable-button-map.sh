#!/bin/bash
pad1="$(xsetwacom --list | grep PAD | awk 'FNR==1{print $0}' | sed 's/[^0-9]//g')"
pad2="$(xsetwacom --list | grep PAD | awk 'FNR==2{print $0}' | sed 's/[^0-9]//g')"

xsetwacom set "$pad1" "Button" "1" "0"
xsetwacom set "$pad1" "Button" "2" "9"
xsetwacom set "$pad1" "Button" "3" "0" 
xsetwacom set "$pad1" "Button" "8" "0"
xsetwacom set "$pad1" "Button" "9" "0"
xsetwacom set "$pad1" "Button" "10" "0"
xsetwacom set "$pad1" "Button" "11" "0"
xsetwacom set "$pad1" "Button" "12" "0"
xsetwacom set "$pad1" "Button" "13" "0"



