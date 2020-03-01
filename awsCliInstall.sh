

echo "run this on the ec2 web instances"


echo "wget https://raw.githubusercontent.com/mgarcia554/mgarcia554/master/awsCliInstall.sh"


installAws() {
	
	#Comment for regular Ubuntu 18.04 box
	#sudo apt-get install curl then run everything below
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	/usr/local/bin/aws aws --version
	aws configure
	nano ~/.aws/credentials
	aws configure
}

makeBucket(){
	
	aws s3 mb s3://data-587
	wget https://raw.githubusercontent.com/mgarcia554/mgarcia554/master/MidTerm.sh
	wget https://raw.githubusercontent.com/mgarcia554/mgarcia554/master/Files.tar.gz 
	aws s3 cp MidTerm.sh s3://data-587
	aws s3 cp Files.tar.gz s3://data-587
	#wget https://data-587.s3.amazonaws.com/MidTerm.sh



}

while [ 1 ]
do
CHOICE=$(whiptail --title "Setup Selection(4)" --menu "Choose what you would like to do::" 13 80 4 \
	"1" "installAws" \
	"2" "makeBucket" \
	"0" "Exit" 3>&1 1>&2 2>&3)
	case $CHOICE in

	1)
		installAws;;
	2)
		makeBucket;;
	0)
		break;;
	*)
		clear;;
	esac

	echo -en "\n\n\t\t\t\tHit any key to continue: "
	read -n 1 line	
		
done
clear
