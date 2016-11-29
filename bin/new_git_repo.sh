#!/bin/bash

git_server="192.168.11.101"
user="user0"
repo_name="$1"

repo_name="$repo_name.git"
ssh $user@$git_server "mkdir repos/$repo_name; git -C repos/$repo_name init --bare;"
ssh $user@$git_server "ls repos"

