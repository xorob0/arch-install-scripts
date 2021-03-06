#!/bin/bash

function update()
{
	echo "Updating packages..."

	# Update all the packages that need to be updated
	arch-chroot /mnt pacman --noconfirm -Ssy
}

function install_git()
{
	echo "Installing git..."
	echo ""

	# Install git and ssh
	arch-chroot /mnt pacman --noconfirm -S git openssh

	# Ask user for its ID
	echo "Enter your github user name :"
	read GIT_USERNAME
	echo "Enter your github email"
	read GIT_EMAIL
	# echo "Enter your git password"
	# read GIT_PASS

	# Configure git
	arch-chroot /mnt git config --global user.name ""$GIT_USERNAME""
	arch-chroot /mnt git config --global user.email ""$GIT_EMAIL""

	# Configure ssh
	arch-chroot /mnt su - $USERNAME -c "ssh-keygen"
}

function install_i3()
{
	# Install the goup i3 and the dependencies of my config
	arch-chroot /mnt pacman --noconfirm -S i3 j4-dmenu-desktop
}

function install_sway()
{
	# Install sway and the dependecies of my config
	arch-chroot /mnt pacman --noconfirm -S sway
}

function install_connman()
{
	# Install connman
	arch-chroot /mnt pacman --noconfirm -S connman

	# Create config file
	arch-chroot /mnt mkdir /etc/connman
	echo "[General]" >> /mnt/etc/connman/main.conf

	# Add config to prefer ethernet over wifi
	echo "PreferrefTechnologies=ethernet,wifi" >> /mnt/etc/connman/main.conf

	# Add config to blacklist vitual interfaces
	echo "NetworkInterfaceBlacklist=vmnet,vboxnet,virbr,ifb,docker,veth,eth,wlan" >> /mnt/etc/connman/main.conf
}

function install_ucode()
{
	arch-chroot /mnt pacman --noconfirm -S intel-ucode
}

function install_grub()
{
	echo "Installing GRUB..."

	# Installing GRUB anf os-prober
	arch-chroot /mnt pacman --noconfirm -S grub os-prober

	# If on an EFI system, install grub for EFI
	if [ -d "/sys/firmware/efi/efivars/" ]
	then
		# Installing GRUB EFI to disk
		arch-chroot /mnt grub-install --target=x86_64-efi --efidirectory= --bootloader-id=grub /dev/sda
	else
		# Installing GRUB BIOS to disk
		arch-chroot /mnt grub-install --target=i386-pc /dev/sda
	fi

	# Generating GRUB config file
	arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
}

function install_lmt()
{
	arch-chroot /mnt pacman --noconfirm -S laptop-mode-tool
}

function install_mpd()
{
	arch-chroot /mnt pacman --noconfirm -S mpd ncmpcpp mpc
}

function install_nvim()
{
	arch-chroot /mnt pacman --noconfirm -S neovim
}

function install_networkmanager()
{
	arch-chroot /mnt pacman --noconfirm -S networkmanager
}

function install_zsh()
{
	arch-chroot /mnt pacman --noconfirm -S zsh
}

function install_yaourt()
{
	arch-chroot /mnt cd /tmp && git clone https://aur.archlinux.org/package-query.git
	arch-chroot /mnt cd /tmp/package-query &&  makepkg -si
	arch-chroot /mnt cd /tmp && git clone https://aur.archlinux.org/yaourt.git
	arch-chroot /mnt cd /tmp/yaourt && makepkg -si
	arch-chroot /mnt cd /tmp && rm -R yaourt && rm -R package-query
}

function install_ranger()
{
	arch-chroot /mnt pacman --noconfirm -S ranger
}

function install_deluge()
{
	arch-chroot /mnt pacman --noconfirm -S deluge
}

function install_virtualbox()
{
	arch-chroot /mnt pacman --noconfirm -S virtualbox virtualbox-host-modules-arch
}

function install_zathura()
{
	arch-chroot /mnt pacman --noconfirm -S ranger
}

function install_firefox()
{
	arch-chroot /mnt pacman --noconfirm -S firefox
}

function install_chromium()
{
	arch-chroot /mnt pacman --noconfirm -S ranger
}

function install_transmission()
{
	arch-chroot /mnt pacman --noconfirm -S transmission
}

function install_mpv()
{
	arch-chroot /mnt pacman --noconfirm -S mpv
}

function install_ranger()
{
	arch-chroot /mnt pacman --noconfirm -S ranger
}

function install_ranger()
{
	arch-chroot /mnt pacman --noconfirm -S ranger
}

function install_bonus()
{
	arch-chroot /mnt pacman --noconfirm -S android-sdk-platform-tools gucview htop ntfs-3g openssh gparted pinta udiskie usisks2
}

function git_dotfiles()
{
	arch-chroot /mnt cd /home/$USERNAME && git clone git@github.com:xorob0/dotfiles.git
}

update
install_git
install yaourt
install_i3
install_grub
