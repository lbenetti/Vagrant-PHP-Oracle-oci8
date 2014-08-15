exec {
	"pecl-install-oci8":
		path => "/bin",
		command => "pecl install oci8 </answer-pecl-oci8.txt",
        user => root,
		timeout => 0,
        tries   => 5,
		unless => "/usr/bin/php -m | grep -c oci8",
}