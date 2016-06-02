#!/bin/bash

start_new_node() {
  BASE=8080
  INCREMENT=1
  port=$BASE
  isfree=$(netstat -tapln | grep $port)

  while [[ -n "$isfree"]]; do
   port = $[port+INCREMENT]
   isfree=$(netstat -tapln | grep $port)
  done
  PORT=$isfree forever start $HOME/hello-world-node/main.js
  echo "server 127.0.0.1:$isfree max_fails=0 fail_timeout=10s weight=1" >> /etc/nginx/upstream.conf
  sed -i -e '/##START_SERVERS/,/##END_SERVERS/{//!d;/##START_SERVERS/r /etc/nginx/upstream.conf' -e '}' /etc/nginx/nginx.conf
 service nginx reload
}

stop_new_node() {
  lastserver=sed -n '$p' /etc/nginx/upstream.conf
  #lastserver=grep -B1 '##END_SERVERS' /etc/nginx/upstream.conf | grep -v '##END_SERVERS'
  lastport=${lastserver##*:} | head -n1 | awk '{print $1;}' 
  
  #Condition to be handled: Ensure that all servers aren't killed.
  if [ "$lastport" -ne 8080]
  then
    PORT=$lastport forever stop $HOME/hello-world-node/main.js
  fi
  sed "/$PORT/d" /etc/nginx/upstream.conf
  sed "/$PORT/d" /etc/nginx/conf.d/nodejs.conf
  service nginx reload
}

output1=`wget -O -q -t 3 -T 3 http://test.com/basic_status`
sleep 60
output2=`wget -O -q -t 3 T 3 http://test.com/basic_status`

tmp1_reqpmin=`echo ${out1}|awk '{print $10}'`
tmp2_reqpmin=`echo ${out2}|awk '{print $10}'`
reqpmin=`expr $tmp2_reqmin - $tmp1_reqmin`
if [ "$reqpmin" gt 100]
then
   start_new_node();
fi

if [ "$reqpmin" lt 100]
then
   stop_new_node();
fi
