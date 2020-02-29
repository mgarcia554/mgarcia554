#!/bin/bash

nic=$(hostname -i)
HN=ALweb01
DOMN=.cyber.net

HN2=ALweb02


httpdInstall() {

	yum install httpd24 php72 php72-mysqlnd -y
	yum list installed | grep -i php
	yum list installed | grep -i httpd
	service httpd start
	chkconfig httpd on
	cd /var/www/html


}

DucklingtonConfig() {

	tar -xzvf Files.tar.gz
	cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
	cat ~/httpd.conf>>/etc/httpd/conf/httpd.conf 

	mkdir -p /var/www/ducklington.cyber.net/public_html

	mkdir /var/www/ducklington.cyber.net/logs

	touch /var/www/ducklington.cyber.net/public_html/index.html

	cat ~/index1.html>/var/www/ducklington.cyber.net/public_html/index.html	

	service httpd restart

	service httpd restart

}

BucknellConfig() {

	tar -xzvf Files.tar.gz
	cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
	cat ~/httpd2.conf>>/etc/httpd/conf/httpd.conf 

	mkdir -p /var/www/bucknell.cyber.net/public_html

	mkdir /var/www/bucknell.cyber.net/logs

	
	touch /var/www/bucknell.cyber.net/public_html/index.html

	cat ~/index2.html>/var/www/bucknell.cyber.net/public_html/index.html	

	service httpd restart

	service httpd restart

}

installWeb() {

	cd /etc/httpd/conf/httpd.conf

	sed -i s/*/$nic/ httpd.conf

}

while [ 1 ]
do
CHOICE=$(whiptail --title "Setup Selection(4)" --menu "Choose what you would like to do::" 13 80 4 \
	"1" "httpdInstall" \
	"2" "DucklingtonConfiuration" \
	"3" "BucknellConfiguration" \
	"4" "Install" \
	"0" "Exit" 3>&1 1>&2 2>&3)
	case $CHOICE in

	1)
		httpdInstall;;
	2)
		DucklingtonInstall;;
	3)
		BucknellInstall;;
	4)
		installWeb;;		
	0)
		break;;
	*)
		clear;;
	esac

	echo -en "\n\n\t\t\t\tHit any key to continue: "
	read -n 1 line	
		
done
clear



