#!/bin/bash

# Bienvenida
echo "🚀 Iniciando la instalación de Jasper Server..."

# Descargar el instalador
echo "📥 Descargando el instalador..."
wget http://integradorpanama.org/jasperinstall.zip

# Instalar unzip si no está instalado
echo "🔍 Verificando si unzip está instalado..."
if ! command -v unzip &> /dev/null
then
    echo "⚙️ Instalando unzip..."
    sudo apt install unzip
fi

# Descomprimir el instalador
echo "📂 Descomprimiendo el instalador..."
unzip jasperinstall.zip

# Instalación de Chromium
echo "🌐 Instalando Chromium para la generación de reportes..."
sudo apt-get install chromium-browser

# Preparar el archivo .run para ejecución
echo "🔧 Configurando permisos del instalador..."
chmod 777 *.run

# Ejecutar el instalador
echo "🛠 Ejecutando el instalador de Jasper Server..."
sudo ./TIB_js-jrs-cp_8.0.0_linux_x86_64.run


# Iniciar el servicio de Jasper Server
echo "🔄 Deteniendo e iniciando el servicio de Jasper Server..."
sudo /opt/jasperreports-server-cp-8.0.0/ctlscript.sh stop
sudo /opt/jasperreports-server-cp-8.0.0/ctlscript.sh start

# Finalización
echo "✅ Jasper Server instalado correctamente."
echo "🌐 Accede a Jasper Server en: http://{server ip}:8080/jasperserver/login.html"
