#!/bin/bash
#install software and packages

apt install -y libxft-dev \
libxinerama-dev \
libx11-dev \
xorg \
xserver-xorg \
git \
curl \
wget \
build-essential \
feh \
conky \
lm-sensors \
cmus \
newsboat \
xcompmgr \
alsa-utils \
acpi \
sxiv \
scrot \
rlwrap \
keepassxc \
zathura \
pmount \
jmtpfs \
calcurse \
rsync \
rclone \
mc \
xclip \
fbreader \
shellcheck \
timeshift \
python3-libtmux \
ncal \
mpv \
transmission-cli \
transmission-daemon \
pass \
stow \
tldr \
moreutils

# tmux \
# fzf \
# most \

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

#download and build suckless tools

# git clone https://github.com/xwav/suckless $USER_HOME/.config/suckless && \
# cd $USER_HOME/.config/suckless/dwm && make && make clean install 
# cd $USER_HOME/.config/suckless/dmenu && make && make clean install
# cd $USER_HOME/.config/suckless/st && make && make clean install

#download and build nvim

# git clone https://github.com/neovim/neovim $USER_HOME/.config/neovim
# cd $USER_HOME/.config/neovim && git checkout stable && make && make install
# #cd ~/.config && rm -r neovim

#install Brave browser
apt install -y apt-transport-https \
curl
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
apt update -y && apt install -y brave-browser

#install GoogleDrive ocamlfuse
apt install -y software-properties-common \
dirmngr \
gnupg-agent

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AD5F235DF639B041
echo 'deb http://ppa.launchpad.net/alessandro-strada/ppa/ubuntu xenial main' | tee /etc/apt/sources.list.d/alessandro-strada-ubuntu-ppa.list >/dev/null

apt update && apt install -y google-drive-ocamlfuse

#download and install cht.sh
curl https://cht.sh/:cht.sh | tee /usr/local/bin/cht.sh
chmod +x /usr/local/bin/cht.sh


