#!/bin/bash

httpdInstall() {
	yum install httpd24 php72 php72-mysqlnd -y
	yum list installed | grep -i php
	yum list installed | grep -i httpd
	service httpd start
	chkconfig httpd on
	chkconfig | grep httpd on
	groupadd www
	usermod -a -G www ec2-user
	cat /etc/group
	echo "type exit"
}

sqlInstall(){
	tar -zxvf myGuitarShopPhp.tar.gz
	ll scripts/
	sudo -i
	yum install mysql -y

	echo "Type this: mysql -h (endpoint rds) -P3306 -u root -p"
	echo "In SQL type this: \. /home/ec2-user/scripts/my_guitar_shop1.sql"
	echo "show databases;"
	echo "exit"
}

Finishing(){
	
	ll /var
	sudo chown root:www /var/www
	sudo chmod 2775 /var/www
	sudo cp database_error.php database.php index.php main.css /var/www/html
	find /var/www -type d -exec sudo chmod 2775 {} +
	find /var/www -type d -exec sudo chmod 0664 {} +
	cd scripts/
	ll /var/www/html

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

echo "when exited it'll auto run groups then re-run the script and run finish"
groups

