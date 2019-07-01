#!/bin/bash

if [ -z $LSCRIPTS ];then
  LSCRIPTS="."
fi

source $LSCRIPTS/linuxscripts.config.sh

if [ -z "$PHP_VER" ]; then
  PHP_VER="7.2"
  echo "Unable to get PHP version, falling back to default version#: $PHP_VER"
fi

## Enable Userdir Module
sudo a2enmod userdir

## Enable ReWrite Engine Module
sudo a2enmod rewrite

## Python with Apache

## disable multithreading processes
sudo a2dismod mpm_event

## Enable cgi
sudo a2enmod cgi
sudo a2enmod mpm_prefork cgi

## Enable WSGI: mod_wsgi
# sudo a2dismod wsgi
sudo a2enmod wsgi

if [ ! -d $HOME/public_html ]; then
  mkdir -p $HOME/public_html && chmod 0755 $HOME/public_html
fi

PHP_INSTALLED_VER=`php --version | cut -d'-' -f1 | grep -i php | cut -d' ' -f2`

echo "PHP_INSTALLED_VER: $PHP_INSTALLED_VER"

echo ""
echo "sudo vi /etc/apache2/mods-available/userdir.conf"
echo "Edit this file and make following entries"
cat << EOF
<IfModule mod_userdir.c>
  UserDir public_html
  UserDir disabled root


  #Solution using mod_headers and mod_setenvif
  <IfModule mod_headers.c>
     SetEnvIf Origin (.*) AccessControlAllowOrigin=$1
     Header add Access-Control-Allow-Origin %{AccessControlAllowOrigin}e env=AccessControlAllowOrigin
     Header set Access-Control-Allow-Credentials true
  </IfModule> 

  <Directory /home/*/public_html>
    #AllowOverride FileInfo AuthConfig Limit Indexes
    #Options MultiViews Indexes SymLinksIfOwnerMatch IncludesNoExec
    AllowOverride All
    Options MultiViews Indexes SymLinksIfOwnerMatch
    <Limit GET POST OPTIONS>
      # Apache <= 2.2:
      #Order allow,deny
      #Allow from all
 
      # Apache >= 2.4:
      Require all granted
    </Limit>
    <LimitExcept GET POST OPTIONS>
      # Apache <= 2.2:
      #Order deny,allow
      #Deny from all
 
      # Apache >= 2.4:
      Require all denied
    </LimitExcept>
  </Directory>
</IfModule>
EOF
echo '<?php phpinfo(); ?>' > $HOME/public_html/info.php

echo ""
echo "sudo vi /etc/apache2/mods-available/php$PHP_VER.conf"
echo "Edit this file and make following entries"

cat << EOF
<IfModule mod_userdir.c>
    <Directory /home/*/public_html>
        #php_admin_flag engine Off
        AllowOverride All
    </Directory>
    <Directory /home/*/public_html/*/cgi-bin>
        DirectoryIndex index.py
        Options +ExecCGI
        SetHandler cgi-script
        AddHandler cgi-script .py 
    </Directory>
    <Directory /home/*/public_html/*/wsgi-bin>
        DirectoryIndex index.wsgi    
        Options +ExecCGI
        SetHandler wsgi-script
        AddHandler wsgi-script .wsgi
    </Directory>
</IfModule>
EOF
echo ""

echo "Restart the server"

echo "sudo service apache2 restart"