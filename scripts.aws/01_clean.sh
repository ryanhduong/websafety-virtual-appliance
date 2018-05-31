#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# remove all keys
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub

# authorized keys
rm -f /home/ubuntu/.ssh/authorized_keys
rm -f /root/.ssh/authorized_keys

# remove all scripts
cd /home/ubuntu
rm -Rf scripts.ubuntu16
rm -Rf scripts.mysql
rm -Rf scripts.aws

# remove history
shred -u ~/.*history
