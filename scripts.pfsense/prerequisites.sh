#!/bin/sh

# in pfsense 2.4 a lot of packages were removed from default repository
REPOURL=http://pkg.freebsd.org/FreeBSD:11:amd64/release_2/All; export REPOURL

# install apache 24
pkg add ${REPOURL}/gdbm-1.13_1.txz
pkg add ${REPOURL}/db5-5.3.28_6.txz
pkg add ${REPOURL}/apr-1.6.3.1.6.1_1.txz
pkg add ${REPOURL}/apache24-2.4.33.txz
pkg add ${REPOURL}/sudo-1.8.22.txz

# install python
pkg add ${REPOURL}/python36-3.6.5.txz
pkg add ${REPOURL}/py36-setuptools-39.0.1.txz
pkg add ${REPOURL}/py36-sqlite3-3.6.5_7.txz
pkg add ${REPOURL}/ap24-py36-mod_wsgi4-4.5.24_1.txz

# install django
pkg add ${REPOURL}/py36-django20-2.0.3.txz
pkg add ${REPOURL}/py36-chardet-3.0.4.txz
pkg add ${REPOURL}/py36-certifi-2018.1.18.txz
pkg add ${REPOURL}/py36-idna-2.6.txz
pkg add ${REPOURL}/py36-asn1crypto-0.22.0.txz
pkg add ${REPOURL}/py36-pycparser-2.18.txz
pkg add ${REPOURL}/py36-cffi-1.11.2.txz
pkg add ${REPOURL}/py36-cryptography-2.1.4.txz
pkg add ${REPOURL}/py36-openssl-17.5.0_1.txz
pkg add ${REPOURL}/py36-pysocks-1.6.8.txz
pkg add ${REPOURL}/py36-urllib3-1.22.txz
pkg add ${REPOURL}/py36-requests-2.18.4.txz
pkg add ${REPOURL}/py36-yaml-3.12.txz

# install pandas with all its dependencies
pkg add ${REPOURL}/binutils-2.30_2,1.txz
pkg add ${REPOURL}/gcc-ecj-4.5.txz
pkg add ${REPOURL}/mpfr-3.1.6.txz
pkg add ${REPOURL}/mpc-1.1.0.txz
pkg add ${REPOURL}/gcc6-6.4.0_4.txz
pkg add ${REPOURL}/blas-3.5.0_4.txz
pkg add ${REPOURL}/cblas-1.0_8.txz
pkg add ${REPOURL}/lapack-3.5.0_4.txz
pkg add ${REPOURL}/openblas-0.2.20_2,1.txz
pkg add ${REPOURL}/suitesparse-4.0.2_8.txz
pkg add ${REPOURL}/py36-numpy-1.13.3_2,1.txz
pkg add ${REPOURL}/py36-bottleneck-1.2.1_3.txz
pkg add ${REPOURL}/py36-six-1.11.0.txz
pkg add ${REPOURL}/py36-dateutil-2.6.1.txz
pkg add ${REPOURL}/py36-numexpr-2.6.4_1.txz
pkg add ${REPOURL}/py36-pytz-2018.3,1.txz
pkg add ${REPOURL}/py36-pandas-0.22.0_1.txz

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

