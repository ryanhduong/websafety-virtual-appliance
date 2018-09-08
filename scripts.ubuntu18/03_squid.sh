#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# add diladele apt key
wget -qO - http://packages.diladele.com/diladele_pub.asc | sudo apt-key add -

# add new repo
echo "deb http://squid42.diladele.com/ubuntu/ bionic main" > /etc/apt/sources.list.d/squid42.diladele.com.list

# and install
apt-get update && apt-get install -y \
	squid-common \
	squid \
	squidclient \
	mc
