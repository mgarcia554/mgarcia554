#!/bin/bash



#Passwords for the emails are the same as the ones in the database
#Database layout
#Username:Password:GroupID
#Group ID has been implemented so that way regular users cannot login to the admin account through employee login(if they magically figure out the convoluted password)


#global variables to make functions in Employee section work
autoClock=$(date +%s)
date=$(date)


##############EMPLOYEE#############################

#################### EMPLOYEE DASHBOARD AND IT'S FUNCTIONS FOR FUNCTIONING PROPERLY #################################

Clockout() {
	#Use the declare command to set variable and functions attributes. -i specifies interger attribute
	echo -en "User $EUser has auto clocked out \n\n"
	declare -i autoClock2=$(cat /etc/users/$EUser/Seconds)
	declare -i hoursWorked=$(($autoClock - $autoClock2))
	math=$(($hoursWorked / 3600))
	sudo touch timesheet
	sudo echo -en "$EUser, Hours worked for $date\n">>timesheet
	sudo echo -en "$math hours\n\n">>timesheet
	sudo cat timesheet
	sleep 5
	clear
	

}

Clockin() {
	
	echo "User $EUser has auto clocked in"
	sleep 5
	sudo touch Seconds
	sudo date +%s>Seconds
	clear
	
}

WorkEmail() {
	
	#Login passwords for emails are the same as in the database

	mutt -f "imaps://$EUser@imap.gmail.com/INBOX"
	#Fake email has been replaced with a variable as to personalize connecting to their emails
	
}

newPay() {
	#make a new libre office calculator function so they can save it to /etc/users/$EUser
	localc

}

openPay() {

	#Open a localc file from the subsystem(sub filesystem)
	echo -en "\n\nThere is no need to start with / or /etc/users.\n Please just start with the folder followed by any subdirectory specified with / or the file name\n\n"
	read -e -p "Please enter the full path to the file: " -i "" Dir
	localc /etc/users/"$Dir" 

}

EDash() {
	clear
	echo
	echo
	echo -en "Currently logged in user: " $EUser
	
	sleep 10

	clear
	while [ 1 ]
	do
	CHOICE=$(whiptail --title "Employee Dashboard:" --menu "What would you like to do?\n\n" 13 80 4 \
		"1" "Auto Clock in" \
		"2" "Auto Clock out" \
		"3" "Check Work Email" \
		"4" "Make New Payments File" \
		"5" "Open payments file" \
		"6" "Create new Libre Office Documents" \
		"7" "Open Libre Office Documents" \
		"0" "Exit" 3>&1 1>&2 2>&3)
		case $CHOICE in

		1)
			Clockin;;
		2)
			Clockout;;
		3)
			WorkEmail;;
		4)
			newPay;;
		5)
			openPay;;
		6)
			newLibre;;
		7)
			openLibre;;
		0)
			break;;
		*)
			clear;;
		esac	
	done
	clear

	


}

#################### EMPLOYEE DASHBOARD AND IT'S FUNCTIONS FOR FUNCTIONING PROPERLY #################################


######################################################################## EMPLOYEE LOGIN #######################################
Employee() {

	count=1
	while [ $count -eq 1 ]
	do
		clear
		echo -e "::::::Employee login:::::: \n\n"

		read -e -p "Username:" -i "" EUser 
		read -e -p "Password:" -i "" EPass 
		LINE=$(cat /etc/users/subSysFiles/Database | grep -w $EUser) 
		IFS=':' 
		set $LINE 1>/dev/null #1>/dev/null is required to stop a memory leak that leaks the source code please see the build log for an explaination(Build 4 specifically)
		
		echo "$2">/etc/users/subSysFiles/auth1.txt
		decrypt=$(openssl passwd -6 -salt 123 $EPass)
		echo "$decrypt">/etc/users/subSysFiles/auth2.txt
		cd /etc/users/subSysFiles
		cAuth=$(diff -s auth1.txt auth2.txt)
		echo -en "\n\nAuthenticating...\n\n"
		sleep 5

		#load the default variables into set $1 being username $2 being password and $3 being groupid compare these to the variables
		if [ "$5" = "!!!" ]; then
			echo -en "\n\nThis user has been deleted\n\n"
			sleep 5

		elif [ "$1" = "$EUser" ] && [ "$cAuth" = "Files auth1.txt and auth2.txt are identical" ] && [ "$3" = 3 ];then
			echo 
			echo "Correct Password" 
			count=$[ $count + 1 ] 
			sleep 5 

		else 
				
				echo -e "\nIncorrect username or password.\nPlease enter the correct information!!!\n\n" 
				sleep 3
				
		fi 
		cd "$4"
	done 
	EDash
		

	
		

}
######################################################################## EMPLOYEE LOGIN #######################################

##############EMPLOYEE#############################

#############################ADMIN##########################


deleteUser() {

	read -e -p "How many users do you want to delete?: " -i "" uCount

	count=0
	sleep 5
	clear
	
	while [ $count -lt $uCount ]
	do	

		read -e -p "What user would you like delete?: " -i "" dUsr
		LINE=$(cat /etc/users/subSysFiles/Database | grep -w $dUsr)
		IFS=':'
		set $LINE 1>/dev/null
		if [ "$dUsr" = "$1"  ];then
			cd "$4" && sudo rm * 2>/dev/null
			cd .. && sudo rmdir "$1" 2>/dev/null
 
			sed -i s/$5/"!!!"/ /etc/users/subSysFiles/Database
			clear

			echo -en "\n\nUser:$dUsr deleted successfully...\n\n"
			count=$[ $count + 1 ]
			sleep 5
			clear
		else
			echo -en "\n\nUser not found try again\n\n"
			sleep 5
			clear
		fi
	done
	clear



}

newUser() {



	read -e -p "How many users do you want to create?: " -i "" uCount

	count=0
	sleep 5
	clear
	while [ $count -lt $uCount ]
	do
		
		read -e -p "What is the name of the new user?: " -i "" nUsr
		read -e -p "Is this new user an admin?  (Y)es/(N)o: " -i "" Yn
		read -e -p "What is the password of the new user?: " -i "" Pass

		if [ "$Yn" = 'Y' ] || [ "$Yn" = 'y' ] || [ "$Yn" = 'Yes' ] || [ "$Yn" = 'yes' ];then
			uuid=$(uuidgen)
			crypt=$(openssl passwd -6 -salt 123 $Pass) #hash the users password with sha-512
			sudo echo -en "$nUsr:$crypt:0:/etc/users/$nUsr:$uuid\n">>/etc/users/subSysFiles/Database
			sudo mkdir /etc/users/$nUsr
			count=$[ $count + 1 ]
			echo -en "\n\nUser:$nUsr has been created\n\n"
			sleep 5
			clear

		elif [ "$Yn" = 'N' ] || [ "$Yn" = 'n' ] || [ "$Yn" = 'No' ] || [ "$Yn" = 'no' ];then
			uuid=$(uuidgen)
			crypt=$(openssl passwd -6 -salt 123 $Pass) #hash the users password with sha-512
			sudo echo -en "$nUsr:$crypt:3:/etc/users/$nUsr:$uuid\n">>/etc/users/subSysFiles/Database
			sudo mkdir /etc/users/$nUsr
			echo -en "\n\nUser:$nUsr has been created\n\n"
			sleep 5
			clear
			count=$[ $count + 1 ]
			
		fi
	done
	clear
	
	sleep 3
	clear
}

#################OPEN LIBRE####################

writerO() {
	clear
	echo -en "Opening Libre Office Write file - These files should be saved in a sub-directory of your /etc/users directory\n\nPlease have the name of the file followed by it's extension\n\nExample: dog.odt\n\n"
	echo -en "\n\nThere is no need to start with / or /etc/users.\n Please just start with the folder followed by any subdirectory specified with / or the file name\n\n"
	read -e -p "Please enter the full path to the file: " -i "" Dir
	lowriter /etc/users/"$Dir"
	clear

}

calculatorO() {

	clear
	echo -en "Opening Libre Office Calculator file - These files should be saved in a sub-directory of your /etc/users directory\n\nPlease have the name of the file followed by it's extension\n\nExample: dog.odt\n\n"
	echo -en "\n\nThere is no need to start with / or /etc/users.\n Please just start with the folder followed by any subdirectory specified with / or the file name\n\n"
	read -e -p "Please enter the full path to the file: " -i "" Dir
	localc /etc/users/"$Dir"
	clear


}

impressO() {

	clear
	echo -en "Opening Libre Office Impress file - These files should be saved in a sub-directory of your /etc/users directory\n\nPlease have the name of the file followed by it's extension\n\nExample: dog.odt\n\n"
	echo -en "\n\nThere is no need to start with / or /etc/users.\n Please just start with the folder followed by any subdirectory specified with / or the file name\n\n"
	read -e -p "Please enter the full path to the file: " -i "" Dir
	loimpress /etc/users/"$Dir" 
	clear

}

drawO() {

	clear
	echo -en "Opening Libre Office Draw file - These files should be saved in a sub-directory of your /etc/users directory\n\nPlease have the name of the file followed by it's extension\n\nExample: dog.odt\n\n"
	echo -en "\n\nThere is no need to start with / or /etc/users.\n Please just start with the folder followed by any subdirectory specified with / or the file name\n\n"
	read -e -p "Please enter the full path to the file: " -i "" Dir
	lodraw /etc/users/"$Dir"
	clear

}

openLibre() {

	clear
		while [ 1 ]
		do
		CHOICE=$(whiptail --title "Libre Office Opener:" --menu "What libre office application would you like to open?\n\n" 13 80 4 \
			"1" "Libre Office Writer" \
			"2" "Libre Office Calculator" \
			"3" "Libre Office Impress" \
			"4" "Libre Office Draw" \
			"0" "Exit" 3>&1 1>&2 2>&3)
			case $CHOICE in

			1)
				writerO;;
			2)
				calculatorO;;
			3)
				impressO;;
			4)
				drawO;;
			
			0)
				break;;
			*)
				clear;;
			esac	
		done
		clear

}
#################OPEN LIBRE####################

#########################NEW LIBRE##############################
Draw() {

	clear
	echo -en "\n\nNow Opening Libre Office Draw! \n\n"
	sleep 5
	lodraw
	clear
}


Impress() {

	clear
	echo -en "\n\nNow Opening Libre Office Impress! \n\n"
	sleep 5
	loimpress
	clear
}

Calculator() {

	clear
	echo -en "\n\nNow Opening Libre Office Calculator! \n\n"
	sleep 5
	localc
	clear
}

Writer() {
	
	clear
	echo -en "\n\nNow Opening Libre Office Write! \n\n"
	sleep 5
	lowriter
	clear
}

newLibre() {
		clear
		while [ 1 ]
		do
		CHOICE=$(whiptail --title "Libre Office Creator:" --menu "What libre office application would you like to create?\n\n" 13 80 4 \
			"1" "Libre Office Writer" \
			"2" "Libre Office Calculator" \
			"3" "Libre Office Impress" \
			"4" "Libre Office Draw" \
			"0" "Exit" 3>&1 1>&2 2>&3)
			case $CHOICE in

			1)
				Writer;;
			2)
				Calculator;;
			3)
				Impress;;
			4)
				Draw;;
			
			0)
				break;;
			*)
				clear;;
			esac	
		done
		clear

}
#########################NEW LIBRE##############################
#################################Make dir##########################

makeDir() {

	clear
	read -e -p "Where in /etc/users would you like to make a new directory?: " -i "" Dir
	mkdir /etc/users/"$Dir"
	clear
}




###############################Make dir################################
manage() {
	
		clear
		while [ 1 ]
		do
		CHOICE=$(whiptail --title "Administrative Dashboard:" --menu "What would you like to do?\n\n" 13 80 4 \
			"1" "Make New User" \
			"2" "Delete user" \
			"3" "Create new Libre Office Documents" \
			"4" "Open Libre Office Documents" \
			"5" "Make new directory" \
			"0" "Exit" 3>&1 1>&2 2>&3)
			case $CHOICE in

			1)
				newUser;;
			2)
				deleteUser;;
			3)
				newLibre;;
			4)
				openLibre;;
			5)
				makeDir;;
			
			0)
				break;;
			*)
				clear;;
			esac	
		done
		clear

	

}




#################ADMINISTRATIVE DASHBOARD###############################

ADash() {
	clear
	echo
	echo
	echo -en "Currently logged in user: " $EUser
	
	sleep 10

	clear
	while [ 1 ]
	do
	CHOICE=$(whiptail --title "Administrative Dashboard:" --menu "What would you like to do?\n\n" 13 80 4 \
		"1" "Auto Clock in" \
		"2" "Auto Clock out" \
		"3" "Check Work Email" \
		"4" "Make new spreadsheet file" \
		"5" "Open spreadsheet files" \
		"6" "Management" \
		"0" "Exit" 3>&1 1>&2 2>&3)
		case $CHOICE in

		1)
			Clockin;;
		2)
			Clockout;;
		3)
			WorkEmail;;
		4)
			newPay;;
		5)
			openPay;;
		6)
			manage;;
		
		0)
			break;;
		*)
			clear;;
		esac	
	done
	clear

	


}



#################ADMINISTRATIVE DASHBOARD###############################




#######################################ADMINISTRATIVE LOGIN ##################################

Admin() {

	count=1
	while [ $count -eq 1 ]
	do
		clear
		echo -e "::::::Admin login:::::: \n\n"

		read -e -p "Username:" -i "" EUser 
		read -e -p "Password:" -i "" EPass 
		LINE=$(cat /etc/users/subSysFiles/Database | grep -w $EUser) 
		IFS=':' 
		set $LINE 1>/dev/null #1>/dev/null is required to stop a memory leak that leaks the source code please see the build log for an explaination(Build 4 specifically)
		
		echo "$2">/etc/users/subSysFiles/auth1.txt
		decrypt=$(openssl passwd -6 -salt 123 $EPass)
		echo "$decrypt">/etc/users/subSysFiles/auth2.txt
		cd /etc/users/subSysFiles
		cAuth=$(diff -s auth1.txt auth2.txt)

		echo -en "\n\nAuthenticating...\n\n"
		sleep 5


		#load the default variables into set $1 being username $2 being password and $3 being groupid compare these to the variables
	
		if [ "$5" = "!!!" ]; then
			echo -en "\n\nThis user has been deleted\n\n"
			sleep 5

		elif [ "$1" = "$EUser" ] && [ "$cAuth" = "Files auth1.txt and auth2.txt are identical" ] && [ "$3" = 0 ];then
			echo 
			echo "Correct Password" 
			count=$[ $count + 1 ] 
			sleep 5 

		else 
				
				echo -e "\nIncorrect username or password.\nPlease enter the correct information!!!\n\n" 
				sleep 3
				
		fi 
		cd "$4"
	done 
	ADash
		

	
		

}

#######################################ADMINISTRATIVE LOGIN ##################################



#####################ADMIN##################################



#################################### LOGIN GUI SELECTION SCREEN ############################
Login() {

	encfs /etc/.encrypted /etc/users

	clear
	while [ 1 ]
	do
	CHOICE=$(whiptail --title "Login:" --menu "What would you like to login to?::" 13 80 4 \
		"1" "Employee" \
		"2" "Administrator" \
		"0" "Exit" 3>&1 1>&2 2>&3)
		case $CHOICE in

		1)
			Employee;;
		2)
			Admin;;
		0)
			break;;
		*)
			clear;;
		esac	
	done
	clear


}

#################################### LOGIN GUI SELECTION SCREEN ############################

########################### SETUP ##############################

Setup() {

	sudo ~/Desktop/setup.sh	
	
	tar -zxvf ~/Desktop/files.tar.gz
	file=~/Desktop/crtUsrs #these ~/Desktop files will be updated upon completion of the program
	IFS=':'
	count=1
	flavor=$(lsb_release -d) #this is Linux Standard Base Distrobution Specific Information Relase. with -d we print out a short description of the release saved in a variable
	#as you can see by the if statement this description is very short as the flavor variable is being ran against the exact description
	
	if [ "$flavor" != "Description:	Ubuntu 18.04.4 LTS" ]; then
		echo -en "It is reccomended that this script be ran on Ubuntu 18.04.4\n\n"
		echo -en "Please download that and run it again!!"
		sleep 5
		clear
		exit
	else
		echo -en "Thank you for using my program!!\n\nYou meet the reccomended specs to run this program.\n\nPlease enjoy my sub-system business administration script!!"
		sleep 6
	fi

	sudo apt-get install mutt -y 1>/etc/users/subSysFiles/setupResults.txt

	{
	    for ((i = 0 ; i <= 100 ; i+=15)); 
	    do #<= is required since the progess bar can only go up to 100% as adding 5 will be true even if it is less than or equal to 100 thus giving us 105 and outputting 100 because it is now 105
		#thus making the statement false
		#using < would output 95 and once it equals 100 it will exit the loop because it's no longer less than 100 but equal to it
		echo $i
		sleep 1
	    done
	} | whiptail --gauge "Please wait while we set up..." 6 50 0
	#this gauge is taking standard input via whatever is in brackets through a pipe	
	#Programmed by isaac

	
	cd /etc/users
	while [ $count -eq  1 ] 
	do
		read -r user
		echo $user
	        sudo mkdir $user 2>/dev/null
		sudo chmod 770 /etc/users/$user 2>/dev/null
		count=$[ $count + 1 ]

	done < "$file"
	clear
#How this works. The file is being read all at once as name name name name. So everything is being passed into the commands all at once but separately because of the IFS this is causing it
#to make all the necessary folders for each individual users. After it's done it adds one to count and finishes the loop

	sudo mkdir /etc/users/userDocs
	sudo mkdir /etc/users/userDocs/inventoryAug20xx
	sudo mkdir /etc/users/userDocs/invoicesAug20xx
	sudo mkdir /etc/users/subSysFiles
	sudo chmod 770 /etc/users/* 2>/dev/null
	sudo chmod 770 /etc/users 2>/dev/null
	cd ~/Desktop
	mv ~/Desktop/Database /etc/users/subSysFiles
	mv ~/Desktop/Invoice1.xlsx /etc/users/userDocs/invoicesAug20xx
	mv ~/Desktop/*.xls* /etc/users/userDocs/inventoryAug20xx
	rm -rf ~/Desktop/crtUsrs

	fusermount -u /etc/users
	rm -rf ~/Desktop/setup.sh
}

########################### SETUP ##############################
quit() {

	fusermount -u /etc/users
	exit

}
################## START UP MENU ########################
clear
while [ 1 ]
do
CHOICE=$(whiptail --title "Welcome!!" --menu "What would you like to do?::" 13 80 4 \
	"1" "Setup" \
	"2" "Login" \
	"0" "Exit" 3>&1 1>&2 2>&3)
	case $CHOICE in

	1)
		Setup;;
	2)
		Login;;
	0)
		quit;;
	*)
		clear;;
	esac	
done
clear
################## START UP MENU ########################

