#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# set squid version
source squid.ver

# drop squid build folder
rm -R build/squid

# we will be working in a subfolder make it
mkdir -p build/squid

# copy the patches to the working folder
cp rules.patch build/squid/rules.patch

# decend into working directory
pushd build/squid

# get squid from debian experimental
wget http://http.debian.net/debian/pool/main/s/squid/squid_${SQUID_PKG}.dsc
wget http://http.debian.net/debian/pool/main/s/squid/squid_${SQUID_VER}.orig.tar.gz
wget http://http.debian.net/debian/pool/main/s/squid/squid_${SQUID_PKG}.debian.tar.xz

# unpack the source package
dpkg-source -x squid_${SQUID_PKG}.dsc

# modify configure options in debian/rules, add --enable-ssl --enable-ssl-crtd
patch squid-${SQUID_VER}/debian/rules < ../../rules.patch

# build the package
cd squid-${SQUID_VER} && dpkg-buildpackage -rfakeroot -b

# and revert
popd
