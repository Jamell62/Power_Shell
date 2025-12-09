function Start-ProgressBar {                      # Función que muestra una barra de progreso en PowerShell
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]            # Parámetro obligatorio
        $Title,                                   # Título que se mostrará en la barra de progreso

        [Parameter(Mandatory = $true)]
        [int]$Timer                               # Cantidad de segundos que durará la barra de progreso
    )

    for ($i = 1; $i -le $Timer; $i++) {           # Bucle desde 1 hasta el valor del Timer
        Start-Sleep -Seconds 1                    # Espera 1 segundo (pausa)
        $percentComplete = ($i / $Timer) * 100    # Calcula el porcentaje completado
        
        Write-Progress `                          # Muestra la barra de progreso en la consola
            -Activity $Title `                    # Texto principal de la barra
            -Status "$i seconds elapsed" `        # Texto mostrando los segundos transcurridos
            -PercentComplete $percentComplete      # Porcentaje de avance para la barra
    }
}

# Llamar a la función
# Esto inicia una barra de progreso llamada "Test Timer" que dura 30 segundos.
Start-ProgressBar -Title "Test Timer" -Timer 30
