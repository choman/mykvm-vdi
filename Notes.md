Setup gist:

   - sudo apt-get install ruby
   - sudo gem install gist


Setup VBox
   - echo "deb http://download.virtualbox.org/virtualbox/debian yakkety contrib" | sudo tee -a /etc/apt/sources.list.d/vbox.list
   - wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
   - sudo apt-get update; sudo apt-get install -y virtualbox-5.1

