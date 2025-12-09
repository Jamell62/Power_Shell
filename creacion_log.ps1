function New-FolderCreation {                     # Función que crea una carpeta si no existe
    [CmdletBinding()]
    param(                                        # Declaración de parámetros
        [Parameter(Mandatory = $true)]            # Parámetro obligatorio
        [string]$foldername                       # Nombre de la carpeta a crear
    )
    # Create absolute path for the folder relative to current location
    # Crea la ruta absoluta de la carpeta basándose en la ubicación actual
    $logpath = Join-Path -Path (Get-Location).Path -ChildPath $foldername

    if (-not (Test-Path -Path $logpath)) {        # Si la carpeta NO existe
        New-Item -Path $logpath -ItemType Directory -Force | Out-Null   # Crear carpeta
    }

    return $logpath                                # Devuelve la ruta completa de la carpeta
}

function Write-Log {                               # Función principal para crear logs o escribir mensajes
    [CmdletBinding()]
    param(
        # Create parameter set
        # Set de parámetros para crear archivos
        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [Alias('Names')]
        [object]$Name,                             # Puede ser un string o un array de nombres de archivo

        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]$Ext,                             # Extensión del archivo (ej: .log)

        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]$folder,                          # Carpeta donde se crean los archivos

        [Parameter(ParameterSetName = 'Create', Position = 0)]
        [switch]$Create,                          # Bandera para indicar modo "crear archivo(s)"

        # Message parameter set
        # Set de parámetros para escribir un mensaje en un archivo existente
        [Parameter(Mandatory = $true, ParameterSetName = 'Message')]
        [string]$message,                         # Mensaje a escribir dentro del archivo

        [Parameter(Mandatory = $true, ParameterSetName = 'Message')]
        [string]$path,                            # Ruta del archivo donde se escribirá el mensaje

        [Parameter(Mandatory = $false, ParameterSetName = 'Message')]
        [ValidateSet('Information','Warning','Error')]
        [string]$Severity = 'Information',        # Nivel de severidad del mensaje

        [Parameter(ParameterSetName = 'Message', Position = 0)]
        [switch]$MSG                              # Bandera para indicar modo "mensaje"
    )

    switch ($PsCmdlet.ParameterSetName) {          # Determina qué modo se está usando (Create o Message)

        "Create" {                                 # Modo para crear archivo(s)
            $created = @()                         # Lista donde se guardarán las rutas de archivos creados

            # Normalize $Name to an array
            # Normaliza el parámetro Name para que siempre se trate como array
            $namesArray = @()
            if ($null -ne $Name) {
                if ($Name -is [System.Array]) { $namesArray = $Name }
                else { $namesArray = @($Name) }
            }

            # Date + time formatting (safe for filenames)
            # Genera marcas de tiempo para agregar a los nombres de archivo
            $date1 = (Get-Date -Format "yyyy-MM-dd")
            $time  = (Get-Date -Format "HH-mm-ss")

            # Ensure folder exists and get absolute folder path
            # Asegura que la carpeta exista y obtiene la ruta completa
            $folderPath = New-FolderCreation -foldername $folder

            foreach ($n in $namesArray) {          # Recorre cada nombre dado
                # sanitize name to string
                # Convierte el nombre explícitamente a string
                $baseName = [string]$n

                # Build filename
                # Construye el nombre final del archivo
                $fileName = "${baseName}_${date1}_${time}.$Ext"

                # Full path for file
                # Ruta completa al archivo a crear
                $fullPath = Join-Path -Path $folderPath -ChildPath $fileName

                # Create the file (New-Item -Force will create or overwrite)
                # Crea el archivo físicamente en disco
                try {
                    New-Item -Path $fullPath -ItemType File -Force -ErrorAction Stop | Out-Null

                    $created += $fullPath           # Guarda la ruta del archivo en la lista
                }
                catch {
                    Write-Warning "Failed to create file '$fullPath' - $_"   # Mensaje si ocurre un error
                }
            }

            return $created                         # Devuelve las rutas de los archivos creados
        }

        "Message" {                                 # Modo para escribir mensajes en un archivo

            # Ensure directory for message file exists
            # Asegura que la carpeta del archivo existe (si no, la crea)
            $parent = Split-Path -Path $path -Parent
            if ($parent -and -not (Test-Path -Path $parent)) {
                New-Item -Path $parent -ItemType Directory -Force | Out-Null
            }

            $date = Get-Date                        # Fecha actual
            $concatmessage = "|$date| |$message| |$Severity|"  # Formato del mensaje registrado

            # Display message in color depending on severity
            # Muestra el mensaje en la consola con color según la severidad
            switch ($Severity) {
                "Information" { Write-Host $concatmessage -ForegroundColor Green }
                "Warning"     { Write-Host $concatmessage -ForegroundColor Yellow }
                "Error"       { Write-Host $concatmessage -ForegroundColor Red }
            }

            # Append message to the specified path
            # Escribe el mensaje dentro del archivo
            Add-Content -Path $path -Value $concatmessage -Force

            return $path                            # Devuelve la ruta donde se escribió el mensaje
        }

        default {
            throw "Unknown parameter set: $($PsCmdlet.ParameterSetName)"   # Error para sets desconocidos
        }
    }
}

# ---------- Example usage ----------
# Ejemplo de uso:
# Esto crea la carpeta 'logs' (si no existe) y un archivo con nombre:
# Name-Log_YYYY-MM-DD_HH-mm-ss.log
$logPaths = Write-Log -Name "Name-Log" -folder "logs" -Ext "log" -Create
