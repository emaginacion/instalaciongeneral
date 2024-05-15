# Utiliza la imagen base de Ubuntu
FROM ubuntu:20.04

# Evita las preguntas de configuración durante la instalación de paquetes
ARG DEBIAN_FRONTEND=noninteractive

# Actualiza la lista de paquetes e instala utilidades necesarias
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    unzip \
    git \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update && apt-get install -y \
    php7.3 \
    php7.3-mcrypt \
    php7.3-xml \
    php7.3-gd \
    php7.3-opcache \
    php7.3-mbstring \
    php7.3-mysql \
    php7.3-zip \
    php7.3-intl \
    php7.3-curl \
    unzip \
    apache2 \
    libapache2-mod-php7.3 \
    inotify-tools

# Descarga y descomprime ownCloud
RUN wget https://download.owncloud.com/server/stable/owncloud-10.4.1.zip \
    && unzip owncloud-10.4.1.zip \
    && mv owncloud /var/www/

# Copia la configuración de Apache para Laravel
COPY ./laravel.conf /etc/apache2/sites-available/

# Configura Apache para Laravel
RUN a2dissite 000-default.conf \
    && a2ensite laravel.conf \
    && a2enmod rewrite

# Clona el repositorio de gestión
RUN git clone https://github.com/emaginacion/gestorHonduras.git \
    && mkdir /var/www/ftp \
    && mv gestorHonduras /var/www/html/gestion

# Copia el archivo de servicio de monitorización
COPY ./monitor.service /etc/systemd/system/

# Descarga y descomprime el respaldo de datos de ownCloud
RUN wget http://18.216.185.203/files/owncloud_data_backup.zip \
    && unzip owncloud_data_backup.zip \
    && mv /var/www/owncloud/data /var/www/owncloud/data2 \
    && mv var/www/owncloud/data /var/www/owncloud/ \
    && chown -R www-data:www-data /var/www/owncloud \
    && chown -R www-data:www-data /var/www/owncloud/data/

# Expone el puerto 80 para el servicio web
EXPOSE 80

# Inicia Apache y el servicio de monitorización
CMD ["sh", "-c", "service apache2 start && systemctl start monitor.service && tail -f /dev/null"]
