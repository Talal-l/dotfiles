#!/bin/bash

startApp () {

    for arg in "$@"
    do
        echo "start $arg";
        nohup "$arg";
        echo "started $arg";
    done
}

#startApp firefox teams gnome-terminal;


#gtk-launch com.microsoft.Teams.desktop
gtk-launch google-chrome.desktop
gtk-launch com.spotify.Client.desktop
gtk-launch md.obsidian.Obsidian.desktop
#gtk-launch com.toggl.TogglDesktop.desktop
#gtk-launch org.signal.Signal.desktop
#gtk-launch com.todoist.Todoist.desktop



# setup devices

# Disable touch on wacom intous pro 5




