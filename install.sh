#!/bin/bash


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


sudo apt-fast install qemu-kvm libvirt-bin sudo python python-requests virtinst socat libxml-xpath-perl virt-manager vde2 spice-client
sudo apt-fast install mariadb-server apache2 php git libapache2-mod-php php-mbstring php-gettext php-ssh2 php-imagick php-mysql php-mail

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
##   32  ls
##   33  cd ..
##   34  ls -al
##   35  cd
##   36  ls
##   37  history
##   38  sudo apt-get install virt-manager 
##   39  git
##   40  l;s
##   41  ls
##   42  mkdir kvm-vdi
##   43  ls
##   44  mv kvm-vdi mykvm-vdi/
##   45  cd mykvm-vdi/
##   46  ls
##   47  vi install.sh
##   48  history
##   49  history> install.sh 
