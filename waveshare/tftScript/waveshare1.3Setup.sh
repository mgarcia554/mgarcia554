#!/bin/bash


tftConf() {

	clear
	read -e -p "Please enter your username: " -i "" EUser
	echo -en "\n\nYour admin account is $EUser. \n\n"
	sleep 5
	clear	
	
	cd /home/$EUser/Desktop
	cat tft.txt>>/etc/modules
	echo -en "\n\nConfiguring the kernel modules\n\n"
	sleep 5
	clear
	touch /etc/modprobe.d/fbtft.conf
	echo -en "\n\nConfiguring flexfb and fbtft drivers\n\n"
	sleep 5
	cat tft2.txt>>/etc/modprobe.d/fbtft.conf
	clear
	echo -en "\n\nFinished!\nPlease read README.txt after reboot\n\n"
	sleep 5

	reboot
}

desktopConf() {

	clear
	read -e -p "Please enter your username: " -i "" EUser
	echo -en "\n\nYour admin account is $EUser. \n\n"
	sleep 5
	clear

	echo -en "\n\nConfiguring desktop display\n\n"
	sleep 5
	clear
	sudo apt-get install cmake git -y
	cd ~
	git clone https://github.com/tasanakorn/rpi-fbcp
	cd rpi-fbcp/
	mkdir build
	cd build/
	cmake ..
	make
	sudo install fbcp /usr/local/bin/fbcp
	cat /home/$EUser/Desktop/local.txt>/etc/rc.local
	cat /home/$EUser/Desktop/displaySettings.txt>>/boot/config.txt
	clear
	echo -en "\n\nFinished!! Now rebooting!\n\n"
	cd /home/$EUser/Desktop && rm -rf tft.txt tft2.txt local.txt displaySettings.txt
	sleep 5
	reboot


}


readMe() {

	clear
	read -e -p "Please enter your username: " -i "" EUser
	echo -en "\n\n Your admin account is $EUser. \n\n"
	sleep 5
	clear	
	
	cat /home/$EUser/Desktop/README.txt | more

}

menu() {
	clear
	while [ 1 ]
	do
	CHOICE=$(whiptail --title "Setup Selection(1)" --menu "Choose what you would like to do::" 13 80 4 \
		"1" "Configure Modules for TFT" \
		"2" "Display Desktop" \
		"3" "Read me" \
		"0" "Exit" 3>&1 1>&2 2>&3)
		case $CHOICE in
	
		1)
			tftConf;;
		2)
			desktopConf;;
		3)
			readMe;;
		0)
			break;;
		*)
			clear;;
		esac


		echo -en "\n\n\t\t\t\tHit any key to continue: "
		read -n 1 line
	done
	clear
}

tar -zxvf files.tar.gz
menu
