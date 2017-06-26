#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# default arc
MAJOR="5.1.0"
MINOR="2D17"

# get latest build
curl -O http://packages.diladele.com/websafety/$MAJOR.$MINOR/amd64/release/centos7/websafety-${MAJOR}-${MINOR}.x86_64.rpm

# install it
yum -y --nogpgcheck localinstall websafety-${MAJOR}-${MINOR}.x86_64.rpm
  
# package installed everything needed for apache, so just restart
systemctl restart httpd.service
