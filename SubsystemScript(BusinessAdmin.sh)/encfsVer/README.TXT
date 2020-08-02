Welcome to my Business Administration Simulation script!

This script works by setting up a subsystem inside of you're already existing linux subsystem.

Requirements:
Ubuntu 18.04.4

run with: sudo ./BusinessAdmin.sh

The first thing you should run in this script is setup:
		This function sets up the subsystem for you as well as checking to see if you
		Have Ubuntu 18.04.4 installed as your linux operating system of choice.
		After this is proceeds to read from a file to create the users that are apart of this simulation. 
		It then proceeds to make the rest of the subsystem before sending you back to the main screen
		(This also installs mutt which allows you to check your email from the terminal)

SETTING UP ENCFS:::

	run setup with: sudo ./BusinessAdmin.sh	

	let the install run
	when you get to a gui screen press ok
	when it asks you for expert or paranoia type p
	enter your encfs password and then let the install continue.

Login:(you will be propmted to enter your encfs password. ------ encfs will me unmounted at exit if there isn't another process using it. If there is end that process re-run the script and then exit again)
	(BY DEFAULT THERE IS ONE ACCOUNT CALLED admin WITH THE PASSWORD OF admin)
	(((This account can be deleted by logging in as admin > management > make new user > go through the steps and say yes to making this user an admin) login as new user > go back to management > Delete user > delete the old admin account))PLEASE SEE THE CAPS WARNING IN THE Make new user SECTION OF THIS README IT'S IMPORTANT FOR THIS STEP)


	This function takes you to a log in screen to chose weather you want to 
	log in as an administrator or employee
	From there you can log in as one or the other but an employee cannot login as admin and vice versa.
	This is only possible because of UUID and Group ID authentication. The script also uses grep -w to check for the exact user name entered in by you, the user and also checks the second field ($2) in the separator to see if the password you entered in matches as well.

Main functions(These are account wide functions):

	The employee has many functions(but not as much as the administrator)
	(Shared functions won't be typed twice)
	Auto clock-in -- This function automatically clocks in the user by calling the date command in seconds which calculates the amount of seconds passed from the creation of GNU/Linux itself. 
	Auto Clock-out -- This function works the exact same as auto clock-in but subtracts the two date commands and then divides it by 3600 to get the amount of time the user has works in hours and puts it into a file for future reference.

	Check work email -- This function uses mutt and logs you into your email that has been configured with imaps (you must know your email password)

	Create new Libre Office Documents -- This functions opens to a privy of other functions
		The functions inside of this one allows you to:
				Create new libre office writer documents
				Create new libre office calculator documents
				Create new impress documents
				Create new draw documents 

	Open libre office documents -- (works almost the exact same way as Create New)
			This opens up libre office documents that are saved inside /etc/users and only requires you to type up the file name or directory path/file path to the file. 
			(/etc/users is already populated and there is no need to type it up)

Employee functions:
	Make New Payments File -- 
			This functions creates a new Libre Office Calculator Document
	
	Open Payments file -- 
			This functions works the exact same way as the previous one stated
			except that you need to enter in a path to the calculator file with 
			/etc/users already being populated


Administrator:
	
	Management -- 
		Make new user:(WARNING: EACH USERNAME MUST BE UNIQUE)
				This makes a new user inside of teh database file that can be logged into(you can also chose what type of user this is(Admin or Employee)

		Delete User:
				This allows the administrator to delete a user and disables the account from
				Logging-in by deleteing the user UUID.

		Make new directory:
			This allows the administrator to make a new directory inside of /etc/users
			with /etc/user already being populated. The only thing to type is the directory/directory path
	
