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
	timedatectl set-ntp true &> /dev/null
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
		*) echo "Just use Y or N" && partition_check;;
	esac
}

function pacstrap_base()
{
	echo "Installing base..."
	# Installin base
	pacstrap /mnt base base-devel &> /dev/null
}

function gen_fstab()
{
	echo "Generating fstab..."

	# Generating fstab
	genfstab -L /mnt >> /mnt/etc/fstab &> /dev/null
}

function timezone()
{
	echo "Synchronysing timezone..."

	# Use Bruxelles time
	arch-chroot /mnt ln -s /usr/share/zoneinfo/Europe/Brussels /etc/localtime &> /dev/null

	# Sync hardware clock
	arch-chroot /mnt hwclock --systohc &> /dev/null
}

function locale_gen()
{
	echo "Generating locale..."

	# Uncomment en_US.UTF-8 and fr_BE.UTF-8 frome /etc/locale.gen
	arch-chroot /mnt sed -i '/#en_US.UTF-8/s/^#//g' /etc/locale.gen &> /dev/null
	arch-chroot /mnt sed -i '/#fr_BE.UTF-8/s/^#//g' /etc/locale.gen &> /dev/null

	# Generate locale
	arch-chroot /mnt locale-gen &> /dev/null

	# Set en_US.UTF-8 as default locale
	arch-chroot /mnt rm /etc/locale.conf &> /dev/null
	arch-chroot /mnt echo "LANG=en_US.UTF-8" >> /etc/locale.conf &> /dev/null

	# Set keyboard to azerty in console
	arch-chroot /mnt rm /etc/vconsole.conf &> /dev/null
	arch-chroot /mnt echo "KEYMAP=fr" >> /etc/vconsole.conf &> /dev/null
}

function hostname_gen()
{
	echo "What is the hostname of this machine ?"
	read NAME

	# Set hostname in /etc/hostname
	arch-chroot /mnt rm /etc/hostname &> /dev/null
	arch-chroot /mnt echo "$NAME" >> /etc/hostname &> /dev/null

	# Set hostname in /etc/hosts
	arch-chroot /mnt echo "127.0.0.1	$NAME.localdomain	$NAME" >> /etc/hosts &> /dev/null
}

function mkinit()
{
	echo "Making init..."

	# Make init for kernel linux
	arch-chroot /mnt mkinitcpio -p linux &> /dev/null
}

function pass()
{
	# Set root Password
	arch-chroot /mnt passwd
}

function create_user()
{
	echo "Enter your username"
	read $USERNAME

	# Adding the user to the group wheel
	arch-chroot /mnt useradd -m -G wheel -s /bin/bash $USERNAME
}

function user_script()
{
	echo "Copying user script..."

	# Copying user.sh to new home
	cp user.sh /mnt/home/$USERNAME/script.sh
}

function unmount()
{
	echo "Unmounting..."

	# Unmounting the partitions before shutdown
	umount -R /mnt &> /dev/null
}

# Using fonctions in the right order

#boot_verif

#time_sync

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

reboot
