#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# default arc
MAJOR="6.3.0"
MINOR="FE34"
ARCH="amd64"

# download
wget http://packages.diladele.com/websafety/$MAJOR.$MINOR/$ARCH/release/ubuntu16/websafety-$MAJOR.${MINOR}_$ARCH.deb

# install
dpkg --install websafety-$MAJOR.${MINOR}_$ARCH.deb

# patch one file switching web safety to squid 4
patch /opt/websafety/var/console/_domain/squid/binary_squid.py < binary_squid.py.patch

# relabel folder
chown -R websafety:websafety /opt/websafety
