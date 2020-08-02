#!/bin/bash

#make the directories
sudo mkdir -p /etc/users
sudo mkdir -p /etc/.encrypted

#install encfs
sleep 5
sudo apt-get install encfs -y

#mount and setup the encrypted directory
encfs /etc/.encrypted /etc/users
