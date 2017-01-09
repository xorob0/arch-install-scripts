#!/bin/bash

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
	echo "Updating system clock..."

	# Update the system clock
	timedatectl set-ntp true
}

function partition_check()
{
	# Ask if partitionning is needed
	echo "Do you want to partiton your disk(s) ? (Y/n)"
	ANS_PARTITION="Y"
	read ANS_PARTITION
	case "$ANS_PARTITION" in
		Y) . ./partitionning.sh
			;;
		y) . ./partitionning.sh
			;;
		N) . ./formating.sh
			;;
		n) . ./formating.sh
			;;
		*) . ./partitionning.sh
			;;
	esac
}

function pacstrap_base()
{
	echo "Installing base..."

	# Installin base
	pacstrap /mnt base base-devel
}

function gen_fstab()
{
	echo "Generating fstab..."

	# Generating fstab
	genfstab -U /mnt >> /mnt/etc/fstab
}

function timezone()
{
	echo "Synchronysing timezone..."

	# Use Bruxelles time
	arch-chroot /mnt ln -s /usr/share/zoneinfo/Europe/Brussels /etc/localtime

	# Sync hardware clock
	arch-chroot /mnt hwclock --systohc
}

function locale_gen()
{
	echo "Generating locale..."

	# Uncomment en_US.UTF-8 and fr_BE.UTF-8 frome /etc/locale.gen
	arch-chroot /mnt sed -i '/#en_US.UTF-8/s/^#//g' /etc/locale.gen
	arch-chroot /mnt sed -i '/#fr_BE.UTF-8/s/^#//g' /etc/locale.gen

	# Generate locale
	arch-chroot /mnt locale-gen

	# Set en_US.UTF-8 as default locale
	rm /mnt/etc/locale.conf
	echo "LANG=en_US.UTF-8" >> /mnt/etc/locale.conf

	# Set keyboard to azerty in console
	rm /etc/vconsole.conf
	echo "KEYMAP=fr" >> /mnt/etc/vconsole.conf
}

function hostname_gen()
{
	echo "What is the hostname of this machine ?"
	read NAME

	# Set hostname in /etc/hostname
	rm /mnt/etc/hostname
	echo "$NAME" >> /mnt/etc/hostname

	# Set hostname in /etc/hosts
	echo "127.0.0.1	$NAME.localdomain	$NAME" >> /mnt/etc/hosts
}

function mkinit()
{
	echo "Making init..."

	# Make init for kernel linux
	arch-chroot /mnt mkinitcpio -p linux
}

function pass()
{
	echo "Setting root password..."

	# Set root Password
	arch-chroot /mnt passwd

}

function create_user()
{
	echo "Enter your username"
	read USERNAME

	# Adding the user to the group wheel
	arch-chroot /mnt useradd -m -G wheel -s /bin/bash $USERNAME

	clear

	echo "Setting user password"

	# Set user password
	arch-chroot /mnt passwd $USERNAME
}

function user_script()
{
	echo "Copying user script..."

	# Copying user.sh to new home
	cp user.sh /mnt/home/$USERNAME/script.sh

	read a
}

function unmount()
{
	echo "Unmounting..."

	# Unmounting the partitions before shutdown
	umount -R /mnt
}

# Using fonctions in the right order

clear

#boot_verif

time_sync
clear

partition_check
clear

pacstrap_base
clear

gen_fstab
clear

timezone
clear

locale_gen
clear

hostname_gen
clear

mkinit
clear

pass
clear

create_user
clear

. ./packages.sh
clear

unmount

#reboot
