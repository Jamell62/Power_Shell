###################################
# Prerequisites                   # Prerrequisitos
###################################

# Update the list of packages
sudo apt-get update               # Actualiza la lista de paquetes disponibles en los repositorios

# Install pre-requisite packages.
sudo apt-get install -y wget apt-transport-https software-properties-common  
# Instala paquetes necesarios: wget (descargas), apt-transport-https (repos HTTPS), software-properties-common (gestión de repos)

# Get the version of Ubuntu
source /etc/os-release            # Carga variables del sistema, incluyendo VERSION_ID (versión de Ubuntu)

# Download the Microsoft repository keys
wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb 
# Descarga silenciosamente (.deb) las claves y configuraciones del repositorio oficial de Microsoft para tu versión de Ubuntu

# Register the Microsoft repository keys
sudo dpkg -i packages-microsoft-prod.deb  
# Instala el paquete que registra la clave GPG y el repositorio de Microsoft en tu sistema

# Delete the Microsoft repository keys file
rm packages-microsoft-prod.deb    # Elimina el archivo .deb descargado, ya no es necesario

# Update the list of packages after we added packages.microsoft.com
sudo apt-get update               # Actualiza nuevamente la lista de paquetes, ahora incluyendo el repositorio de Microsoft


###################################
# Install PowerShell
###################################
sudo apt-get install -y powershell    # Instala PowerShell desde el repositorio de Microsoft

# Start PowerShell
pwsh                                   # Inicia PowerShell (su ejecutable es 'pwsh')
