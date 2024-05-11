cd /tmp
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
cd /var/www/html
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt-get update && sudo apt-get install php7.3 php7.3-mcrypt php7.3-xml php7.3-gd php7.3-opcache php7.3-mbstring
sudo apt-get install php-mysql
sudo apt-get install php7.3-mysql
