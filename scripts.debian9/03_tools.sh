#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install build tools
apt-get -y install devscripts build-essential fakeroot debhelper dh-autoreconf cdbs

# install build dependences for squid
apt-get -y build-dep squid

# install additional packages for squid 3.5.23 (see http://squid-web-proxy-cache.1019090.n4.nabble.com/Build-errors-with-Squid-3-5-24-under-Debian-td4681637.html)
apt-get -y install libdbi-perl libssl1.0-dev