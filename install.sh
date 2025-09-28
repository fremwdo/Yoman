#!/bin/sh

# Lấy user đầu tiên khác root trong /etc/passwd
NORMAL_USER=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1; exit}' /etc/passwd)

# Cài gói
apk add sway wayland xorg-server-xwayland \
    alacritty foot wl-clipboard \
    seatd elogind dbus polkit \
    mesa-dri-gallium git zsh --no-cache

# seatd service
adduser "$NORMAL_USER" seat
rc-update add seatd
rc-service seatd start

# Clone dotfiles
sudo -u "$NORMAL_USER" git clone https://github.com/zanderp/alpine-swaywm-dotfiles.git /home/$NORMAL_USER/dotfiles
cp -r /home/$NORMAL_USER/dotfiles/.config/* /home/$NORMAL_USER/.config/

echo "Xong! Reboot, login bằng $NORMAL_USER rồi gõ sway."
