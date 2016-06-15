sudo yum install -y yum-plugin-replace


# assorted libraries and dependencies
sudo yum install -y mailcap libnghttp2 libltdl libxml2 libmcrypt


# MariaDB (MySQL)
sudo yum replace mariadb-libs --replace-with mariadb101u-config
sudo yum install -y mariadb101u-server mariadb101u


# PHP
sudo yum install -y php56u php56u-mysqlnd php56u-mcrypt php56u-mbstring 


# PHP composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#php -r "if (hash_file('SHA384', 'composer-setup.php') === '070854512ef404f16bac87071a6db9fd9721da1684cd4589b1196c3faf71b9a2682e2311b36a5079825e155ac7ce150d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

sudo mv composer.phar /usr/local/bin/composer


# Apache HTTP Server
#sudo yum replace httpd --replace-with httpd24u
sudo yum install -y httpd24u


# enable system resources
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start mariadb
sudo systemctl enable mariadb

