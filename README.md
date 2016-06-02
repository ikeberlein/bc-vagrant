Steps to configure local server for development.
All references to files and directories, if otherwise is not mentioned, are relative to this directory.

1. Make sure you have the latest version of bubble.sql.bz2. This is site's database dump.
2. Make sure you have the latest version of uploads.tar.bz2. This is uploads archive.
3. Clone site repository into public_html directory.
4. run 'vagrant up'

Resources accesible at virtual server:

	* site URL http://localhost:8080
	  - admin user name: admin
	  - admin password: test

	* MySQL server listens on port 33066
	  - admin user name: dba
	  - dba password: dbapass

Web server log files are located under log directory.

