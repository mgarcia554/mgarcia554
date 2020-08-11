This script automates the installation of the 1.3tft-lcd screen by waveshare!!
Please run this script from an admin account!!!

Please enable SPI through sudo raspi-config as well before running this

MORE INFO CAN BE FOUND ON MY Configuring 1.3Inch-waveshare LCD.txt FILE ON GITHUB!!!!

Running the script::

	Please run this script with: sudo ./waveshare1.3Setup.sh

The first thing this script is going to do is unzip the tar file
After this it's going to run the main menu where the functions are:

main functions:

	tftConf::
		This function sets up the necessary kernel modules and drivers for the 1.3Inch thin film transistor screen
		by WaveShare.
	
		After this is complete please do:
			ls -l /dev | grep fb1

		to see if everything installed correctly	

	desktopConf::
		This function configures the desktop display using cmake and git.
		The first thing is does is after installing those two is get a clone of fbcp
		so we can make a perfect copy of the primary frame buffer in the secondary framebuffer

		after this we use cmake and make to make an executable installer to install fbcp to the proper directory/folder
		we then proceed to overwrite rc.local with the proper configurations and edit our display settings in /boot/config.txt

after all of this the screen should now be exclusively displaying on the 1.3" tft display!!

ENJOY