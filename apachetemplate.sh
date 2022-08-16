#!/bin/bash
apt update -y
apt install -y apache2
systemctl start apache2.service
systemctl enable apache2.service
apt install -y php8.1-cli
apt install -y libapache2-mod-php php-mysqli
a2enmod php8.1
systemctl restart apache2
echo "${indexfile}" > /var/www/html/index.php