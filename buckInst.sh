#!/bin/bash



cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
cat ~/httpd.conf>>/etc/httpd/conf/httpd.conf 

mkdir -p /var/www/bucknell.cyber.net/public_html

mkdir /var/www/bucknell.cyber.net/logs


touch /var/www/bucknell.cyber.net/public_html/index.html

cat ~/index2.html>/var/www/bucknell.cyber.net/public_html/index.html

service httpd restart

service httpd restart
