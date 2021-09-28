#This script moves everything to their proper directories
setup() {

	tar -zxvf ipsIds.tar.gz
	mv sudoKillSwitch.service /etc/systemd/system
	chmod +x ipsDms.sh
	mv ipsDms.sh /usr/sbin/

	systemctl daemon-reload
	systemctl enable sudoKillSwitch.service
	systemctl start sudoKillSwitch.service

}
