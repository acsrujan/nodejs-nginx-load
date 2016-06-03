#!/bin/bash
/bin/bash nginx_install.sh
/bin/bash nodejs_install.sh
sudo touch /etc/nginx/upstream.conf
cd $HOME
wget https://github.com/chetandhembre/hello-world-node/archive/master.zip
unzip *-master.zip -d hello-world-node
rm -rf *-master.zip
$HOME/local/node/bin/forever start $HOME/hello-world-node/main.js
PORT=8081 $HOME/local/node/bin/forever start $HOME/hello-world-node/main.js
sudo cp $HOME/nodejs-nginx-load/reqpmin.conf /etc/init/reqpmin.conf
sudo service reqpmin start
