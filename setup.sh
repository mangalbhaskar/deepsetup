#!/bin/bash

##----------------------------------------------------------
### New system build semi-automation script
## Tested on Ubuntu 16.04 LTS, Ubuntu 18.04 LTS
## Inspired bt linuxscripts
##----------------------------------------------------------
## TBD:
# 1. taking user inputs from keyboard or from config file
##----------------------------------------------------------

## Set the git 
# git config --global user.email "you@example.com"
# git config --global user.name "Your Name"

LSCRIPTS=$(pwd)
export PATH=$PATH:$LSCRIPTS
#echo "PATH: $PATH"
#echo "Inside dir: $LSCRIPTS"

##----------------------------------------------------------
## Nvidia GPU Drivers, CUDA, cuDNN, TensorRT
##----------------------------------------------------------
cd $LSCRIPTS

##----------------------------------------------------------
## Nvidia GPU Drivers
##----------------------------------------------------------

## Ubuntu 16.04 LTS
## Install in Virtual Console
if [[ $LINUX_VERSION == "16.04" ]]; then
  echo "...$LINUX_VERSION"
  source $LSCRIPTS/nvidia-ubuntu-1604.install.sh
fi

# Ubuntu 18.04 LTS
if [[ $LINUX_VERSION == "18.04" ]]; then
  echo $LINUX_VERSION
  source $LSCRIPTS/nvidia-ubuntu-1804.install.sh
fi

# # ##----------------------------------------------------------
# # ## CUDA, Optional(cuDNN, TensorRT)
# # ##----------------------------------------------------------
source $LSCRIPTS/cuda.install.sh
# source $LSCRIPTS/cudnn.install.sh
# source $LSCRIPTS/tensorRT.install.sh

##----------------------------------------------------------
## Install utilities and softwares
##----------------------------------------------------------
## Essential for New Machine Setup
sudo -E apt -q -y install git
sudo -E apt -q -y install gparted
sudo -E apt -q -y install net-tools
sudo -E apt -q -y install ppa-purge

##----------------------------------------------------------
### vim
##----------------------------------------------------------
#sudo -E apt -q -y remove vim vim-gtk && sudo apt-get -y autoremove
sudo -E apt -q -y install vim vim-gtk
#TBD: this may receates the file, hence risks loosing existing configurations
sudo sh -c 'echo "set expandtab\nset tabstop=2\nset nu\n" > /etc/vim/vimrc.local'

# :set tabstop=4
# :set shiftwidth=4
# :set expandtab

##----------------------------------------------------------
### sublime-text editor
##----------------------------------------------------------
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo -E apt -q -y install apt-transport-https
## Stable
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
## Dev
#echo "deb https://download.sublimetext.com/ apt/dev/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo -E apt -q -y install sublime-text

##----------------------------------------------------------
### Utilities
## utils.install.sh
##----------------------------------------------------------
sudo -E apt -q -y install openssh-client openssh-server
sudo -E apt -q -y install dos2unix
sudo -E apt -q -y install tree
sudo -E apt -q -y install chromium-browser
sudo -E apt -q -y install unrar
sudo -E apt -q -y install aptitude
### exif tool
sudo -E apt -q -y install libimage-exiftool-perl
## Used in openCV
sudo -E apt -q -y install doxygen doxygen-gui
sudo -E apt -q -y install graphviz
## Misc
sudo -E apt -q -y install libexif-dev
sudo -E apt -q -y install ntp
sudo -E apt -q -y install libconfig++-dev
sudo -E apt -q -y install kino
## for software builds
sudo -E apt -q -y install cmake-curses-gui
##Admin
#system utils: htop
sudo -E apt -q -y install htop
sudo -E apt -q -y install apcalc

# For gnome Ubuntu >= 17
sudo -E apt -q -y install gnome-tweak-tool

## sudo apt install gnome-shell-extension-weather
## start gnome-tweaks by
# gnome-tweaks

sudo -E apt -q -y install dconf-editor

# cmd image viewer
sudo -E apt -q -y install feh


# openvpn
sudo -E apt -q -y install openvpn

# * Enabe "New Document" Option
# https://linuxconfig.org/how-to-create-desktop-shortcut-launcher-on-ubuntu-18-04-bionic-beaver-linux
touch $HOME/Templates/Empty\ Document

## https://stackoverflow.com/questions/7106012/download-a-single-folder-or-directory-from-a-github-repo
sudo -E apt -q -y install subversion
sudo -E apt -q -y install libcanberra-gtk-module


##----------------------------------------------------------
## Diff-tools
## source $LSCRIPTS/diff-tools.install.sh
##----------------------------------------------------------
sudo -E apt -q -y install tkcvs
sudo -E apt -q -y install meld

##----------------------------------------------------------
## Haroopad
##----------------------------------------------------------
if [ -z "$HAROOPAD_VER" ]; then
  HAROOPAD_VER="0.13.1"
  echo "Unable to get HAROOPAD_VER version, falling back to default version#: $HAROOPAD_VER"
fi

sudo -E apt -q -y install libgconf2-4

PROG='haroopad'
FILE="$PROG-v$HAROOPAD_VER-x64.deb"
echo "$FILE"

if [ ! -f $HOME/Downloads/$FILE ]; then
  #wget https://bitbucket.org/rhiokim/haroopad-download/downloads/haroopad-v0.13.1-x64.deb
  wget https://bitbucket.org/rhiokim/haroopad-download/downloads/$FILE -P $HOME/Downloads
else
  echo Not downloading as: $HOME/Downloads/$FILE already exists!
fi
sudo dpkg -i $HOME/Downloads/$FILE

##----------------------------------------------------------
## Installing Adobe Flash Player and Plugin for browser
##----------------------------------------------------------
sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo -E apt update
sudo -E apt -q -y install adobe-flashplugin browser-plugin-freshplayer-pepperflash

##----------------------------------------------------------
### Java 
##----------------------------------------------------------
source $LSCRIPTS/java.install.sh

##----------------------------------------------------------
### Pyhton 
##----------------------------------------------------------
source $LSCRIPTS/python.install.sh

##----------------------------------------------------------
### PHP 
##----------------------------------------------------------
source $LSCRIPTS/php.install.sh

##----------------------------------------------------------
### Apache 
##----------------------------------------------------------
source $LSCRIPTS/apache2.install.sh

##----------------------------------------------------------
### NodeJS 
##----------------------------------------------------------
source $LSCRIPTS/nodejs.install.sh


##----------------------------------------------------------
## Graphics, Multimedia
##----------------------------------------------------------
##----------------------------------------------------------
### VLC
##----------------------------------------------------------
sudo -E apt update
sudo -E apt -q -y install vlc browser-plugin-vlc

##----------------------------------------------------------
## ffmpeg
##----------------------------------------------------------
sudo -E apt update
#sudo -E apt -q -y install ffmpeg frei0r-plugins
sudo -E apt -q -y install ffmpeg

##----------------------------------------------------------
### Python virtualenv virtualenvwrapper setup
##----------------------------------------------------------

source $LSCRIPTS/python.virtualenvwrapper.install.sh 3