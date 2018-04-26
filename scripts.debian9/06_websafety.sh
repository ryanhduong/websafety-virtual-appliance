#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# default arc
MAJOR="6.3.0"
MINOR="FD7F"
ARCH="amd64"

# get latest build
cat /proc/cpuinfo | grep -m 1 ARMv7 > /dev/null 2>&1
if [ $? -eq 0 ]; then
	ARCH="armhf"
fi

wget http://packages.diladele.com/websafety/$MAJOR.$MINOR/$ARCH/release/debian9/websafety-$MAJOR.${MINOR}_$ARCH.deb

# install it
dpkg --install websafety-$MAJOR.${MINOR}_$ARCH.deb

# relabel log folder
chown -R websafety:websafety /opt/websafety
