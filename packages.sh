#!/bin/bash

function update()
{
	echo "Updating packages..."

	# Update all the packages that need to be updated
	arch-chroot /mnt pacman -Ssy &> /dev/null
}

function install_git()
{
	echo "Installing git..."
	echo ""

	# Install git and ssh
	arch-chroot /mnt pacman -S git ssh &> /dev/null

	# Ask user for its ID
	echo "Enter your github user name :"
	read GIT_USERNAME
	echo "Enter your github email"
	read GIT_EMAIL
	# echo "Enter your git password"
	# read GIT_PASS

	# Configure git
	arch-chroot /mnt git config --global user.name ""$GIT_USERNAME"" &> /dev/null
	arch-chroot /mnt git config --global user.email ""$GIT_EMAIL"" &> /dev/null

	# Configure ssh
	arch-chroot /mnt su - $USERNAME -c "ssh-keygen" &> /dev/null
}

function install_i3()
{
	# Install the goup i3 and the dependencies of my config
	arch-chroot /mnt pacman -S i3 j4-dmenu-desktop &> /dev/null
}

function install_sway()
{
	# Install sway and the dependecies of my config
	arch-chroot /mnt pacman -S sway &> /dev/null
}

function install_connman()
{
	# Install connman
	arch-chroot /mnt pacman -S connman &> /dev/null

	# Create config file
	arch-chroot /mnt mkdir /etc/connman &> /dev/null
	arch-chroot /mnt echo "[General]" >> /etc/connman/main.conf &> /dev/null

	# Add config to prefer ethernet over wifi
	arch-chroot /mnt echo "PreferrefTechnologies=ethernet,wifi" >> /etc/connman/main.conf &> /dev/null

	# Add config to blacklist vitual interfaces
	arch-chroot /mnt echo "NetworkInterfaceBlacklist=vmnet,vboxnet,virbr,ifb,docker,veth,eth,wlan" >> /etc/connman/main.conf &> /dev/null
}

function install_ucode()
{
	arch-chroot /mnt pacman -S intel-ucode &> /dev/null
}

function install_grub()
{
	arch-chroot /mnt pacman -S grub grub-customizer os-prober &> /dev/null
	#arch-chroot /mnt grub-install --target=x86_64-efi --efidirectory= --bootloader-id=grub &> /dev/null
	#arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg &> /dev/null
}

function install_lmt()
{
	arch-chroot /mnt pacman -S laptop-mode-tool &> /dev/null
}

function install_mpd()
{
	arch-chroot /mnt pacman -S mpd ncmpcpp mpc &> /dev/null
}

function install_nvim()
{
	arch-chroot /mnt pacman -S neovim &> /dev/null
}

function install_networkmanager()
{
	arch-chroot /mnt pacman -S networkmanager &> /dev/null
}

function install_zsh()
{
	arch-chroot /mnt pacman -S zsh &> /dev/null
}

function install_yaourt()
{
	arch-chroot /mnt cd /tmp && git clone https://aur.archlinux.org/package-query.git &> /dev/null
	arch-chroot /mnt cd /tmp/package-query &&  makepkg -si &> /dev/null
	arch-chroot /mnt cd /tmp && git clone https://aur.archlinux.org/yaourt.git &> /dev/null
	arch-chroot /mnt cd /tmp/yaourt && makepkg -si &> /dev/null
	arch-chroot /mnt cd /tmp && rm -R yaourt && rm -R package-query &> /dev/null
}

function install_ranger()
{
	arch-chroot /mnt pacman -S ranger &> /dev/null
}

function install_deluge()
{
	arch-chroot /mnt pacman -S deluge &> /dev/null
}

function install_virtualbox()
{
	arch-chroot /mnt pacman -S virtualbox virtualbox-host-modules-arch &> /dev/null
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
	arch-chroot /mnt cd /home/$USERNAME && git clone git@github.com:xorob0/dotfiles.git
}

update
install_grub
