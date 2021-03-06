#!/bin/bash

SERVERIP=192.168.2.50

echo "Dpkg::Progress-Fancy \"1\";" | sudo tee /etc/apt/apt.conf.d/99progressbar

#
# setup ppas
sudo add-apt-repository -y ppa:saiarcot895/myppa
sudo add-apt-repository -y ppa:git-core/ppa

#
# update repo and install prereqs
sudo apt-get update -qq
sudo apt-get install -y di git axel ssh apt-fast vlock tmux

#####################################
# need silent install of apt-fast
#####################################

#
# update system 
sudo apt-fast dist-upgrade -y


# install hypervisor
sudo apt-fast install -y qemu-kvm libvirt-bin sudo python python-requests virtinst socat libxml-xpath-perl virt-manager vde2 

#spice-client

# install dashboard
sudo apt-fast install -y mariadb-server apache2 php git libapache2-mod-php php-mbstring php-gettext php-ssh2 php-imagick php-mysql php-mail php-mcrypt python-numpy


#
# secure system
echo "Securing Logon Screen"
sudo tee -a /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf > /dev/null <<EOF
allow-guest=false
greeter-show-manual-login=true
greeter-hide-users=true    
EOF



#NOTES
#
# Add ServerName to /etc/apache2/apache2.conf
echo "ServerName $SERVERIP" |sudo tee -a /etc/apache2/apache2.conf
sudo systemctl restart apache2
sudo apache2ctl configtest 

# update /etc/apache2/mods-enabled/dir.conf
# lookup index.php firste
sudo sed -i -e 's/index.php //' -e 's/index.html/index.php &/' /etc/apache2/mods-enabled/dir.conf

# install info.php


# UFW setup

#mysql seure install

#create database
sudo mysql -u root -pabcd1234 -e "create database vdi"
sudo mysql -u root -pabcd1234 -e "create user 'vdi'@'localhost' identified by 'vdi'"
sudo mysql -u root -pabcd1234 -e "grant all privileges on vdi.* to 'vdi'@'localhost'"


# disable apparmor
sudo systemctl stop apparmor.service 
sudo systemctl disable apparmor.service



cd /var/www/html/
sudo git clone https://github.com/Seitanas/kvm-vdi

KVMDIR=/var/www/html/kvm-vdi

sudo cp /var/www/html/kvm-vdi/functions/config.php_dist \
        /var/www/html/kvm-vdi/functions/config.php

sudo sed -i "s/192.168.0.20/$SERVERIP/g" /var/www/html/kvm-vdi/functions/config.php

if [ ! -d "/var/hyper_keys" ]; then
   echo "Creating key dir"
   sudo mkdir -pv /var/hyper_keys
fi

if [ ! -d "/data" ]; then
   echo "Creating data dir"
   sudo mkdir -pv /data
fi


#
# Create VDI User
vdipass='$6$VULZjok1$8V7YYoddIJ23UCSQYI1Xua63ES1Qs6gJuWjt2HWAZCBmjJPqndQVgWBZfJ1HRosKfYpQE1ZUNqXffaaonj/6g/'
VDI_SSH_HOME=/home/VDI/.ssh
sudo useradd -s /bin/bash -m VDI -p $vdipass
echo > /tmp/do.txt
echo >> /tmp/do.txt
echo >> /tmp/do.txt

sudo su VDI -c "ssh-keygen -t rsa" < /tmp/do.txt 
sudo sh -c "cp ${VDI_SSH_HOME}/* /var/hyper_keys/"
sudo chmod 644 /var/hyper_keys/id_rsa
sudo -u VDI cp ${VDI_SSH_HOME}/id_rsa.pub ${VDI_SSH_HOME}/authorized_keys


# setup VDI users for sudo
line=$(grep VDI ${KVMDIR}/hypervisors/sudoers)
sudo sed  -i "/^root/ a  $line" /etc/sudoers

# setup vdi agent
VDI_AGENT_DIR=/usr/local/VDI

if [ ! -d ${VDI_AGENT_DIR} ]; then
    sudo mkdir -pv ${VDI_AGENT_DIR}
fi

sudo -s cp -v /var/www/html/kvm-vdi/hypervisors/* ${VDI_AGENT_DIR}
sudo sed -i "s/192.168.0.20/$SERVERIP/g" ${VDI_AGENT_DIR}/config
sudo -s cp -v /var/www/html/kvm-vdi/hypervisors/vdi-agent.service /etc/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable vdi-agent
sudo systemctl start vdi-agent
sudo systemctl status vdi-agent


#
# Install websockify
sudo  git clone https://github.com/kanaka/websockify /opt/websockify
cd /opt/websockify
./run --token-plugin TokenFile --token-source /tmp/kvm-vdi 5959 --daemon

#
# Not automated yet
# - https://www.cyberciti.biz/faq/how-to-create-bridge-interface-ubuntu-linux/
#
echo "Setting up bridge IFC"
sudo tee -a /etc/network/interfaces > /dev/null <<EOF

auto br0
iface br0 inet static
  address 192.168.2.50
  netmask 255.255.255.0
  broadcast 192.168.2.255
  bridge_ports enp0s25
  bridge_stp off
  bridge_fd 0
  bridge_maxwait 0
EOF

sudo reboot
