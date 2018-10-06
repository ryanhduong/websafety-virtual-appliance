#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# default arc
MAJOR="6.5.0"
MINOR="8073"
ARCH="amd64"

# download
wget http://packages.diladele.com/websafety/$MAJOR.$MINOR/$ARCH/release/ubuntu18/websafety-$MAJOR.${MINOR}_$ARCH.deb

# install
dpkg --install websafety-$MAJOR.${MINOR}_$ARCH.deb

# set new license if present
if [ -f license.pem ]; then
    sudo -u websafety cp license.pem /opt/websafety/etc
fi

# patch one file switching web safety to squid 4
patch /opt/websafety/var/console/_domain/squid/binary_squid.py < binary_squid.py.patch

# generate the configuration files
sudo -u websafety python3 /opt/websafety/var/console/generate.py

# relabel folder
chown -R websafety:websafety /opt/websafety

echo "WEB SAFETY INSTALLED"
echo "WEB SAFETY INSTALLED"
echo "WEB SAFETY INSTALLED --- License is till ---"
cat /opt/websafety/etc/license.pem | grep "Not After"
echo "WEB SAFETY INSTALLED"
echo "WEB SAFETY INSTALLED"