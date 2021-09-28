#This script moves everything to their proper directories
setup() {

	tar -zxvf /home/user/Desktop/ipsIds.tar.gz
	mv sudoKillSwitch.service /etc/systemd/system
	chmod +x ipsDms.sh
	mv ipsDms.sh /usr/sbin/

	systemctl daemon-reload
	systemctl enable sudoKillSwitch.service
	systemctl start sudoKillSwitch.service

}

setup


echo -en "\n\n Please reset the computer for the changes to take proper effect\n\n"
sleep 6
