Entorn de desenvolupament PHP amb Oracle instaclient i oci8, preparat per treballar amb Symfony2
=============================

Entorn vagrant amb OCI8 i preparat per symfony2 en entorn UB, forked from - [https://github.com/joselfonseca/Vagrant-PHP-Oracle-oci8](joselfonseca/Vagrant-PHP-Oracle-oci8).

Informació del servidor
=============================

	Ip del servidor: 192.168.40.100
	Redireccions:
		22 -> 2222
		80 -> 8080
	Usuari MySQL: root
	Contraseña MySQL: root
	Usuari SSH: vagrant
	Contraseña SSH: vagrant

Que ve amb el servidor?
=============================

	PHP 5.5
	Python
	Vim
	Curl
	MySQL 5.5
	phpmyadmin
	Node JS
	Gulp
	Grunt
	Bower
	Git
	Mailcatcher
	Oracle Instaclient 12.1
	oci8
	php5-mcrypt
	php5-gd
	php5-curl
	php5-xdebug
	php5-json
	Composer

Instruccions
=============================

1. Descarrega el reposistori.
2. Col·loca els fitxers al directori desitjat.
3. Navega amb la consola fins el directori on has desat els fitxers.
4. Executa `vagrant up`
5. Per defecte es treballa amb NLS_LANG="CATALAN_CATALONIA.AL32UTF8". Si es vol treballar amb ISO8859-15 cal canviar a /etc/enviroment i a /etc/apache2/envvars la variable NLS_LANG per "CATALAN_CATALONIA.WE8ISO8859P15"
6. Tot t'hauria de funcionar.
7. Alerta que no està preparat per fer un --provision, ja que crea entrades duplicades en alguns fitxers de configuració. Cal fer un `vagrant destroy` / `vagrant up`. 

On col·locar les webs?
============================

Pots col·locar les webs al directory "websites" que es comparteix amb la màquina virtual amb el punt de muntatge /vagrant/websites.
Si vols crear "virtual hosts" ho has de fer manualment accedint per ssh al servidor via `vagrant ssh`.

Què passa amb Mailcather?
============================
Un cop provisionat, el servidor arrenca Mailcatcher amb la IP 192.168.40.100. Per accedir a la interfície web de Mailcatcher s'ha de navegar a http://192.168.40.100:1080. Cal configurar les vostres aplicacions per enviar mitjançant SMTP amb la IP 192.168.40.100 i port 1025, sense usuari, sense password i sense encriptació.

Referències:
============================
- [https://github.com/joselfonseca/Vagrant-PHP-Oracle-oci8](joselfonseca/Vagrant-PHP-Oracle-oci8).
- [https://github.com/JeffreyWay/Vagrant-Setup](JeffreyWay - Vagrant-Setup)
- [https://gist.github.com/fideloper/7074502](https://gist.github.com/fideloper/7074502)
- [Setting Up Vagrant With Laravel 4](http://culttt.com/2013/06/17/setting-up-vagrant-with-laravel-4/)
- [Instaclient script] (https://github.com/eikonomega/oracle_instant_client_for_ubuntu_64bit)
- [How to Install the Latest Version of PHP 5.5 on Ubuntu](http://www.dev-metal.com/how-to-setup-latest-version-of-php-5-5-on-ubuntu-12-04-lts/)
