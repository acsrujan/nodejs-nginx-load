#!/bin/bash
/bin/bash nginx_install.sh
/bin/bash nodejs_install.sh
sudo touch /etc/nginx/upstream.conf
mkdir -p /var/www/
cd /var/www/
git clone git@github.com:chetandhembre/hello-world-node.git
cd /var/www/hello-world-node/
forever start main.js
PORT=8081 forever start main.js
chmod +x check_rpm.sh
cp check_rpm.sh /etc/check_rpm
sudo service reqpmin start
