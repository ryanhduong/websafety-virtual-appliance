#!/bin/tcsh

# see if websafety group exists
echo "Searching for group websafety..."
getent group websafety >/dev/null
if ($status != 0) then
    echo "Group websafety is not found, please add it through pfSense Web UI."
    exit 1
else
    echo "Group websafety already exists."
endif

# see if websafety user exists
echo "Searching for user websafety..."
getent passwd websafety >/dev/null
if ($status != 0) then
    echo "User websafety is not found, please add it through pfSense Web UI."
    exit 2
else
    echo "User websafety already exists."
endif

# how to check user websafety is in websafety group???

# get latest version of diladele icap server
fetch http://packages.diladele.com/websafety/5.2.0.7508/amd64/release/freebsd10/websafety-5.2.0-amd64.txz

# and install it
pkg install -y websafety-5.2.0-amd64.txz

# copy default apache virtual hosts file just in case
cp -f /usr/local/etc/apache24/extra/httpd-vhosts.conf /usr/local/etc/apache24/extra/httpd-vhosts.conf.default

# virtual hosts file needs to contaion only diladele virtual host
echo "Include /usr/local/etc/apache24/extra/websafety_virtual_host" > /usr/local/etc/apache24/extra/httpd-vhosts.conf

# restart apache
/usr/local/etc/rc.d/apache24.sh restart 
