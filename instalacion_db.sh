#!/bin/bash

# Actualizar los paquetes del sistema
echo "🔄 Actualizando los paquetes del sistema..."
sudo apt update

# Instalar MySQL Server
echo "🛠 Instalando MySQL Server..."
sudo apt install mysql-server

# Configurar el acceso remoto a MySQL (Opcional)
read -p "¿Deseas configurar el acceso remoto a MySQL? (s/n): " config_remote
if [[ "$config_remote" == "s" ]]; then
  echo "🔧 Configurando acceso remoto a MySQL..."
  sudo ufw allow 3306
  sudo sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
  sudo systemctl restart mysql
  echo "👌 Acceso remoto configurado."
fi

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
CREATE USER 'owncloud'@'localhost' IDENTIFIED WITH mysql_native_password BY 'integrac!0nHON';
GRANT ALL PRIVILEGES ON owncloud.* TO 'owncloud'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
"

echo "✅ MySQL configurado correctamente."
