#!/bin/bash
nic=$(hostname -i)
httpdPhpInstall() {

	yum install httpd24 php72 php72-mysqlnd -y
	yum list installed | grep -i php
	yum list installed | grep -i httpd
	service httpd start
	chkconfig httpd on
	cd /var/www/html
	usermod -a -G www ec2-user
	cat /etc/group
	echo "type exit"

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

	cd /etc/httpd/conf
	sed -i s/*:80/$nic:80/ httpd.conf
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

	cd /etc/httpd/conf
	sed -i s/*:80/$nic:80/ httpd.conf
	service httpd restart
	service httpd restart

}

sqlInstall(){
	tar -zxvf MyGuitarShopPhp.tar.gz
	ls -l scripts/
	sudo -i
	yum install mysql -y

	echo "Type this: mysql -h (endpoint rds) -P3306 -u root -p"
	echo "In SQL type this: \. /root/scripts/my_guitar_shop1.sql"
	echo "show databases;"
	echo "exit"
}


finishingSqlInstall(){
	
	ls -l /var
	sudo chown root:www /var/www
	sudo chmod 2775 /var/www
	cd scripts/
	sudo cp database_error.php database.php index.php main.css /var/www/html
	find /var/www -type d -exec sudo chmod 2775 {} +
	find /var/www -type f -exec sudo chmod 0664 {} +
	ls -l /var/www/html

	echo "nano /var/html/database.php"
	echo "change mysql:host=(endpoint of rds)"
	echo "change $username ='mgs_user' from mgs_user to root";
	echo "change the $password ='pa55word' to ?Defen16";

}

while [ 1 ]
do
CHOICE=$(whiptail --title "Setup Selection(4)" --menu "Choose what you would like to do::" 13 80 4 \
	"1" "httpdPhpInstall" \
	"2" "DucklingtonConfiuration" \
	"3" "BucknellConfiguration" \
	"4" "sqlInstall" \
	"5" "finishingSqlInstall" \
	"0" "Exit" 3>&1 1>&2 2>&3)
	case $CHOICE in

	1)
		httpdPhpInstall;;
	2)
		DucklingtonConfig;;
	3)
		BucknellConfig;;
	4)
		sqlInstall;;
	5)
		finishingSqlInstall;;	
	0)
		break;;
	*)
		clear;;
	esac

	echo -en "\n\n\t\t\t\tHit any key to continue: "
	read -n 1 line	
		
done
clear



