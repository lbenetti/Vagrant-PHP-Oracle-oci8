Ambiente de desenvolvimento com PHP e Oracle instaclient oci8
=============================

Vagrant com OCI8. Forked de [https://github.com/joselfonseca/Vagrant-PHP-Oracle-oci8](joselfonseca/Vagrant-PHP-Oracle-oci8).

Informação do servidor
=============================

	Ip de servidor: 192.168.40.100
	Redirecionamentos:
		22 -> 2222
		80 -> 8080
	Usuario MySQL: root
	Senha MySQL: root
	Usuario SSH: vagrant
	Senha SSH: vagrant

O que vem com o ambiente?
=============================

	PHP 5.5
	Python
	Vim
	Curl
	Git
	Oracle Instaclient 12.1
	oci8
	php5-mcrypt
	php5-gd
	php5-curl
	php5-xdebug
	php5-json
	Composer

Instruções
=============================

1. Faça o download do repositório.
2. Coloque os arquivos no diretório que você deseja.
3. Navegue até o diretório do console onde você salvou os arquivos.
4. Execute `vagrant up`
5. Por padrão, o ambiente é configurado com NLS_LANG = "AMERICAN_AMERICA.WE8MSWIN1252." Se você quiser trocar, altere os arquivos /etc/enviroment e /etc/apache2/envvars.

Onde colocar os fontes?
============================

Você pode colocar as teias no diretório "websites" que está compartilhada com a máquina virtual com o ponto de montagem /vagrant/websites
Se você deseja criar "Virtual Hosts", deverá fazer manualmente via `vagrant ssh`.

Referências
============================
- [https://github.com/vplanas/Vagrant-PHP-Oracle-oci8](vplanas/Vagrant-PHP-Oracle-oci8).
- [https://github.com/joselfonseca/Vagrant-PHP-Oracle-oci8](joselfonseca/Vagrant-PHP-Oracle-oci8).
- [https://github.com/JeffreyWay/Vagrant-Setup](JeffreyWay - Vagrant-Setup)
- [https://gist.github.com/fideloper/7074502](https://gist.github.com/fideloper/7074502)
- [Setting Up Vagrant With Laravel 4](http://culttt.com/2013/06/17/setting-up-vagrant-with-laravel-4/)
- [Instaclient script] (https://github.com/eikonomega/oracle_instant_client_for_ubuntu_64bit)
- [How to Install the Latest Version of PHP 5.5 on Ubuntu](http://www.dev-metal.com/how-to-setup-latest-version-of-php-5-5-on-ubuntu-12-04-lts/)

