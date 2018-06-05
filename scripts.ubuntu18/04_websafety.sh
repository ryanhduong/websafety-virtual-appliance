#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# default arc
MAJOR="6.4.0"
MINOR="9D9C"
ARCH="amd64"

# download
wget http://packages.diladele.com/websafety/$MAJOR.$MINOR/$ARCH/release/ubuntu16/websafety-$MAJOR.${MINOR}_$ARCH.deb

# install
dpkg --install websafety-$MAJOR.${MINOR}_$ARCH.deb

# set new license if present
if [ -f license.pem ]; then
    sudo -u websafety cp license.pem /opt/websafety/etc
fi

# relabel folder
chown -R websafety:websafety /opt/websafety

echo "WEB SAFETY INSTALLED"
echo "WEB SAFETY INSTALLED"
echo "WEB SAFETY INSTALLED --- License is till ---"
cat /opt/websafety/etc/license.pem | grep "Not After"
echo "WEB SAFETY INSTALLED"
echo "WEB SAFETY INSTALLED"