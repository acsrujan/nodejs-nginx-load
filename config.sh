#!/bin/bash

#Nginx config
sudo cp nodejs.conf /etc/nginx/sites-available/nodejs.conf
sudo ln -s /etc/nginx/sites-available/nodejs.conf /etc/nginx/sites-enabled/nodejs
sudo touch /etc/nginx/upstream.conf

#Req per min
sudo cp check_rpm.sh /etc/check_rpm
sudo cp reqpmin.conf /etc/init/reqpmin.conf
