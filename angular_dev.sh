cd /var/www/
sudo git clone https://github.com/emaginacion/ConsolidadorCohorteHonduras.git
cd /var/www/ConsolidadorCohorteHonduras

sudo apt update
sudo apt upgrade
sudo apt install curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm --version
nvm install 12
nvm use 12
npm install -g @angular/cli@9.0.0     

sudo chown -R $(whoami) /var/www/ConsolidadorCohorteHonduras/dist/operapp
sudo chmod -R u+w /var/www/ConsolidadorCohorteHonduras/dist/operapp

npm install
ln -s /var/www/ConsolidadorCohorteHonduras/
sudo mv /var/www/html/cch/api /var/www/api
sudo chown -R www-data:www-data /var/www/api/public
sudo chmod -R 755 /var/www/api/public
sudo chown -R www-data:www-data /var/www/api/storage

echo "👌 Angular configurado correctamente. en el servidor de desarrollo. "