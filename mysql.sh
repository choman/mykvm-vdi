#!/bin/bash

passwd=abcd1234
db=vdi2
user=vdi3
userpass=vdi3


DEBUG=1

echo
echo Creating DB: $db
sudo mysql -u root -p"$passwd" -Bse "create database if not exists $db"

if [[ $DEBUG ]]; then
   echo Existsing dbs
   sudo mysql -u root -p"$passwd" -Bse 'show databases'
fi

echo
echo Creating user: $user
sudo mysql -u root -p"$passwd" -e "create user ${user}@localhost identified by '$userpass'"
sudo mysql -u root -p"$passwd" -e "grant all privileges on $db.* to '${user}'@'localhost'"

echo flushing privileges
sudo mysql -u root -p"$passwd" -e "flush privileges"

##if [[ $DEBUG ]]; then
##   sudo mysql -u root -p"$passwd" -Bse "show users"
##fi
