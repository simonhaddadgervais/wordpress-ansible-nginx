# WordPress - ANSIBLE

## Instructions
#### Create an EC2 instance

Choose Ubuntu

Configure your keypair for SSH

Allow SSH, HTTP and HTTPS requests (port 22, 80 and 443)

#### SSH into the instance

Install Ansible and Git

Git clone this repo

Configure the hosts in inventory folder  
Configure the variables in each role, to match your own domain name, passwords, email, db name etc..

Run `ansible-playbook playbook.yml`

#### Now we can set up the WordPress website as we see fit for our business!

add */wp-admin/setup-config.php* at the end of the server's name.  

for example :

http://test.simonhaddadgervais.com/wp-admin/setup-config.php

#### Local port forwarding to access Monit

Go to your computer terminal and run :

`ssh -i yourkeypair.pem -L 8383:localhost:2812 ubuntu@ec2-ipaddress.your-region.compute.amazonaws.com`

Go to a browser and go to localhost:8383 to access the monitoring interface.
