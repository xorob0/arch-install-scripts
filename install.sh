#!/bin/bash

function keyboard()
{
	# Load azerty keyboard
	loadkeys fr &> /dev/null
}

function internet()
{
	# Check internet connection and lauch connection script if not connected
	if ping -c 1 195.238.2.21 &> /dev/null
	then
		echo "No need for a configuration, you are already connected to the internet !"
		read a
	else
		echo "We need to configure your internet connection."
		read a
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
		exit
	fi
}

function time_sync()
{
	# Update the system clock
	timedatectl set-ntp true &> /dev/null
}

function partitionning()
{
	# Ask if partitionning is needed
	echo "Do you want to partiton your disk(s) ? (Y/n)"
	CHOIX_PARTITION="Y"
	read CHOIX_PARTITION
	echo "$CHOIX_PARTITION"
	case "$CHOIX_PARTITION" in
		Y) echo "Partitionning"
			;;
		y) echo "Partitionning"
			;;
		N) echo "Not partitionning"
			;;
		n) echo "Not partitionning"
			;;
	esac
}
