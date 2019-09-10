#!/bin/sh -x

webroot=/home/www
confdir=$webroot/aria2.conf.d
h5aidir=$webroot/_h5ai
nginxconf=/etc/nginx/sites-enabled/default
smbconf=/etc/samb/smb.conf
serviceconf=/lib/systemd/system/aria2.service


echo "install dependence package"
sudo -E apt install nginx aria2 php7.2-fpm samba samba-common

echo "Stop already started service"
sudo systemctl stop aria2
sudo systemctl disable aria2
sudo systemctl stop nginx
sudo systemctl disable nginx
sudo systemctl stop smbd
sudo systemctl disable smbd
sudo umount $webroot/data
sudo umount $webroot/data

echo "Setup Environment"
sudo rm -rf $webroot
sudo mkdir -p  $confdir
sudo mkdir -p  $webroot/data

sudo rsync -az _h5ai $webroot 
sudo rsync -az aria2 $h5aidir
sudo rsync -az aria2.* $confdir
sudo rsync -az smb.conf $smbconf

sudo rm -rf $serviceconf
sudo ln -sf $confdir/aria2.service $serviceconf

sudo ln -sf $confdir/aria2.nginx.h5ai.conf $nginxconf

echo "Start services"
sudo mount -t exfat /dev/sda1 $webroot/data

sudo systemctl restart aria2
sudo systemctl restart nginx
sudo systemctl restart smbd

sudo systemctl enable aria2
sudo systemctl enable nginx
sudo systemctl enable smbd



