# WordPress website hosted on AWS

## Instructions
#### Create an EC2 instance

Choose Ubuntu

Allow SSH, HTTP and HTTPS requests (port 22, 80 and 443)

#### Run the first script, which is going to install nginx, php, mysql, monit..

`ssh -i "mykeypair.pem" ubuntu@ec2-ipaddress.eu-central-1.compute.amazonaws.com 'bash -s' < config_script.sh`

#### Run the second script, which is gonna move all config files to the server, install certbot and restart services

`./move_files_script.sh`

#### Local port forwarding to access Monit

`ssh -i mykeypair.pem -L 8383:localhost:2812 ubuntu@ec2-ipaddress.eu-central-1.compute.amazonaws.com`

Monitor with Monit from localhost:8383 on a browser

#### Now we can set up the WordPress website as we see fit for our business!

add */wp-admin/setup-config.php* at the end of the server's name.  

for example :

http://test.simonhaddadgervais.com/wp-admin/setup-config.php

