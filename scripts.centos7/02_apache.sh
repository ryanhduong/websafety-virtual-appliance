#!/bin/bash

# all web packages are installed as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install apache web server and required tools
yum -y install httpd httpd-devel krb5-workstation mc

# make apache autostart on reboot
systemctl enable httpd.service

# install python 3 libs and compiler (needed for reportlab and pandas)
yum -y install python34 python34-pip python34-devel gcc-c++

# install python django for web ui
pip3 install django==2.1.2
pip3 install pytz
pip3 install requests
pip3 install PyYAML
pip3 install PyOpenSSL
pip3 install pandas
pip3 install mod-wsgi
pip3 install reportlab==3.4.0

# enable the mod_wsgi module for python3 in apache
mod_wsgi-express install-module > /etc/httpd/conf.modules.d/02-wsgi.conf

#yum -y install python-ldapnet-tools libjpeg-devel zlib-devel patch

# this fixes some apache errors when working with python-django wsgi
#echo "WSGISocketPrefix /var/run/wsgi" >> /etc/httpd/conf.d/wsgi.conf

# and restart apache
service httpd restart
