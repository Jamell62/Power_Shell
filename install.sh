###################################
# 1. Prerrequisitos
###################################

# Actualizar lista de paquetes
sudo apt-get update

# Instalar dependencias necesarias
sudo apt-get install -y wget apt-transport-https software-properties-common

# Obtener versión de Ubuntu
. /etc/os-release
# VERSION_ID queda cargado automáticamente

# Descargar paquete del repositorio de Microsoft
wget https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb

# Registrar la clave GPG y el repositorio
sudo dpkg -i packages-microsoft-prod.deb

# Eliminar el archivo descargado
rm packages-microsoft-prod.deb

# Actualizar lista de paquetes (ya con el repo Microsoft agregado)
sudo apt-get update


###################################
# 2. Instalar PowerShell
###################################

sudo apt-get install -y powershell


###################################
# 3. Iniciar PowerShell
###################################

pwsh
