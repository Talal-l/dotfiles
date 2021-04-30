#!/bin/bash

startApp () {

    for arg in "$@"
    do
        echo "start $arg";
        nohup "$arg";
        echo "started $arg";
    done
}

startApp firefox teams gnome-terminal;
