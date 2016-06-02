#!/bin/bash
/bin/bash nginx_install.sh
/bin/bash nodejs_install.sh
sudo touch /etc/nginx/upstream.conf
mkdir -p /var/www/
sudo chmod 755 /var/www/
sudo chmod 644 /var/www/*
cd ~/
git clone git@github.com:chetandhembre/hello-world-node.git
sudo mv ~/hello-world-node /var/www/
cd /var/www/hello-world-node/
$HOME/local/node/bin/forever start main.js
PORT=8081 $HOME/local/node/bin/forever start main.js
sudo chmod +x $HOME/nodejs-nginx-load/check_rpm.sh
sudo cp $HOME/nodejs-nginx-load/check_rpm.sh /etc/check_rpm
sudo cp $HOME/nodejs-nginx-load/reqpmin.conf /etc/init/reqpmin.conf
sudo service reqpmin start
