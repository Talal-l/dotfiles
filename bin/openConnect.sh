#!/bin/bash

pass=`cat ~/.openconnect.pass`

#echo "token $1"
#echo "token $pass"
#{  printf '$pass \n' ; } |  sudo openconnect "https://168.187.224.68/+webvpn+/index.html"  --authgroup=IT_Application_Team  --user=ammar.t --passwd-on-stdin  --servercert "pin-sha256:yFzCeweCcSxkzOdrGSE8KWlz8SiGsN6BcRDQwdqY6i4=" 


VPN_PASSWD=`cat ~/.openconnect.pass`
VPN_HOST=https://168.187.224.68/+webvpn+/index.html
VPN_USER=ammar.t
VPN_GROUP=IT_Application_Team
SERVER_CERTIFICATE=pin-sha256:yFzCeweCcSxkzOdrGSE8KWlz8SiGsN6BcRDQwdqY6i4=
expect spawn openconnect --background $VPN_HOST --user=$VPN_USER --passwd-on-stdin --authgroup=$VPN_GROUP --servercert=$SERVER_CERTIFICATE

#echo $VPN_PASSWD | sudo script  -E always -q -c 'openconnect "https://168.187.224.68/+webvpn+/index.html"  --authgroup=IT_Application_Team  -u "ammar.t" --passwd-on-stdin  --servercert "pin-sha256:yFzCeweCcSxkzOdrGSE8KWlz8SiGsN6BcRDQwdqY6i4="'
# from https://askubuntu.com/a/1293551

#challange=<code> && sudo -S <<< "<sudo_password>" echo I am super user &&  | sudo openconnect <server_name> --user <vpn_username> --passwd-on-stdin

# a fix for a bug in the open connect implementation. Run this script after connecting to a vpn
# work for Ubuntu 20.04.1 LTS
#sudo ip li set mtu 1358 dev vpn0
#sudo ip li set qlen 500 dev vpn0

#{ printf '<vpn_password>\n'; sleep 1; printf "$challange\n"; } | sudo openconnect <server_name> --user <vpn_username> --passwd-on-stdin
