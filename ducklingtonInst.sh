#!/bin/bash



cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
cat ~/httpd.conf>>/etc/httpd/conf/httpd.conf 

mkdir -p /var/www/ducklington.cyber.net/public_html

mkdir /var/www/ducklington.cyber.net/logs


touch /var/www/ducklington.cyber.net/public_html/index.html

cat ~/index1.html>/var/www/ducklington.cyber.net/public_html/index.html

service httpd restart

service httpd restart
