#!/bin/bash

git_server="192.168.11.101"
user="user0"

if [[ !(-z $1) ]]; then
    echo $1
else 
    echo "Entet the repo name"
    exit
fi

repo_name="$1"

repo_name="$repo_name.git"
ssh $user@$git_server "mkdir repos/$repo_name; git -C repos/$repo_name init --bare;"
ssh $user@$git_server "ls repos"

