#!/bin/bash

# locale and time
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf

# hostname and hosts
echo "satan" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 satan.localdomain satan" >> /etc/hosts


pacman -S grub grub-btrfs networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers xdg-user-dirs xdg-utils bluez bluez-utils cups alsa-utils pulseaudio rsync reflector acpi acpi_call acpid tlp os-prober ntfs-3g terminus-font

pacman -S nvidia nvidia-utils nvidia-settings

# grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# services
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable acpid

# change root password
passwd

# create user
useradd -m syg
passwd syg
echo "syg ALL=(ALL) ALL" >> /etc/sudoers.d/syg



printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
