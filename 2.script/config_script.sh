#!/usr/bin/env bash
set -eu

export DEBIAN_FRONTEND=noninteractive

sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf

sudo apt-get update
sudo apt-get upgrade -y

sleep 20

#
sudo apt-get install mysql-server-8.0 -y

#
sudo apt-get install nginx php-mysql php-fpm monit -y

sudo systemctl start nginx php8.1-fpm
sudo systemctl enable mysql nginx php8.1-fpm

# Modules
sudo apt-get install -y php-curl php-common php-imagick php-mbstring php-xml php-zip php-json php-xmlrpc php-gd

# nginx config
sudo mkdir -p /usr/share/nginx/cache/fcgi
sudo rm /etc/nginx/sites-enabled/default

# WORDPRESS SET-UP

# Variables
BASENAME=simonhaddadgervais
LOGFILE=/etc/script.log
echo "STARTING!" | sudo tee -a $LOGFILE


## Create user for website
sudo useradd -s /bin/bash -m -d /home/$BASENAME $BASENAME
sudo mkdir -p /home/$BASENAME/logs
sudo chown -R $BASENAME:www-data /home/$BASENAME


# Create the php-fpm logfile
sudo -u ${BASENAME} touch /home/${BASENAME}/logs/phpfpm_error.log

# Clean old pool conf
sudo rm /etc/php/8.1/fpm/pool.d/www.conf

## MYSQL

MYPASS=$(echo -n @ && cat /dev/urandom | env LC_CTYPE=C tr -dc [:alnum:] | head -c 15 && echo)

echo MYSQL PASS: $MYPASS | sudo tee -a $LOGFILE


# Create database and user
sudo mysql -u root << EOF
CREATE DATABASE ${BASENAME};
CREATE USER '${BASENAME}'@'localhost' IDENTIFIED BY '${MYPASS}';
GRANT ALL PRIVILEGES ON ${BASENAME}.* TO ${BASENAME}@localhost;
FLUSH PRIVILEGES;
EOF


## Install WordPress
wget --quiet https://wordpress.org/latest.tar.gz
tar zxf latest.tar.gz
rm latest.tar.gz
sudo mv wordpress /home/${BASENAME}/public_html

# Manage permissions
sudo chown -R ${BASENAME}:www-data /home/${BASENAME}/public_html
sudo find /home/${BASENAME}/public_html -type d -exec chmod 755 {} \;
sudo find /home/${BASENAME}/public_html -type f -exec chmod 644 {} \;

# Make room for the new nginx.conf file
sudo rm /etc/nginx/nginx.conf

# Install certbot to get TLS certificate for the website
sudo apt install certbot python3-certbot-nginx -y
# Detect the nginx server and configure the certificate
sudo certbot --nginx

echo "$(date) - Done" | sudo tee -a $LOGFILE
exit 0
