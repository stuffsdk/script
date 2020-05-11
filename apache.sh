#!/bin/bash

echo -e "\e[32mWelcome to stuffsdk installation what is your site name?\e[0m"
read WEB_DOMAIN

apt-get update
apt install -y wget
apt install -y apache2

apt -y install software-properties-common
add-apt-repository ppa:ondrej/php

apt-get update
apt -y install php7.4
apt install php7.4-mysql

service apache2 stop
apt-get install nano
echo '<IfModule mod_dir.c>
        DirectoryIndex index.php index.html index.cgi index.pl index.xhtml inde$
</IfModule>' > /etc/apache2/mods-enabled/dir.conf
a2enmod rewrite
a2dissite 000-default.conf

mkdir -p /var/www/${WEB_DOMAIN}
chown -R $USER:www-data /var/www/${WEB_DOMAIN}
#chown -R www-data:www-data /var/www/${WEB_DOMAIN}

echo "<VirtualHost *:80>

        <Directory /var/www/${WEB_DOMAIN}>
           Options Indexes FollowSymLinks MultiViews
           AllowOverride All
           Require all granted
        </Directory>

        ServerAdmin admin@${WEB_DOMAIN}
        DocumentRoot /var/www/${WEB_DOMAIN}
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>" > /etc/apache2/sites-available/${WEB_DOMAIN}.conf

a2ensite ${WEB_DOMAIN}.conf

apt-get install -y git
git config --global user.name "${WEB_DOMAIN}"
git config --global user.email "server@${WEB_DOMAIN}"
#mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -f ~/.ssh/bitbucket_rsa -q -N ""
echo 'Host bitbucket.org
 IdentityFile ~/.ssh/bitbucket_rsa' > ~/.ssh/config
cd /var/www

cat ~/.ssh/bitbucket_rsa.pub
echo 'We are about to clone please update ssh key to bibucket to continue. [Enter]'
read SHOULD_CLONE

git clone git@bitbucket.org:maroof_khan/stuffpie.git

rm -r ${WEB_DOMAIN}
mv stuffpie ${WEB_DOMAIN}
cd
echo "#!/bin/sh
while true
do
      cd /var/www/${WEB_DOMAIN}
      git pull
      sleep 10
done" > auto.sh

chmod 755 auto.sh
nohup ./auto.sh >/dev/null 2>&1 &

service apache2 start

add-apt-repository ppa:certbot/certbot
apt-get update
apt-get install -y python-certbot-apache
#certbot --apache -d ${WEB_DOMAIN}


#install seller
mkdir -p /var/www/${WEB_DOMAIN}/sites/seller.${WEB_DOMAIN}
chown -R $USER:www-data /var/www/${WEB_DOMAIN}/sites/seller.${WEB_DOMAIN}
echo "<VirtualHost *:80>

        <Directory /var/www/${WEB_DOMAIN}/sites/seller.${WEB_DOMAIN}>
           Options Indexes FollowSymLinks MultiViews
           AllowOverride All
           Require all granted
        </Directory>

        ServerAdmin admin@${WEB_DOMAIN}
        DocumentRoot /var/www/${WEB_DOMAIN}/sites/seller.${WEB_DOMAIN}
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>" > /etc/apache2/sites-available/seller.${WEB_DOMAIN}.conf
a2ensite seller.${WEB_DOMAIN}.conf
#certbot --apache -d seller.${WEB_DOMAIN}

#install affliate
mkdir -p /var/www/${WEB_DOMAIN}/sites/affiliate.${WEB_DOMAIN}
chown -R $USER:www-data /var/www/${WEB_DOMAIN}/sites/affiliate.${WEB_DOMAIN}
echo "<VirtualHost *:80>

        <Directory /var/www/${WEB_DOMAIN}/sites/affiliate.${WEB_DOMAIN}>
           Options Indexes FollowSymLinks MultiViews
           AllowOverride All
           Require all granted
        </Directory>

        ServerAdmin admin@${WEB_DOMAIN}
        DocumentRoot /var/www/${WEB_DOMAIN}/sites/affiliate.${WEB_DOMAIN}
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>" > /etc/apache2/sites-available/affiliate.${WEB_DOMAIN}.conf
a2ensite affiliate.${WEB_DOMAIN}.conf
#certbot --apache -d affiliate.${WEB_DOMAIN}

#install stuffp.ie
mkdir -p /var/www/${WEB_DOMAIN}/sites/stuffp.ie
chown -R $USER:www-data /var/www/${WEB_DOMAIN}/sites/stuffp.ie
echo "<VirtualHost *:80>

        <Directory /var/www/${WEB_DOMAIN}/sites/stuffp.ie>
           Options Indexes FollowSymLinks MultiViews
           AllowOverride All
           Require all granted
        </Directory>

        ServerAdmin admin@${WEB_DOMAIN}
        DocumentRoot /var/www/${WEB_DOMAIN}/sites/stuffp.ie
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>" > /etc/apache2/sites-available/stuffp.ie.conf
a2ensite stuffp.ie.conf
#certbot --apache -d stuffp.ie
chown -R www-data.www-data /var/www/${WEB_DOMAIN}/
exit

#echo 'Where is apps repository located enter?'
#read APPS_REPO
#
#mv -r /var/www/${WEB_DOMAIN}/apps /var/www/${WEB_DOMAIN}/apps_backup
#
#cd /var/www/${WEB_DOMAIN}
#git clone $APPS_REPO
#
#basename=$(basename $APPS_REPO)
#
#mv $basename apps

apt install -y mysql-server
service mysql start
mysql_secure_installation
mysql -u root -p
#CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
# CREATE DATABASE master;
# GRANT ALL PRIVILEGES ON master.* TO 'admin'@'localhost';


#go
#curl -O https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
#sha256sum go1.10.3.linux-amd64.tar.gz
#tar xvf go1.10.3.linux-amd64.tar.gz
#chown -R root:root ./go
#mv go /usr/local
#echo 'export GOPATH=$HOME/work' >> ~/.profile
#echo 'export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin' >> ~/.profile
#source ~/.profile

#mqtt
#apt-get update
#apt-get install mosquitto
#
#
#git clone https://github.com/iegomez/mosquitto-go-auth.git
#cd mosquitto-go-auth
#make dev-requirements
#
#apt-get install libwebsockets8 libwebsockets-dev libc-ares2 libc-ares-dev openssl uuid uuid-dev
#apt-get install build-essential libwrap0-dev libssl-dev libc-ares-dev uuid-dev xsltproc
#adduser mosquitto
#usermod -aG sudo mosquitto
#su mosquitto
#cd


#mqtt
#apt-get install make
#apt-get install libwebsockets8 libwebsockets-dev libc-ares2 libc-ares-dev openssl uuid uuid-dev
#
