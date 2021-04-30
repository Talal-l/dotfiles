#!/bin/bash

# a fix for a bug in the open connect implementation. Run this script after connecting to a vpn
# work for Ubuntu 20.04.1 LTS
ip li set mtu 1358 dev vpn0
ip li set qlen 500 dev vpn0
