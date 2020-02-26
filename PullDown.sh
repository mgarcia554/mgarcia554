#!/bin/bash
yum install httpd24 php72 php72-mysqlnd -y
yum list installed | grep -i php
yum list installed | grep -i httpd
servvice httpd start
chkconfig httpd on
cd /var/www/html

wget https://raw.githubusercontent.com/mgarcia554/mgarcia554/master/DuckFi.tar.gz
wget https://raw.githubusercontent.com/mgarcia554/mgarcia554/master/ducklingtonInst.sh

echo "Please run 'chkconfig | grep httpd' to see if it's working you can also check the bash script 'sudo nano PullDown.sh'"

#sudo chkconfig httpd on
#sudochkconfig | grep httpd

