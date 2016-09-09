#!/usr/bin/env bash

echo "--- Good morning, master. Let's get to work. Installing now. ---"

echo "--- Adiciona o repositorio do JAVA8. ---"
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update -q
sudo apt-get install -y vim curl software-properties-common python-software-properties
sudo echo debconf shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo /usr/bin/debconf-set-selections
sudo apt-get install --yes oracle-java8-installer
yes "" | sudo apt-get -f install

echo "--- MySQL time ---"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'


echo "--- Installing ACL ---"
sudo apt-get install -y acl

echo "--- Installing PHP-specific packages ---"
sudo apt-get install -y php5 apache2 libapache2-mod-php5 php5-curl php5-gd php5-mcrypt mysql-server-5.5 php5-mysql php5-json php5-intl git
echo "--- Installing and configuring Xdebug ---"
sudo apt-get install -y php5-xdebug

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1
xdebug.max_nesting_level=250
xdebug.remote_enable =1
xdebug.remote_host="localhost"
xdebug.remote_connect_back=1
xdebug.remote_handler=dbgp
xdebug.idekey=ECLIPSE_DBGP
EOF

echo "--- Enabling mcrypt in all environments ---"
sudo php5enmod -s ALL mcrypt

echo "--- Enabling mod-rewrite ---"
sudo a2enmod rewrite

echo "--- Setting document root ---"
sudo rm -rf /var/www
sudo ln -fs /vagrant/websites /var/www


echo "--- What developer codes without errors turned on? Not you, master. ---"
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sudo sed -i "s/;date.timezone =/date.timezone = America\/Sao_Paulo/" /etc/php5/apache2/php.ini
sudo sed -i "s/;date.timezone =/date.timezone = America\/Sao_Paulo/" /etc/php5/cli/php.ini
sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sudo sed -i 's/html//' /etc/apache2/sites-available/000-default.conf


# Install phpMyAdmin
echo "--- Installing phpMyAdmin ---"
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | sudo debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password root' | sudo debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password root' | sudo debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password root' | sudo debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | sudo debconf-set-selections
sudo apt-get install phpmyadmin -y


echo "--- Altera o usuario do apache para vagrant:vagrant... ---"
sudo sed -i "s/export APACHE_RUN_USER=.*/export APACHE_RUN_USER=vagrant/" /etc/apache2/envvars
sudo sed -i "s/export APACHE_RUN_GROUP=.*/export APACHE_RUN_GROUP=vagrant/" /etc/apache2/envvars

echo "--- Restarting Apache ---"
sudo service apache2 restart

echo "--- Composer is the future. But you knew that, did you master? Nice job. ---"
curl -sS https://getcomposer.org/installer | sudo php
sudo mv composer.phar /usr/local/bin/composer


echo "----- Install some dependencies! ----"
sudo apt-get install -y libsqlite3-dev
sudo apt-get install -y ruby1.9.1-dev
sudo apt-get install -y build-essential g++

echo "----- OK here is where we get a little hardcore! ----"

sudo python /vagrant/oracle/oracleinstantclient.py /vagrant/oracle

echo "---- we now need oci8 ----"
sudo apt-get install -y php-pear php5-dev

cat << EOF | sudo tee -a "/etc/environment"
# Oracle Instant Client
LD_LIBRARY_PATH="/usr/lib/oracle/12.1/client64/lib/"
TNS_ADMIN="/usr/lib/oracle/12.1/client64/network/admin"
ORACLE_BASE="/usr/lib/oracle/12.1/client64"
ORACLE_HOME="\$ORACLE_BASE"
NLS_LANG="AMERICAN_AMERICA.WE8MSWIN1252"
EOF

cat << EOF | sudo tee -a "/etc/apache2/envvars"
# Oracle Instant Client
export LD_LIBRARY_PATH="/usr/lib/oracle/12.1/client64/lib/"
export TNS_ADMIN="/usr/lib/oracle/12.1/client64/network/admin"
export ORACLE_BASE="/usr/lib/oracle/12.1/client64"
export ORACLE_HOME="\$ORACLE_BASE"
export NLS_LANG="AMERICAN_AMERICA.WE8MSWIN1252"
EOF

# Set Oracle configuration alias
sudo ln -fs /vagrant/oracle/sqlnet.ora /usr/lib/oracle/12.1/client64/network/admin/sqlnet.ora
sudo ln -fs /vagrant/oracle/tnsnames.ora /usr/lib/oracle/12.1/client64/network/admin/tnsnames.ora


echo "--- Creating oci8 extension ---"
printf "\n" | sudo pecl install oci8-1.4.10


echo "--- Enabling oci8 extension ---"
cat << EOF | sudo tee -a /etc/php5/mods-available/oci8.ini
extension=oci8.so
EOF

sudo php5enmod oci8

echo "--- Restarting Apache ---"
sudo service apache2 restart


echo "--- Espero que tenha funcionado! :) ---"
