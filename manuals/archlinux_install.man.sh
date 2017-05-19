# different tutorials:

# http://www.cio.com/article/3095453/linux/how-to-install-arch-linux-on-your-pc.html
	# https://blog.m157q.tw/posts/2013/12/30/arch-linux-quick-installation-with-gpt-in-bios/


# change keyboard layout temporarlily
localectl --no-convert set-keymap sg-latin1

# time settings
timedatectl set-ntp true

# if EFI

# disk partioning
# replace /dev/sda with real value (lookup with lsblk)
gdisk /dev/sda
# wipe partition table with: z
# create new GPT with: o
# add following partitions with: n
#	Boot: Partition Number 1 (Enter), First Sector (Enter), Last Sector +500M, Hex Code EF00
#	Swap: Partition Number 2 (Enter), First Sector (Enter), Last Sector +16G, Hex Code 8200
#	Main: Partition Number 3 (Enter), First Sector (Enter), Last Sector (Enter), Hex Code 8300
# write to disk: w

# if NON-EFI

parted /dev/sda
mklabel msdos
quit

fdisk /dev/sda
# create new GPT with: o
# add following partitions with: n
#	Boot: Partition Number 1 (Enter), First Sector (Enter), Last Sector +500M
#	Swap: Partition Number 2 (Enter), First Sector (Enter), Last Sector +16G
#	Main: Partition Number 3 (Enter), First Sector (Enter), Last Sector (Enter)
# write to disk: w

# end if

# format
mkfs.ext4 /dev/sda3
mkfs.fat -F32 /dev/sda1

# enable Swap
mkswap /dev/sda2
swapon /dev/sda2

# mount
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

# install base system
pacstrap /mnt base base-devel

# if problems with unknown trust
# pacman -Sy archlinux-keyring
# repeat pacstrap 

# setup fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

# configuration
arch-chroot /mnt
# next commands are within chroot shell

# change locales permanently
echo LANG=de_CH.UTF-8 > /etc/locale.conf
echo KEYMAP=sg-latin1 > /etc/vconsole.conf
ln -s /usr/share/zoneinfo/Europe/Zurich /etc/localtime
# if already exists, rm /etc/localtime

# change hostname
echo archie > /etc/hostname

# enable dhcp for having a network connection on startup
systemctl enable dhcpcd.service

# set root password
passwd

# if NON-EFI bios
pacman -S mtools syslinux
syslinux-install_update -i -a -m

# if EFI

parted /dev/sdb set 1 bios_grub on
grub-install /dev/sda
# install bootloader
bootctl install --path=/boot
# on error message: no efi partition, make sure 
#	you've wiped the partition table
#	created / it is a GPT
#	there's an EFI Partition (Hex Code EF00)
#	it is formatted ad FAT32

# generate bootloader files
echo "title		Arch Linux
linux		/vmlinuz-Linux
initrd		/initramfs-linux.img
options		/root=/dev/sda3 rw resume=/dev/sda2
" > /boot/loader/entries/arch.conf

echo "title		Arch Linux Fallback
linux		/vmlinuz-Linux
initrd		/initramfs-linux-fallback.img
options		/root=/dev/sda3 rw resume=/dev/sda2
" > /boot/loader/entries/arch-fallback.conf

echo "default	arch
timeout	1
" > /boot/loader/loader.conf

# end if

# reboot and start installing userapps
exit
reboot

# login with username root

# add user
useradd -m -s /bin/bash gabriel
passwd gabriel

pacman -S sudo
visudo
# add <username> ALL=(ALL) ALL

# install user apps

# install yaourt
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..

pacman -S openssh
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

pacman -S apache
sudo systemctl enable httpd
sudo systemctl start httpd

pacman -S curl wget

# Shell
pacman -S zsh
chsh -s /bin/zsh

pacman -S vim

pacman -S git svn

mkdir tmp

# CLI apps
pacman -S sudo ack

# X11
pacman -S xorg-server xorg-xinit xorg-utils xorg-server-utils
pacman -S xorg-twm xterm xorg-xclock

# XFCE
pacman -S xfce4 xfce4-goodies xfce4-mixer
pacman -S lightdm
pacman -S lightdm-kde-greeter

# Pulse
pacman -S pulseaudio pavucontrol pulseaudio-alsa

# GUI apps
pacman -S firefox engrampa gnome-mplayer evince gnome-keyring

# optionals
yaourt shellinabox-git
