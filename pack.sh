#!/bin/bash

#tar -czvf ../bc-vagrant.tgz \
#	--exclude public_html \
#	--exclude log \
#	--exclude .vagrant \
#	--exclude .DS* \
#	.

zip -v -9 ../bc-vagrant README Vagrantfile *.sh *.sql* *.bz2 site.conf *.php

