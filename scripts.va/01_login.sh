#!/bin/bash

# all packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# allow root login for ssh
sed -i "s/#\{0,1\}PermitRootLogin *.*$/PermitRootLogin yes/g" /etc/ssh/sshd_config

# install vm tools (only if vmware is detected)
dmidecode -s system-product-name | grep -i "vmware" > /dev/null
if [ $? -eq 0 ]; then
    echo "Detected VMware, installing open-vm-tools..."
    if [ -f /etc/centos-release ] || [ -f /etc/redhat-release ]; then
        yum -y install open-vm-tools
        systemctl enable vmtoolsd.service && systemctl start vmtoolsd.service
    else
        apt-get update > /dev/null
        apt-get install -y open-vm-tools
    fi
fi

# copy the /etc/issue creation script to installation folder
cp va_issue.sh /opt/websafety/bin/

# we are on ubuntu - make script executable
chmod +x /opt/websafety/bin/va_issue.sh

# now setup /etc/issue login banner
if [ -f /etc/centos-release ] || [ -f /etc/redhat-release ]
then
    # we are on centos 7 - just run the script (IP address will not be automatically updated)
    /bin/bash /opt/websafety/bin/va_issue.sh > /etc/issue    
else
    
    #  create systemd service that runs everytime network is restarted
    cp wsissue.service /etc/systemd/system/wsissue.service

    # enable it
    systemctl enable wsissue.service
fi

echo "Success, run next step please."
