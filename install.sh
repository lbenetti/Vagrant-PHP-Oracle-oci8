#!/usr/bin/env bash

echo "--- Good morning, master. Let's get to work. Installing now. ---"

echo "--- Updating packages list ---"
sudo apt-get update

echo "--- MySQL time ---"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo "--- Installing ACL ---"
sudo apt-get install acl

echo "--- Installing base packages ---"
sudo apt-get install -y vim curl python-software-properties

echo "--- Installing PHP-specific packages ---"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql php5-json php5-intl git
echo "--- Installing and configuring Xdebug ---"
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1
xdebug.max_nesting_level
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
sed -i "s/;date.timezone =/date.timezone = Europe\/Madrid/" /etc/php5/apache2/php.ini
sed -i "s/;date.timezone =/date.timezone = Europe\/Madrid/" /etc/php5/cli/php.ini
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sed -i 's/html//' /etc/apache2/sites-available/000-default.conf

# Install PhpMyAdmin
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections
apt-get install phpmyadmin -y

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

cat << EOF | sudo tee -a "/etc/environment"
# Oracle Instant Client
LD_LIBRARY_PATH="/usr/lib/oracle/12.1/client64/lib/"
TNS_ADMIN="/usr/lib/oracle/12.1/client64/network/admin"
ORACLE_BASE="/usr/lib/oracle/12.1/client64"
ORACLE_HOME=$ORACLE_BASE
export NLS_LANG="CATALAN_CATALONIA.AL32UTF8"
EOF

cat << EOF | sudo tee -a "/etc/apache2/envvars"
# Oracle Instant Client
LD_LIBRARY_PATH="/usr/lib/oracle/12.1/client64/lib/"
TNS_ADMIN="/usr/lib/oracle/12.1/client64/network/admin"
ORACLE_BASE="/usr/lib/oracle/12.1/client64"
ORACLE_HOME=$ORACLE_BASE
export NLS_LANG="CATALAN_CATALONIA.AL32UTF8"
EOF

echo "--- Creating oci8 extension ---"
printf "\n" | sudo pecl install oci8


echo "--- Enabling oci8 extension ---"
cat << EOF | sudo tee -a /etc/php5/mods-available/oci8.ini
extension=oci8.so
EOF

echo "--- Configuring tnsnames UB ---"
cat << EOF | sudo tee "/usr/lib/oracle/12.1/client64/network/admin/ldap.ora"
DEFAULT_ADMIN_CONTEXT = ""
DIRECTORY_SERVERS= (oid1.ub.edu:389:636 , oid2.ub.edu:389:636)
DIRECTORY_SERVER_TYPE = OID
EOF

cat << EOF | sudo tee "/usr/lib/oracle/12.1/client64/network/admin/sqlnet.ora"
NAMES.DIRECTORY_PATH= (LDAP, TNSNAMES)
EOF

echo "--- Restarting Apache ---"
sudo service apache2 restart

echo "--- Installing Composer"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "--- Esperem que et funcioni! :) ---"
