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

function boot_verif()
{
	# Verify boot mode
	if [ ! -d "/sys/firmware/efi/efivars/" ]
	then
		# if not in EFI mode return error 1
		echo "Please boot in EFI mode"
		read a
		#reboot
		exit
	fi
}

function time_sync()
{
	# Update the system clock
	timedatectl set-ntp true &> /dev/null
}

function partition_check()
{
	# Ask if partitionning is needed
	echo "Do you want to partiton your disk(s) ? (Y/n)"
	ANS_PARTITION="Y"
	read ANS_PARTITION
	case "$ANS_PARTITION" in
		Y) bash partitionning.sh
			;;
		y) bash partitionning.sh
			;;
		N) bash formating.sh
			;;
		n) bash formating.sh
			;;
		*) echo "Just use Y or N" && partition_check;;
	esac
}
keyboard
boot_verif
internet_check
clear
#time_sync
partition_check
clear
