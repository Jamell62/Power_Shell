###################################
# Prerequisites

# Update the list of packages
sudo apt-get update #Actualizar la lista

# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common #instalar los paquetes necesarios

# Get the version of Ubuntu
source /etc/os-release #obtenener la versión de ubuntu

# Download the Microsoft repository keys
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb #descargar las claves del repositorio de Microsoft

# Register the Microsoft repository keys
sudo dpkg -i packages-microsoft-prod.deb #registrar las claves del repositorio

# Delete the Microsoft repository keys file
rm packages-microsoft-prod.deb #Eliminar el archivo de llaves descargado

# Update the list of packages after we added packages.microsoft.com
sudo apt-get update # Actualizar la lista de paquetes despes de agregar el repositorio 

###################################
# Install PowerShell
sudo apt-get install -y powershell #Instalar PowerShell

# Start PowerShell
pwsh #Iniciar PowerShell