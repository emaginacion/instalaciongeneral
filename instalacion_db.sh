#!/bin/bash

# Actualizar los paquetes del sistema
echo "🔄 Actualizando los paquetes del sistema..."
sudo apt update

# Instala unzip
echo -e "\e[31m📂 Instalando unzip...\e[0m"
sudo apt-get install unzip

# Instalar MySQL Server
echo "🛠 Instalando MySQL Server..."
sudo apt install mysql-server

# Configurar el acceso remoto a MySQL (Opcional)

  echo "🔧 Configurando  MySQL..."
  sudo ufw allow 3306
  sudo sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

  sudo systemctl restart mysql
  echo "👌 configurado."

# Acceso a MySQL para configuraciones
echo "🔑 Accediendo a MySQL para configuraciones iniciales..."
sudo mysql -e "
CREATE USER 'oc_admin'@'%' IDENTIFIED WITH mysql_native_password BY 'integrac!0nHON';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'oc_admin'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'oc_admin'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"

# Configuraciones para ejecución de queries de Jasper
echo "📝 Configurando MySQL para JasperReports..."

# Crear base de datos y usuario para ownCloud
echo "🔧 Creando base de datos y usuario para ownCloud..."
sudo mysql -e "
CREATE DATABASE IF NOT EXISTS owncloud;
CREATE USER 'owncloud'@'%' IDENTIFIED WITH mysql_native_password BY 'integrac!0nHON';
GRANT ALL PRIVILEGES ON owncloud.* TO 'owncloud'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;integrac!0nHON
"

echo "✅ MySQL configurado correctamente. en el servidor de desarrollo. "

wget http://18.216.185.203/files/slq_backup_dbconsolidaddorcohorte2.zip

wget http://18.216.185.203/files/slq_backup_CP00MASTER.zip
wget http://18.216.185.203/files/slq_backup_CP00MASTER.zip


# Descargando archivos ZIP
echo "📥 Descargando archivos ZIP..."

wget http://18.216.185.203/files/slq_backup_CP00MASTER.zip -O slq_backup_CP00MASTER.zip
wget http://18.216.185.203/files/slq_backup_dbconsolidaddorcohorte2.zip -O slq_backup_dbconsolidaddorcohorte2.zip
wget http://18.216.185.203/files/sql_owncloud_cohorte.zip -O sql_owncloud_cohorte.zip

# Descomprimiendo archivos ZIP
echo "📂 Descomprimiendo archivos ZIP..."

unzip slq_backup_CP00MASTER.zip
unzip slq_backup_dbconsolidaddorcohorte2.zip
unzip sql_owncloud_cohorte.zip

# Creando bases de datos
echo "🗄️ Creando bases de datos..."
sudo mysql -e "CREATE DATABASE IF NOT EXISTS CP00MASTER;"
sudo mysql -e "CREATE DATABASE IF NOT EXISTS owncloud;"
sudo mysql -e "CREATE DATABASE IF NOT EXISTS dbconsolidadorcohorte2;"

# Ejecutando archivos SQL
echo "💾 Ejecutando archivos SQL..."
sudo mysql CP00MASTER < backup_CP00MASTER.sql
sudo mysql dbconsolidadorcohorte2 < backup_dbconsolidadorcohorte2.sql  
sudo mysql owncloud < owncloud.sql

echo "✅ Proceso completado exitosamente."
