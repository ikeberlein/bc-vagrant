#!/bin/bash
#
# Development server configuration for bubblecoup
# Copyright (C) 2016 by Ivan Keberlein <ivan@keberlein.org>
#___________________________________________________________

export DEBIAN_FRONTEND=noninteractive

apt-get -q -y update 
apt-get -q -y upgrade

#
# Install needed packages
#___________________________________________________________

apt-get -q -y install mysql-server
apt-get -q -y install postfix git vim-nox
apt-get -q -y install \
	apache2 \
	libapache2-mod-php5 \
	libapache2-mod-rpaf \
	libapache2-mod-xsendfile \
	php5 \
	php5-cgi \
	php5-cli \
	php5-common \
	php5-curl \
	php5-gd \
	php5-gmp \
	php5-imagick \
	php5-imap \
	php5-mcrypt \
	php5-memcached \
	php5-mysql \
	php5-sqlite \
	php5-xcache \
	php5-adodb \
	php5-mhash \
	php5-tidy 

#
# Ensure all directories exist
#___________________________________________________________
if [ ! -d /vagrant/log ]; then 
	mkdir -p /vagrant/log
fi

#
# Configure MySQL
#___________________________________________________________
MYSQLCFG=/etc/mysql/conf.d/local.cnf
if [ ! -r $MYSQLCFG ]; then
	( echo "[mysqld]"; echo "bind-address=0.0.0.0" ) > $MYSQLCFG
	service mysql restart
fi

#
# Init site's database
#___________________________________________________________

sql_exec() {
	echo "$1" | mysql -u root "$2"
}

sql_execi() {
	mysql -u root "$1"
}

edit_database() {
	# set admin user login to 'admin' and password to 'test'
	sql_execi $DBNAME <<SQL
update wp_users set user_login='admin', user_nicename='admin', display_name='Admin Workerson', user_pass='\$P\$B55D6LjfHDkINU5wF.v2BuuzO0/XPk/' where id=1;
update wp_options set option_value='http://localhost:8080' where option_name='siteurl';
update wp_options set option_value='http://localhost:8080' where option_name='home';
update wp_options set option_value='0' where option_name='hide_my_site_enabled';
SQL
}

create_database() {
	sql_execi <<SQL
create database $DBNAME default character set 'utf8';
grant all privileges on $DBNAME.* to $DBUSER@'%' identified by '$DBPASS';
flush privileges;
SQL
}

update_database() {
	echo "*** recreating the database"
	create_database
	cat $DBUPD | mysql -u root $DBNAME
	edit_database
}

drop_database() {
	sql_exec "drop database $DBNAME;"
}

DBAPAS=dbapass
DBNAME=bubbleco_wpdb
DBUSER=bubblecoup
DBPASS=bubblecouppass
DBDUMP=/vagrant/bubble.sql.bz2
DBUPD=/vagrant/$DBNAME.sql

# if database doesn't exist
if [ ! `sql_exec "show databases" | grep -q $DBNAME` ]; then
	echo "*** Setting up database"
	
	# Create DBA account
	sql_exec "grant all privileges on *.* to dba@'%' identified by '$DBAPAS' with grant option;"
	sql_exec "flush privileges;"

	if [ -r $DBUPD ]; then
		drop_database
		update_database
	else
		create_database
		# Restore database from dump
		if [ -r $DBDUMP ]; then 
			bzcat $DBDUMP | mysql -u root $DBNAME
			edit_database
		else
			drop_database
			echo "[WARNING] no database dump found at $DBDUMP"
		fi
	fi
	echo "*** Database setup done"
else
	if [ -r $DBUPD ]; then
		drop_database
		update_database
	fi
fi

#
# Configure web server
#___________________________________________________________

if [ ! -r /etc/apache2/sites-available/site.conf ]; then
	a2dissite "000-default.conf"
	cp /vagrant/site.conf /etc/apache2/sites-available
	a2ensite site
	a2enmod rewrite
	service apache2 reload
	
	# under windows we have problem starting apache.
	# it starts before /vagrant folder is available. 
	# and fails to start because document root and 
	# logs directory are still not accesible at that moment. 
	# this is a workaround for the problem.
	sed -i -e '/exit 0/d' /etc/rc.local
	echo 'echo /usr/sbin/service apache2 start | at now + 2 minute' >> /etc/rc.local
	echo 'exit 0' >> /etc/rc.local
fi

#
# Unbzip uploads & copy wp-config to site root
#___________________________________________________________

if [ -r /vagrant/public_html/index.php -a ! -d /vagrant/public_html/wp-content/uploads ]; then
	pushd /vagrant
	tar xjvf uploads.tar.bz2
	cp wp-config.php public_html
	popd
fi

