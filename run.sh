#!/bin/bash
/bin/bash nginx_install.sh
/bin/bash nodejs_install.sh
sudo touch /etc/nginx/upstream.conf
cd $HOME
git clone git@github.com:chetandhembre/hello-world-node.git
$HOME/local/node/bin/forever start $HOME/hello-world-node/main.js
PORT=8081 $HOME/local/node/bin/forever start $HOME/hello-world-node/main.js
sudo cp $HOME/nodejs-nginx-load/reqpmin.conf /etc/init/reqpmin.conf
sudo service reqpmin start
