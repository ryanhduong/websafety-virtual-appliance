#!/bin/csh

# add python modules
env ASSUME_ALWAYS_YES=YES pkg install -y python py27-sqlite3 py27-ldap py27-pytz py27-openssl py27-django111 py27-requests py27-dateutils py27-pandas

# add apache
env ASSUME_ALWAYS_YES=YES pkg install -y apache24 ap24-mod_wsgi4

# add other important modules
env ASSUME_ALWAYS_YES=YES pkg install -y openldap-client sudo ca_root_nss

# autostart apache
grep -e '^\s*apache24_enable\s*=\s*\"YES\"\s*$' /etc/rc.conf
if [ $? -ne 0 ]; then
	echo "apache24_enable=\"YES\"" >> /etc/rc.conf
fi
