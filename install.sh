#!/bin/bash


echo "Dpkg::Progress-Fancy \"1\";" | sudo tee /etc/apt/apt.conf.d/99progressbar

#
# setup ppas
sudo add-apt-repository ppa:saiarcot895/myppa
sudo add-apt-repository ppa:git-core/ppa

#
# update repo and install prereqs
sudo apt-get update -qq
sudo apt-get install -y di git axel ssh apt-fast

#
# update system 
sudo apt-fast dist-upgrade -y


# install hypervisor
sudo apt-fast install -y qemu-kvm libvirt-bin sudo python python-requests virtinst socat libxml-xpath-perl virt-manager vde2 

#spice-client

# install dashboard
sudo apt-fast install -y mariadb-server apache2 php git libapache2-mod-php php-mbstring php-gettext php-ssh2 php-imagick php-mysql php-mail php-mcrypt



#NOTES
#
# Add ServerName to /etc/apache2/apache2.conf
##echo "ServerName <IP>" |sudo tee -a /etc/apache2/apache2.conf
##sudo systemctl restart apache2
##sudo apache2ctl configtest 

# update /etc/apache2/mods-enabled/dir.conf
# lookup index.php firste

# install info.php


# UFW setup

#mysql seure install

#create database
sudo mysql -u root -pabcd1234 -e "create database vdi"
sudo mysql -u root -pabcd1234 -e "create user vdi@localhost identified by 'vdi'"
sudo mysql -u root -pabcd1234 -e "grant all privileges on vdi.* to vdi@localhost";



cd /var/www/html/
sudo git clone https://github.com/Seitanas/kvm-vdi

##   19  ls
##   20  sudo cp functions/config.php_dist functions/config.php
##   21  sudo vi functions/config.php
##   22  ls
##   23  cd functions/
##   24  ls -la
##   25  vi config.php
##   26  sudo vi config.php
##   27  sudo apt-get install qemu-kvm libvirt-bin sudo python python-requests virtinst socat libxml-xpath-perl
##   28  service apparmor stop
##   29  sudo systemctl disable apparmor.service 
##   30  useradd -s /bin/bash -m VDI
##   31  sudo useradd -s /bin/bash -m VDI

##   42  mkdir kvm-vdi
##   43  ls
##   44  mv kvm-vdi mykvm-vdi/
##   45  cd mykvm-vdi/
##   46  ls
##   47  vi install.sh
##   48  history
##   49  history> install.sh 
