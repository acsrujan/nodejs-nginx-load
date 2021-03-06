# nodejs-nginx-load
Nginx as load balancer for nodejs application servers
This is written in bash for the version 1. It shall be improved to Ansible, Chef variants with time.

###Goal

Write a script which will automate following tasks.

i.  Start the new nginx server (listen to port 80).

ii. create node.js environment.

iv. pull git repo (nodejs hello world) and start server (it will start on 8080 port)

v. add this node.js server process to load balancer.

vi. if load balancer getting 100 requests/minute then spin up new node.js server process which will listen on next available port. add this new node server to load balancer.

vi. If number of request fall below 100 requests/minute then stop node.js server process. Server which is most recently created should stop.

###Clone and start
Clone this repo in home folder.

Nodejs is installed in non sudo current user.


To install:
`ssh ubuntu@ip < install.sh`
This installs nginx, nodejs, forever, etc. as required.

To configure:
`ssh ubuntu@ip < config.sh`

To deploy:
`ssh-add /path/to/privatekey_which_has_access_to_git_repo`
`ssh -A ubuntu@ip < deploy.sh`

###Approaches
1. Nginx to do load balancing. Uses upstream.
Alternatives: haproxy
2. nodejs process run on ports 8080, 8081 during run.sh. 8080 is never killed, in this process.
3. request per minute is calculated by parsing nginx status output every minute, finding difference in number of requests.
100 is purely for experiment. In reality, nginx handles higher number of requests.
4. New node process is spawned or killed, based on above parameter.
5. forever is used in running nodejs process.
