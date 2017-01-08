#!/bin/bash

function update()
{
	# Update all the packages that need to be updated
	arch-chroot /mnt pacman -Ssy
}

function install_git()
{
	# Install git and ssh
	arch-chroot /mnt pacman -S git ssh

	# Ask user for its ID
	echo "Enter your github user name :"
	read GIT_USERNAME
	echo "Enter your github email"
	read GIT_EMAIL
	echo "Enter your git password"
	read GIT_PASS

	# Configure git
	arch-chroot /mnt git config --global user.name ""$GIT_USERNAME""
	arch-chroot /mnt git config --global user.email ""$GIT_EMAIL""

	# Configure ssh
	arch-chroot /mnt su - $USER -c "ssh-keygen"
}

function install_i3()
{
	# Install the goup i3 and the dependencies of my config
	arch-chroot /mnt pacman -S i3 j4-dmenu-desktop
}

function install_sway()
{
	arch-chroot /mnt pacman -S sway
	arch-chroot /mnt wget -O /etc/sway/config
}

function install_connman()
{
	arch-chroot /mnt pacman -S connman
	arch-chroot /mnt
}

function install_ucode()
{
	arch-chroot /mnt pacman -S intel-ucode
}

function install_grub()
{
	arch-chroot /mnt pacman -S grub grub-customizer os-prober
	arch-chroot /mnt grub-install --target=x86_64-efi --efidirectory= --bootloader-id=grub
	arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
}

function install_lmt()
{
	arch-chroot /mnt pacman -S laptop-mode-tool
}

function install_mpd()
{
	arch-chroot /mnt pacman -S mpd ncmpcpp mpc
}

function install_nvim()
{
	arch-chroot /mnt pacman -S neovim
}

function install_networkmanager()
{
	arch-chroot /mnt pacman -S networkmanager
}

function install_zsh()
{
	arch-chroot /mnt pacman -S zsh
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
	arch-chroot /mnt pacman -S ranger
}

function install_deluge()
{
	arch-chroot /mnt pacman -S deluge
}

function install_virtualbox()
{
	arch-chroot /mnt pacman -S virtualbox
}

function install_zathura()
{
	arch-chroot /mnt pacman -S ranger
}

function install_firefox()
{
	arch-chroot /mnt pacman -S firefox
}

function install_chromium()
{
	arch-chroot /mnt pacman -S ranger
}

function install_transmission()
{
	arch-chroot /mnt pacman -S transmission
}

function install_mpv()
{
	arch-chroot /mnt pacman -S mpv
}

function install_ranger()
{
	arch-chroot /mnt pacman -S ranger
}

function install_ranger()
{
	arch-chroot /mnt pacman -S ranger
}

function install_bonus()
{
	arch-chroot /mnt pacman -S android-sdk-platform-tools gucview htop ntfs-3g openssh gparted pinta udiskie usisks2
}

function git_dotfiles()
{
}
