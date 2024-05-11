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
sudo mv ./gestorHonduras /var/www/gestion

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
sudo cp /var/www/gestion/monitor.service /etc/systemd/system/

# Informa al usuario que la configuración ha sido completada
echo -e "\e[32mEl servicio de monitorización está configurado y listo para ser habilitado.\e[0m"
