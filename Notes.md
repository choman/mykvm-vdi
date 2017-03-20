Setup gist:

   - sudo apt-get install ruby
   - sudo gem install gist


Setup VBox
   - echo "deb http://download.virtualbox.org/virtualbox/debian yakkety contrib" | sudo tee -a /etc/apt/sources.list.d/vbox.list
   - wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
   - sudo apt-get update; sudo apt-get install -y virtualbox-5.1
   - aria2c -x 8 http://download.virtualbox.org/virtualbox/5.1.16/Oracle_VM_VirtualBox_Extension_Pack-5.1.16-113841.vbox-extpack

