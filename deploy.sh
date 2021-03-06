#!/bin/bash
cd $HOME
source $HOME/.bashrc
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
rm -rf hello-world-node
SSH_AUTH_SOCK=$SSH_AUTH_SOCK git clone git@github.com:chetandhembre/hello-world-node.git

$HOME/local/node/bin/forever start $HOME/hello-world-node/main.js
PORT=8081 $HOME/local/node/bin/forever start $HOME/hello-world-node/main.js
sudo service nginx restart
sudo service reqpmin start
