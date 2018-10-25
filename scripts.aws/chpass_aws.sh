#!/bin/bash
#
# update root password in the Web Safety to a random value
# required for vm publication in the AWS Cloud Marketplace
#

# generate new password 12 characters long
$NEWPASW=`date +%s | sha256sum | base64 | head -c 12 ; echo`

# update the password in the database 
python3 /opt/websafety/bin/reset_password.py --password=$NEWPASW

# change the template too so that user sees the new password right away
sed -i "s/Passw0rd/$NEWPASW/g" /opt/websafety/var/console/frame/templates/login.html
