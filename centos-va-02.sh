#!/bin/bash

# check we are root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install web safety
pushd scripts.centos7
bash 02_apache.sh && \
bash 03_websafety.sh && \
bash 04_squid.sh && \
bash 05_integrate.sh
popd

# install mysql
pushd scripts.mysql
bash 01_mysql.sh && bash 02_sync.sh
popd

# install va
pushd scripts.va
bash 01_login.sh && bash 02_harden.sh
popd

# install the license
cp license.pem /opt/websafety/etc/

# and reset owner
chown -R websafety:websafety /opt/websafety

# tell 
echo "SUCCESS"
echo "SUCCESS"
echo "SUCCESS --- VA is Ready (check the license and publish it) ---"
echo "SUCCESS"
echo "SUCCESS"