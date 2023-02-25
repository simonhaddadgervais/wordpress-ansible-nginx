# copy our config files from local machine to the remote EC2 instance with ssh
cat /home/simon/aws/conf/nginx_wordpress_vhost.conf | ssh -i "mykeypair.pem" ubuntu@ec2-3-73-62-223.eu-central-1.compute.amazonaws.com "sudo tee /etc/nginx/conf.d/simonhaddadgervais.conf"
cat /home/simon/aws/conf/phpfpm_wordpress_vhost.conf | ssh -i "mykeypair.pem" ubuntu@ec2-3-73-62-223.eu-central-1.compute.amazonaws.com "sudo tee /etc/php/8.1/fpm/pool.d/simonhaddadgervais.conf"
cat /home/simon/aws/conf/site_wordpress.cnf | ssh -i "mykeypair.pem" ubuntu@ec2-3-73-62-223.eu-central-1.compute.amazonaws.com "sudo tee /etc/monit/conf-available/site-wordpress.cnf"
cat /home/simon/aws/conf/monitrc | ssh -i "mykeypair.pem" ubuntu@ec2-3-73-62-223.eu-central-1.compute.amazonaws.com "sudo tee /etc/monit/monitrc"
cat /home/simon/aws/conf/nginx.conf | ssh -i "mykeypair.pem" ubuntu@ec2-3-73-62-223.eu-central-1.compute.amazonaws.com "sudo tee /etc/nginx/nginx.conf"

ssh -i "mykeypair.pem" ubuntu@ec2-3-73-62-223.eu-central-1.compute.amazonaws.com << EOF
  sudo chmod 600 /etc/monit/monitrc
  sudo apt install certbot python3-certbot-nginx -y
  echo -e "haddad.simon@aol.fr\nY\nN\n1" | sudo certbot --nginx
  sudo systemctl restart nginx && sudo systemctl restart php8.1-fpm
  sudo systemctl restart monit
EOF

exit 0