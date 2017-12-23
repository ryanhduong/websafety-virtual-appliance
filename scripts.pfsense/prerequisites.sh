#!/bin/tcsh

# in pfsense 2.4 a lot of packages were removed from default repository
setenv REPOURL http://pkg.freebsd.org/FreeBSD:11:amd64/release_1/All

# install apache 24
pkg add $REPOURL/gdbm-1.13_1.txz
pkg add $REPOURL/db5-5.3.28_6.txz
pkg add $REPOURL/apr-1.5.2.1.5.4_2.txz
pkg add $REPOURL/apache24-2.4.26.txz
pkg add $REPOURL/ap24-mod_wsgi4-4.5.15.txz
pkg add $REPOURL/sudo-1.8.20p2_2.txz

# install django and sqlite modules for python
pkg add $REPOURL/py27-setuptools-36.0.1.txz
pkg add $REPOURL/py27-sqlite3-2.7.13_7.txz
pkg add $REPOURL/py27-django111-1.11.2.txz
pkg add $REPOURL/py27-pytz-2016.10,1.txz
pkg add $REPOURL/python2-2_3.txz
pkg add $REPOURL/py27-pyasn1-0.2.2.txz
pkg add $REPOURL/py27-pyasn1-modules-0.0.9.txz
pkg add $REPOURL/py27-ldap-2.4.39.txz
pkg add $REPOURL/py27-six-1.10.0.txz
pkg add $REPOURL/py27-enum34-1.1.6.txz
pkg add $REPOURL/py27-pycparser-2.10.txz
pkg add $REPOURL/py27-cffi-1.7.0.txz
pkg add $REPOURL/py27-idna-2.5.txz
pkg add $REPOURL/py27-ipaddress-1.0.18.txz
pkg add $REPOURL/py27-cryptography-1.7.2.txz
pkg add $REPOURL/py27-openssl-16.2.0.txz

# in order to correctly start up apache at boot time init script needs to be renamed
cp /usr/local/etc/rc.d/apache24 /usr/local/etc/rc.d/apache24.sh

# make apache autostart
sed -i '' 's/apache24_enable=\"NO\"/apache24_enable=\"YES\"/' /usr/local/etc/rc.d/apache24.sh

# load wsgi module
sed -i '' 's/\#LoadModule wsgi_module        libexec\/apache24\/mod_wsgi.so/LoadModule wsgi_module        libexec\/apache24\/mod_wsgi.so/' /usr/local/etc/apache24/modules.d/270_mod_wsgi.conf

# make apache listen on 8080 port
sed -i '' 's/Listen 80$/Listen 8080/' /usr/local/etc/apache24/httpd.conf

# and include the virtual hosts
sed -i '' 's/\#Include etc\/apache24\/extra\/httpd-vhosts.conf/Include etc\/apache24\/extra\/httpd-vhosts.conf/' /usr/local/etc/apache24/httpd.conf 
