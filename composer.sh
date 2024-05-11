# Cambia al directorio /tmp
echo "Cambiando al directorio /tmp"
cd /tmp

# Descarga el instalador de Composer y lo ejecuta
echo "Descargando e instalando Composer"
curl -sS https://getcomposer.org/installer | php

# Descarga la última versión estable de ownCloud
echo "Descargando ownCloud"
wget https://download.owncloud.com/server/stable/owncloud-10.4.1.zip

# Descomprime el archivo descargado de ownCloud
echo "Descomprimiendo ownCloud"
unzip ./owncloud-10.4.1.zip 

# Mueve el directorio de ownCloud al directorio web del servidor
echo "Moviendo ownCloud al directorio del servidor web"
sudo mv owncloud /var/www/

# Mueve composer.phar al directorio binario local para su uso global
echo "Instalando Composer globalmente"
sudo mv composer.phar /usr/local/bin/composer

# Añade el repositorio PPA de PHP de ondrej/php
echo "Añadiendo el repositorio de PHP"
sudo add-apt-repository ppa:ondrej/php

# Actualiza la lista de paquetes
echo "Actualizando la lista de paquetes"
sudo apt update
sudo apt-get update

# Instala versiones específicas de PHP y extensiones necesarias
echo "Instalando PHP y extensiones necesarias"
sudo apt-get install php7.3 php7.3-mcrypt php7.3-xml php7.3-gd php7.3-opcache php7.3-mbstring

# Instala MySQL extensiones para PHP
echo "Instalando extensiones de MySQL para PHP"
sudo apt-get install php-mysql
sudo apt-get install php7.3-mysql

# Instala otras extensiones PHP necesarias
echo "Instalando otras extensiones de PHP necesarias para OwnCloud"
sudo apt-get install php-zip php-intl php-curl
sudo apt-get install php7.3-zip php7.3-intl php7.3-curl

# Mueve la configuración de Apache para Laravel
echo "Configurando Apache para Laravel"
sudo mv ./laravel.conf /etc/apache2/sites-available/
sudo a2dissite 000-default.conf && sudo a2ensite laravel.conf && sudo a2enmod rewrite

# Verifica la instalación de extensiones de MySQL en PHP
echo "Verificando la instalación de MySQL en PHP"
php -m | grep mysql

# Crea un directorio para tu aplicación
echo "Creando directorio para la aplicación"
sudo mkdir /var/www/html/cch

# Cambia al directorio de la aplicación
echo "Cambiando al directorio de la aplicación"
cd /var/www/html/cch

# Clona el repositorio de backend de CCH
echo "Clonando el repositorio de CCH Backend"
sudo git clone https://github.com/emaginacion/CCHBackend.git

# Mueve el repositorio clonado al directorio API
echo "Moviendo el backend de CCH al directorio API"
sudo mv /var/www/html/cch/CCHBackend /var/www/html/cch/api

# Cambia al directorio API
echo "Cambiando al directorio API"
cd /var/www/html/cch/api

# Instala dependencias con Composer
echo "Instalando dependencias con Composer"
sudo composer install

# Reinicia apache
echo "Reiniciando Apache"
sudo service apache2 restart

