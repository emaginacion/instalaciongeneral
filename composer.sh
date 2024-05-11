cd /tmp
curl -sS https://getcomposer.org/installer | php
wget https://download.owncloud.com/server/stable/owncloud-10.4.1.zip
unzip ./owncloud-10.4.1.zip 
sudo mv owncloud /var/www/ 
sudo mv composer.phar /usr/local/bin/composer
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt-get update && sudo apt-get install php7.3 php7.3-mcrypt php7.3-xml php7.3-gd php7.3-opcache php7.3-mbstring
sudo apt-get install php-mysql
sudo apt-get install php7.3-mysql
sudo apt-get install php-zip php-intl php-curl
sudo apt-get install php7.3-zip php7.3-intl php7.3-curl
sudo mv ./laravel.conf /etc/apache2/sites-available/
sudo a2dissite 000-default.conf && sudo a2ensite laravel.conf && sudo a2enmod rewrite
php -m | grep mysql
sudo mkdir /var/www/html/cch
cd /var/www/html/cch
sudo git clone https://github.com/emaginacion/CCHBackend.git
sudo mv /var/www/html/cch/CCHBackend /var/www/html/cch/api
cd /var/www/html/cch/api
sudo composer install

