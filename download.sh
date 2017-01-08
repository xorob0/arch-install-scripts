#!/bin/bash

function keyboard()
{
	# Load azerty keyboard
	loadkeys fr &> /dev/null
}

function connect_wifi()
{
	systemctl stop dhcpd.service &> /dev/null
	wifi-menu &> /dev/null
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
	rm formating.sh &> /dev/null
	rm install.sh &> /dev/null
	rm partitionning.sh &> /dev/null
	rm packages.sh &> /dev/null
	rm user.sh &> /dev/null
}

function download()
{
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/formating.sh &> /dev/null
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/install.sh &> /dev/null
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/partitionning.sh &> /dev/null
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/packages.sh &> /dev/null
	wget https://raw.githubusercontent.com/xorob0/arch-install-scripts/master/user.sh &> /dev/null
}

# Using fonctions in the right order

keyboard

internet_check
clear

clean

download

./install.sh