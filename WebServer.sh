#!/bin/bash
nic=$(hostname -i)
httpdInstall() {

	yum install httpd24 php72 php72-mysqlnd -y
	yum list installed | grep -i php
	yum list installed | grep -i httpd
	service httpd start
	chkconfig httpd on
	cd /var/www/html
	
	#wget https://data-587.s3.amazonaws.com/WebServer.sh
	#wget https://data-587.s3.amazonaws.com/Files.tar.gz


}

DucklingtonConfig() {

	tar -xzvf Files.tar.gz
	cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
	cat ~/httpd.conf>>/etc/httpd/conf/httpd.conf 

	mkdir -p /var/www/ducklington.cyber.net/public_html

	mkdir /var/www/ducklington.cyber.net/logs

	touch /var/www/ducklington.cyber.net/public_html/index.html

	cat ~/index1.html>/var/www/ducklington.cyber.net/public_html/index.html	

}

BucknellConfig() {

	tar -xzvf Files.tar.gz
	cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
	cat ~/httpd2.conf>>/etc/httpd/conf/httpd.conf 

	mkdir -p /var/www/bucknell.cyber.net/public_html

	mkdir /var/www/bucknell.cyber.net/logs

	
	touch /var/www/bucknell.cyber.net/public_html/index.html

	cat ~/index2.html>/var/www/bucknell.cyber.net/public_html/index.html	

	

}


while [ 1 ]
do
CHOICE=$(whiptail --title "Setup Selection(4)" --menu "Choose what you would like to do::" 13 80 4 \
	"1" "httpdInstall" \
	"2" "DucklingtonConfiuration" \
	"3" "BucknellConfiguration" \
	"0" "Exit" 3>&1 1>&2 2>&3)
	case $CHOICE in

	1)
		httpdInstall;;
	2)
		DucklingtonConfig;;
	3)
		BucknellConfig;;	
	0)
		break;;
	*)
		clear;;
	esac

	echo -en "\n\n\t\t\t\tHit any key to continue: "
	read -n 1 line	
		
done
clear

cd /etc/httpd/conf
sed -i s/*:80/$nic:80/ httpd.conf
service httpd restart
service httpd restart

