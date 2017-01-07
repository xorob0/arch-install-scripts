#!/bin/bash

function ask_sure()
{
	# Ask user to verify the partitions
	fdisk -l
	echo "root = $ROOT"
	echo "home = $HOMEP"
	echo "boot = $BOOT"
	echo "swap = $SWAP"
	echo "Are you sure of these partitions ? (Y/n)"
	read ANS_ASK_SURE
	case $ANS_ASK_SURE in
		# Use : for "Do nothing"
		Y) :
			;;
		y) :
			;;
		N) ask
			;;
		n) ask
			;;
		*) echo "Please use Y or N" && ask_sure
			;;
	esac
}

function ask()
{
	# Defining partition numbers for everything
	fdisk -l
	echo "Wich is your root partition ?"
	read ROOT
	clear

	fdisk -l
	echo "Wich is your home partition ?"
	read HOMEP # Using HOMEP because $HOME is already in use
	clear

	fdisk -l
	echo "Wich is your boot partition ?"
	read BOOT
	clear

	fdisk -l
	echo "Wich is your swap partition ?"
	read SWAP
	clear

	ask_sure
}

function format_essential()
{
	# Formating root to ext4
	mkfs.ext4 $ROOT &> /dev/null

	# Fomating boot to FAT32
	mkfs.dos -F 32 $BOOT &> /dev/null
}

function format_home()
{
	# Formating home to ext4
	mkfs.ext4 $HOMEP &> /dev/null
}

function format_swap()
{
	# Formating and activating swap
	mkswap $SWAP &> /dev/null
	swapon &> /dev/null
}

function mount_essential()
{
	# Mounting root to /mnt
	mount $ROOT /mnt

	# Creating /mnt/boot
	mkdir /mnt/boot

	# Mounting boot to /mnt/boot
	mount $BOOT /mnt/boot
}

function mount_home()
{
	# Creating /mnt/home
	mkdir /mnt/home

	# Mounting home to /mnt/home
	mount $HOMEP /mnt/home
}

ask
clear

format_essential

# Only try to format home if it exist
if [ ! -z "$HOMEP" ]
then
	format_home
fi

# Only try to format swap if it exist
if [ ! -z "$SWAP" ]
then
	format_swap
fi
