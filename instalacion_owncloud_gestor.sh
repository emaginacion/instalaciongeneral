# Añade el repositorio PPA de PHP de ondrej/php
echo -e "\e[32m📦 Añadiendo el repositorio de PHP...\e[0m"
sudo add-apt-repository ppa:ondrej/php

# Actualiza la lista de paquetes
echo -e "\e[34m🔄 Actualizando la lista de paquetes...\e[0m"
sudo apt update
sudo apt-get update

# Instala versiones específicas de PHP 7.3 y extensiones necesarias
echo -e "\e[31m🛠️ Instalando PHP 7.3 y extensiones necesarias...\e[0m"
sudo apt-get install php7.3 php7.3-mcrypt php7.3-xml php7.3-gd php7.3-opcache php7.3-mbstring

# Instala extensiones de MySQL específicamente para PHP 7.3
echo -e "\e[32m🗄️ Instalando extensiones de MySQL para PHP 7.3...\e[0m"
sudo apt-get install php7.3-mysql

# Instala otras extensiones PHP específicas para PHP 7.3
echo -e "\e[34m🔧 Instalando otras extensiones de PHP 7.3 necesarias para OwnCloud...\e[0m"
sudo apt-get install php7.3-zip php7.3-intl php7.3-curl

# Instala unzip
echo -e "\e[31m📂 Instalando unzip...\e[0m"
sudo apt-get install unzip


# Descarga la última versión estable de ownCloud
echo -e "\e[34m☁️ Descargando ownCloud...\e[0m"
wget https://download.owncloud.com/server/stable/owncloud-10.4.1.zip

# Descomprime el archivo descargado de ownCloud
echo -e "\e[31m🔓 Descomprimiendo ownCloud...\e[0m"
unzip ./owncloud-10.4.1.zip 

# Mueve el directorio de ownCloud al directorio web del servidor
echo -e "\e[32m🚚 Moviendo ownCloud al directorio del servidor web...\e[0m"
sudo mv owncloud /var/www/

# Mueve la configuración de Apache para Laravel
echo -e "\e[31m🔧 Configurando Apache para Laravel...\e[0m"
sudo cp ./laravel.conf /etc/apache2/sites-available/
sudo a2dissite 000-default.conf && sudo a2ensite laravel.conf && sudo a2enmod rewrite

# Verifica la instalación de extensiones de MySQL en PHP 7.3
echo -e "\e[32m🔍 Verificando la instalación de MySQL en PHP 7.3...\e[0m"
php -m | grep mysql


# Reinicia apache
echo -e "\e[32m🔄 Reiniciando Apache...\e[0m"
sudo service apache2 restart

sudo chown -R www-data:www-data /var/www/owncloud
# sudo mysql -u owncloud -p'integrac!0nHON' owncloud < owncloud.sql

# Este script clona un repositorio y configura un servicio para monitorizar cambios.

# Paso 1: Clona el repositorio de gestión para el backend
# Informa al usuario sobre la acción de clonado
echo -e "\e[31mClonando el repositorio de gestión para el backend...\e[0m"
sudo git clone https://github.com/emaginacion/gestorHonduras.git

# Verifica si el clonado fue exitoso y procede
if [ -d "./gestorHonduras" ]; then
    echo -e "\e[32mEl repositorio se ha clonado exitosamente.\e[0m"
else
    echo -e "\e[31mError: El clonado del repositorio ha fallado.\e[0m"
    exit 1
fi

# Paso 2: Mueve el repositorio clonado al directorio público
# Informa al usuario sobre el movimiento del repositorio
echo -e "\e[32mMoviendo el repositorio al directorio público...\e[0m"
sudo mkdir /var/www/ftp
sudo mv ./gestorHonduras /var/www/html/gestion

# Verifica si el movimiento fue exitoso y procede
if [ -d "/var/www/gestion" ]; then
    echo -e "\e[32mEl repositorio se ha movido exitosamente al directorio público.\e[0m"
else
    echo -e "\e[31mError: El movimiento del repositorio ha fallado.\e[0m"
    exit 1
fi

# Paso 3: Instala herramientas de monitorización
# Informa al usuario sobre la instalación de las herramientas necesarias
echo -e "\e[34mInstalando herramientas de monitorización...\e[0m"
sudo apt-get -y install inotify-tools

# Paso 4: Configura el servicio de monitorización
# Copia el archivo de servicio al directorio de systemd para su gestión
echo -e "\e[32mConfigurando el servicio de monitorización...\e[0m"
sudo cp /var/www/html/gestion/monitor.service /etc/systemd/system/

# Informa al usuario que la configuración ha sido completada
echo -e "\e[32mEl servicio de monitorización está configurado y listo para ser habilitado.\e[0m"
sudo systemctl start monitor.service