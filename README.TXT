please run setup.sh with sudo


The following is an is a killswitch script that reboots the computer when the sudo password is entered incorrectly 3 times. Of course this isn't supposed to be ULTRA secure as it can easily be bypassed by ctrl+c'ing after the first incorrect password attempt.

This checks the auth.log file for 3 incorrect password attempts every 30 seconds.
It first writes what is already in that log file to a text file and then after the 30 seconds it writes from the log file into a different file and compares them.
if the log files do not match it reboots the computer in 20 seconds. This project overall is just a cool sysadmin script i wanted to make and try out.

the script can be reset by doing 

sudo /usr/sbin/ipsDms.sh reset

and the script also sets itself up

to stop it in it's tracks just stop it like any old service to remove it just delete all the necessary files. 
