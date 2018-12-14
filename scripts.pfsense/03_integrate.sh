#!/bin/sh

# rename them (oh pfsense)
mv /usr/local/etc/rc.d/wsicapd /usr/local/etc/rc.d/wsicapd.sh
mv /usr/local/etc/rc.d/wsmgrd /usr/local/etc/rc.d/wsmgrd.sh
mv /usr/local/etc/rc.d/wsytgd /usr/local/etc/rc.d/wsytgd.sh
mv /usr/local/etc/rc.d/wssyncd /usr/local/etc/rc.d/wssyncd.sh
mv /usr/local/etc/rc.d/wsgsbd /usr/local/etc/rc.d/wsgsbd.sh
mv /usr/local/etc/rc.d/apache24 /usr/local/etc/rc.d/apache24.sh

# enable apache by default
sed -i '' 's/apache24_enable=\"NO\"/apache24_enable=\"YES\"/' /usr/local/etc/rc.d/apache24.sh

# load wsgi module
sed -i '' 's/\#LoadModule wsgi_module        libexec\/apache24\/mod_wsgi.so/LoadModule wsgi_module        libexec\/apache24\/mod_wsgi.so/' /usr/local/etc/apache24/modules.d/270_mod_wsgi.conf

# make apache listen on 8080 port
sed -i '' 's/Listen 80$/Listen 8080/' /usr/local/etc/apache24/httpd.conf

# and include the virtual hosts
sed -i '' 's/\#Include etc\/apache24\/extra\/httpd-vhosts.conf/Include etc\/apache24\/extra\/httpd-vhosts.conf/' /usr/local/etc/apache24/httpd.conf

# copy default apache virtual hosts file just in case
cp -f /usr/local/etc/apache24/extra/httpd-vhosts.conf /usr/local/etc/apache24/extra/httpd-vhosts.conf.default

# virtual hosts file needs to contaion only web safety virtual host
echo "Include /usr/local/etc/apache24/extra/websafety_virtual_host" > /usr/local/etc/apache24/extra/httpd-vhosts.conf

# and replace the virtual port in apache
sed -i '' 's/*:80/*:8080/' /usr/local/etc/apache24/extra/websafety_virtual_host

# restart apache
/usr/local/etc/rc.d/apache24.sh restart 
