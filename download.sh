#!/bin/bash

function keyboard()
{
	echo "Setting keyboard layout..."

	# Load azerty keyboard
	loadkeys fr
}

function connect_wifi()
{
	echo "Configuring wifi connection..."

	systemctl stop dhcpd.service
	wifi-menu
	internet_check
}
function internet_check()
{
	# Check internet connection and lauch connection script if not connected
	if ping -c 1 195.238.2.21 &> /dev/null
	then
		echo "You are connected to the internet !"
		read a
	else
		echo "We need to configure your internet connection."
		read a
		connect_wifi
	fi
}

function clean()
{
	echo "Removing old files..."

	# Cleaning last files
	rm formating.sh
	rm install.sh
	rm partitionning.sh
	rm packages.sh
	rm user.sh
}

function download()
{
	echo "Downloading new scripts..."

	# Downloading scripts from github
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/formating.sh
	clear
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/install.sh
	clear
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/partitionning.sh
	clear
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/packages.sh
	clear
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/user.sh
	clear

	echo "Setting rights for the new scripts..."

	# Adding execution right to scripts
	chmod 755 formating.sh &> /dev/null
	chmod 755 install.sh &> /dev/null
	chmod 755 partitionning.sh &> /dev/null
	chmod 755 packages.sh &> /dev/null
	chmod 755 user.sh &> /dev/null
}

# Using fonctions in the right order

clear

keyboard
clear

internet_check
clear

clean
clear

download
clear

./install.sh
