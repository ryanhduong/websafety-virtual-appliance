#!/bin/tcsh

# in pfsense 2.3 a lot of packages were removed from default repository
setenv REPOURL http://pkg.freebsd.org/freebsd:10:x86:64/release_3/All

# install apache 24
pkg add $REPOURL/gdbm-1.11_2.txz
pkg add $REPOURL/db5-5.3.28_3.txz
pkg add $REPOURL/apr-1.5.2.1.5.4.txz
pkg add $REPOURL/apache24-2.4.18.txz
pkg add $REPOURL/ap24-mod_wsgi4-4.4.21.txz
pkg add $REPOURL/sudo-1.8.15.txz

# install django and sqlite modules for python
pkg add $REPOURL/py27-setuptools27-19.2.txz
pkg add $REPOURL/py27-sqlite3-2.7.11_7.txz
pkg add $REPOURL/py27-django18-1.8.10.txz
pkg add $REPOURL/py27-pytz-2015.7,1.txz
pkg add $REPOURL/python2-2_3.txz
pkg add $REPOURL/py27-pyasn1-0.1.9.txz
pkg add $REPOURL/py27-pyasn1-modules-0.0.8_1.txz
pkg add $REPOURL/py27-ldap-2.4.22.txz
pkg add $REPOURL/py27-six-1.9.0.txz
pkg add $REPOURL/py27-enum34-1.0.4.txz
pkg add $REPOURL/py27-pycparser-2.10.txz
pkg add $REPOURL/py27-cffi-1.2.1.txz
pkg add $REPOURL/py27-idna-2.0.txz
pkg add $REPOURL/py27-ipaddress-1.0.14.txz
pkg add $REPOURL/py27-cryptography-1.0.2_4.txz
pkg add $REPOURL/py27-openssl-0.15.1.txz

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
