#!/bin/bash
# This script installs node in ' $HOME/local/node ' directory without sudo

# Store script's filename in $SELF_NAME
SELF_NAME=$(basename $0)

# Prints warning/error $MESSAGE in red foreground color (for [E]rror messages)
red_echo() {
    echo -e "\e[1;31m[E] $SELF_NAME: $MESSAGE\e[0m"
}

# Prints success $MESSAGE in green foreground color (for [S]uccess messages)
green_echo() {
    echo -e "\e[1;32m[S] $SELF_NAME: $MESSAGE\e[0m"
}

# Prints $MESSAGE in blue foreground color (for [I]nfo messages)
blue_echo() {
    echo -e "\e[1;34m[I] $SELF_NAME: $MESSAGE\e[0m"
}

# Function to ensure success of previous command.
# This causes the script to exit if previous command exited with non-zero status
function ensure_success {
    return_status="$1"
    error_message="$2"
    success_message="$3"
    if [ "$return_status" -ne 0  ];then
        MESSAGE=$error_message ; red_echo
        exit
    else
        MESSAGE=$success_message ; green_echo
    fi
}

# Creating local directories
MESSAGE="Creating directory $HOME/local/node\n"; blue_echo
mkdir -p $HOME/local/node
MESSAGE="Directory created\n";blue_echo

# creating an cd-ing to Downolads directory
MESSAGE="Creating a Node directory and entering  in to it \n"; blue_echo
mkdir -p $HOME/Node/
cd $HOME/Node
MESSAGE="Now in Node directory\n";blue_echo

#Downloading the linux tar.gz node package from http://nodejs.org/download/
MESSAGE="Downloading the node package for linux\n"; blue_echo
wget https://nodejs.org/dist/v5.0.0/node-v5.0.0-linux-x64.tar.gz
ensure_success "$?" "Downloading error " " Successfully downloaded "

NODE_PACKAGE=`ls *.tar.gz`

# Extracting the node package
MESSAGE="Extracting the node package \n";blue_echo
tar xzf $NODE_PACKAGE -C $HOME/local/node --strip-components=1

MESSAGE="nodejs Enviroment Setup\n"; blue_echo
echo '#nodejs Enviroment Setup' >> $HOME/.bashrc

MESSAGE="exporting PATH ==> PATH=$HOME/local/node/bin:$PATH\n";blue_echo
echo 'export PATH=$HOME/local/node/bin:$PATH' >> $HOME/.bashrc

MESSAGE="exporting NODE_PATH ==> NODE_PATH=$HOME/local/node/lib/node_modules\n";blue_echo
echo 'export NODE_PATH=$HOME/local/node/lib/node_modules' >> $HOME/.bashrc

MESSAGE="Removing Node directory packages\n"; blue_echo
rm -rf $HOME/Node
ensure_success "$?" "Error removing Downloads directory" "Removed Downloads directory"

MESSAGE="Loading node and npm \n";green_echo
echo 'source $HOME/.bashrc'

MESSAGE="After sourcing bashrc : You can verify the versions as below  \n"; blue_echo
echo 'node -v '
echo 'npm -v '

echo 'npm install -g forever'