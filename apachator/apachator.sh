#!/bin/bash
read -p "Please enter the host name (e.g. sancho.api): " -r host
read -p "Please enter path to your public folder (e.g. /var/www/html/public): " -r path
dir=$(echo "$host" | tr '.' '-')
# DEFINED VARIABLES: $host $path $dir

mkdir ./$dir
sed -e "s|SANCHO|$host|g" -e "s|ROCINANTE|$path|g" ./default/SANCHO.conf > ./$dir/$host.conf
sed "s|SANCHO|$host|g" ./default/SANCHO.txt > ./$dir/$host.txt
echo -e "${RED}Good, now copy this command in cmd (with admin rights):${NK}"
awk '{print} END {print ""}' ./$dir/$host.txt # like cat but with a newline

sudo cp ./$dir/$host.conf /etc/apache2/sites-available/
sudo a2enmod -q rewrite
sudo a2ensite $host.conf
sudo service apache2 reload