PHP development Environment With Oracle instaclient and oci8
=============================

My personal Vagrant environtment, forked from - [https://github.com/JeffreyWay/Vagrant-Setup](JeffreyWay - Vagrant-Setup) with some stuff of my own.

Server Info
=============================

	Server ip: 192.168.40.100
	MySQL User: root
	MySQL Password: root
	SSH user: vagrant
	SSH Password: vagrant

What comes in the server
=============================

	PHP 5.5
	MySQL 5.5
	Node JS
	Gulp
	Grunt
	Bower
	Mailcatcher
	Oracle Instaclient 12.1
	oci8

How to use it
=============================

	1. Download the repo.
	2. Place the files in the directory of your choice.
	3. Navigate in your console to that folder
	4. Run vagrant up
	5. Per defecte es treballa amb NLS_LANG="CATALAN_CATALONIA.AL32UTF8". Si es vol treballar amb ISO8859-15 cal canviar a /etc/enviroment i a /etc/apache2/envvars la variable NLS_LANG per "CATALAN_CATALONIA.WE8ISO8859P15"
	6. You should be good to go.

Where to put the websites?
============================

You can place each website in the websites directory with their own folder, if you want to create virtual hosts for them, you have to do it manually in the server accesing via `vagrant ssh`.

What about Mailcatcher?
============================
Once provisioned, the server will start mailchacter with the ip 192.168.40.100, to access the web interface, navigate to http://192.168.40.100:1080, configure your app to send email using SMTP to the ip 192.168.40.100 and port 1025, no user, no password and no encription.


Thanks goes to the following references:

- [https://github.com/JeffreyWay/Vagrant-Setup](JeffreyWay - Vagrant-Setup)
- [https://gist.github.com/fideloper/7074502](https://gist.github.com/fideloper/7074502)
- [Setting Up Vagrant With Laravel 4](http://culttt.com/2013/06/17/setting-up-vagrant-with-laravel-4/)
- [Instaclient script] (https://github.com/eikonomega/oracle_instant_client_for_ubuntu_64bit)
- [How to Install the Latest Version of PHP 5.5 on Ubuntu](http://www.dev-metal.com/how-to-setup-latest-version-of-php-5-5-on-ubuntu-12-04-lts/)
