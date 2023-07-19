# WordPress website hosted on AWS

This project aims to setup a production grade Nginx webserver on Ubuntu EC2 instance, hosting a WordPress application.
This configuration also includes:
* Security hardening with permissions, SSH keys.
* HTTPS requests with certbot.
* Monitoring with Monit.
* Scheduled backups with Cron.

## Instructions
###### *This is based on a temporary lab. This is not live anymore.*
#### Create an EC2 instance with Ubuntu server

Allow SSH, HTTP and HTTPS requests (port 22, 80 and 443)

#### Run the first script, which is going to install nginx, php, mysql, monit..

`ssh -i "mykeypair.pem" ubuntu@ec2-3-73-62-223.eu-central-1.compute.amazonaws.com 'bash -s' < config_script.sh`

#### Run the second script, which is gonna move all config files to the server, install certbot and restart services

`./move_files_script.sh`

#### Local port forwarding to access Monit

`ssh -i mykeypair.pem -L 8383:localhost:2812 ubuntu@ec2-3-123-38-228.eu-central-1.compute.amazonaws.com`

Monitor with Monit from localhost:8383 on a browser

#### Now we can set-up the WordPress website as we see fit for our business!

add */wp-admin/setup-config.php* at the end of the server's name.  

http://test.simonhaddadgervais.com/wp-admin/setup-config.php


### Room for improvement...

I could use Ansible to configure everything.  
For a larger grade experiment I could improve availability by running multiple EC2 instances behind a load balancer
(and at the same time replace certbot with ACM for the SSL certificate).
