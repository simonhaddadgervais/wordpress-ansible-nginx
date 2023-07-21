# WordPress website hosted on AWS

This project aims to set up a production grade Nginx webserver on Ubuntu EC2 instance, hosting a WordPress application.
This configuration also includes:
* Security hardening with permissions, SSH keys.
* HTTPS requests with certbot.
* Monitoring with Monit.

------------------------------
I created two versions for this project.  
One which use **Ansible**, the other use **Bash scripts**. They both do the same things.  
My process was first deploying everything manually on the remote machine, then automating all the command with Bash scripts, 
and finally I replaced scripts with Ansible, which is way cleaner and more efficient.



### Room for improvement...

I could implement scaling by running multiple EC2 instances behind a load balancer, and replace certbot
with ACM for the SSL certificate. I could also implement master-slave replication for MySQL to improve availability. 