#!/bin/sh

workdir=/home/www/aria2
sudo mkdir -p  $workdir
sudo cp -rvf aria2.* $workdir
sudo cp aria2.service /lib/systemd/system
sudo systemctl start aria2
sudo systemctl enable aria2
