#!/bin/bash

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# update the system
apt update && apt -y upgrade

# install basics
apt -y install openssh-server net-tools curl vim zsh sudo git bc lolcat toilet

# Create the user
useradd -m -s /usr/bin/zsh -d /home/"${NEW_USER}" "${NEW_USER}"
chown "${NEW_USER}":"${NEW_USER}" /"${NEW_USER}"
mv /"${NEW_USER}"/* /home/"${NEW_USER}"/
ln /"${NEW_USER}" /home/"${NEW_USER}"/data
echo "${NEW_USER}:${NEW_PASSWORD}" | chpasswd
echo "${NEW_USER} ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo

# Create the motd
echo "" > /etc/motd
mv /10-uname /etc/update-motd.d/

# Before run the docker : export $(grep -v '^#' .env | xargs)
# To run the docker : docker compose up --build --remove-orphans -d