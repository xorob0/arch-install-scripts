#!/bin/bash

function ask_disk()
{
	echo "Wich of these disks do you want to partition ?"
	ls /dev/sd[a-z]
	read DISK_NUMBER
}

function partition_disk()
{
	# Launch interactive partitionning tool
	cfdisk $DISK_NUMBER
}

function verify_partitionning()
{
	# List available partitions
	fdisk -l $DISK_NUMBER
	echo "Are you sure of your partitonning ? (Y/n)"
	read ANS_SURE
	clear
	case $ANS_SURE in
		# If sure, go on to the formating
		Y) . ./formating.sh
			;;
		y) . ./formating.sh
			;;
		# If unsure, start over
		N) ask_disk
			;;
		n) ask_disk
			;;
		*) . ./formating.sh
	esac
}

clear

ask_disk
clear

partition_disk
clear

verify_partitionning
clear
