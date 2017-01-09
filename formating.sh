#!/bin/bash

function ask_sure()
{
	# Ask user to verify the partitions
	fdisk -l
	echo ""
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
		*) :
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

function format_root()
{
	echo "Formating root partition..."

	# Formating root to ext4
	mkfs.ext4 $ROOT
}

function format_boot()
{
	echo "Formating boot partition..."

	# Fomating boot to FAT32
	mkfs.dos -F 32 $BOOT
}

function format_home()
{
	echo "Formating home partition..."

	# Formating home to ext4
	mkfs.ext4 $HOMEP
}

function format_swap()
{
	echo "Making swap partition..."

	# Formating and activating swap
	mkswap $SWAP
	swapon
}

function mount_root()
{
	echo "Mounting root partition..."

	# Mounting root to /mnt
	mount $ROOT /mnt
}

function mount_boot()
{
	echo "Mounting boot partition..."

	# Creating /mnt/boot
	mkdir /mnt/boot

	# Mounting boot to /mnt/boot
	mount $BOOT /mnt/boot
}

function mount_home()
{
	echo "Mounting home patition..."

	# Creating /mnt/home
	mkdir /mnt/home

	# Mounting home to /mnt/home
	mount $HOMEP /mnt/home
}

clear

ask
clear

format_root
clear
mount_root
clear

# Only try to format boot if it exist
if [ ! -z "$BOOT" ]
then
	format_boot
	clear
	mount_boot
	clear
fi

# Only try to format home if it exist
if [ ! -z "$HOMEP" ]
then
	format_home
	clear
	mount_home
	clear
fi

# Only try to format swap if it exist
if [ ! -z "$SWAP" ]
then
	format_swap
	clear
fi
