yum install -y yum-plugin-replace


# assorted libraries and dependencies
yum install -y mailcap libnghttp2 libltdl libxml2 libmcrypt


# MariaDB (MySQL)
yum replace mariadb-libs --replace-with mariadb101u-config
yum install -y mariadb101u-server mariadb101u


# PHP
yum install -y php56u php56u-mysqlnd php56u-mcrypt php56u-mbstring 


# PHP composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#php -r "if (hash_file('SHA384', 'composer-setup.php') === '070854512ef404f16bac87071a6db9fd9721da1684cd4589b1196c3faf71b9a2682e2311b36a5079825e155ac7ce150d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

mv composer.phar /usr/local/bin/composer


# NGINX
yum install -y nginx php56u-fpm-nginx nginx-filesystem 


# enable system resources
systemctl start nginx
systemctl enable nginx
systemctl start mariadb
systemctl enable mariadb
