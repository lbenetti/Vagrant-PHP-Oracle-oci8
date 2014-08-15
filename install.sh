#!/usr/bin/env bash

echo "--- Good morning, master. Let's get to work. Installing now. ---"

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- MySQL time ---"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl python-software-properties

echo "--- Installing PHP-specific packages ---"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql git-core

echo "--- Installing and configuring Xdebug ---"
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

echo "--- Enabling mcrypt in all environments ---"
sudo php5enmod -s ALL mcrypt

echo "--- Enabling mod-rewrite ---"
sudo a2enmod rewrite

echo "--- Setting document root ---"
sudo rm -rf /var/www
sudo ln -fs /vagrant/websites /var/www


echo "--- What developer codes without errors turned on? Not you, master. ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini

sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sed -i 's/html//' /etc/apache2/sites-available/000-default.conf

echo "--- Restarting Apache ---"
sudo service apache2 restart

echo "--- Composer is the future. But you knew that, did you master? Nice job. ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Laravel stuff here, if you want

echo "--- Why not istall Node.JS? we may need it in some projects"
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs
echo "--- Lest install some npm modules"
sudo npm install -g bower
sudo npm install -g grunt-cli
npm install -g gulp


echo "--- We need a way to read emails that are sent from our developments. Lets use mailchater"
#first we need Ruby
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y ruby1.9.1-dev
sudo apt-get install -y build-essential g++
sudo gem install mailcatcher

echo "--- Lets start and set the IP for the deamon ---"
mailcatcher --ip 192.168.40.100

echo "----- OK here is where we get a little hardcore! ----"

sudo python /vagrant/oracleinstantclient.py /vagrant/oracle

echo "---- we now need oci8 ----"
sudo apt-get install -y php-pear php5-dev

#sudo cat '# Oracle Instant Client
#LD_LIBRARY_PATH="/usr/lib/oracle/12.1/client64/lib/"
#TNS_ADMIN="/usr/lib/oracle/12.1/client64/network/admin"
#ORACLE_BASE="/usr/lib/oracle/12.1/client64"
#ORACLE_HOME=$ORACLE_BASE' >> "/etc/environment"


echo "--- All set to go! Would you like to play a game? ---"
