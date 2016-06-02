#!/bin/bash
/bin/bash nginx_install.sh
/bin/bash nodejs_install.sh
sudo touch /etc/nginx/upstream.conf
mkdir -p /var/www/
sudo chmod 755 /var/www/
sudo chmod 644 /var/www/*
cd /var/www/
git clone git@github.com:chetandhembre/hello-world-node.git
cd /var/www/hello-world-node/
forever start main.js
PORT=8081 forever start main.js
sudo chmod +x /var/www/nodejs-nginx-load/check_rpm.sh
sudo cp /var/www/nodejs-nginx-load/check_rpm.sh /etc/check_rpm
sudo cp /var/www/nodejs-nginx-load/reqpmin.conf /etc/init/reqpmin.conf
sudo service reqpmin start
