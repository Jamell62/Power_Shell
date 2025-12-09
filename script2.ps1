Add-Type -AssemblyName System.Windows.Forms      # Agrega la librería Windows Forms para crear ventanas y controles gráficos.
Add-Type -AssemblyName System.Drawing            # Agrega la librería para manejar tamaños, colores, gráficos y posiciones.

# Create form
$form = New-Object System.Windows.Forms.Form     # Crea un nuevo formulario (ventana gráfica).
$form.Text = "Input Form"                        # Establece el título que aparecerá en la barra superior de la ventana.
$form.Size = New-Object System.Drawing.Size(500,250)  # Define el tamaño de la ventana: 500 px de ancho y 250 px de alto.
$form.StartPosition = "CenterScreen"             # Hace que la ventana se abra centrada en la pantalla.

############# Define labels
$textLabel1 = New-Object System.Windows.Forms.Label  # Crea la primera etiqueta (texto estático).
$textLabel1.Text = "Input 1:"                        # Texto que mostrará la etiqueta.
$textLabel1.Left = 20                                # Posición horizontal en la ventana.
$textLabel1.Top = 20                                 # Posición vertical en la ventana.
$textLabel1.Width = 120                              # Ancho asignado para mostrar el texto.

$textLabel2 = New-Object System.Windows.Forms.Label  # Crea la segunda etiqueta.
$textLabel2.Text = "Input 2:"                        # Texto de la segunda etiqueta.
$textLabel2.Left = 20                                # Posición horizontal.
$textLabel2.Top = 60                                 # Posición vertical.
$textLabel2.Width = 120                              # Ancho del texto.

$textLabel3 = New-Object System.Windows.Forms.Label  # Crea la tercera etiqueta.
$textLabel3.Text = "Input 3:"                        # Texto de la tercera etiqueta.
$textLabel3.Left = 20                                # Posición horizontal.
$textLabel3.Top = 100                                # Posición vertical.
$textLabel3.Width = 120                              # Ancho del texto.

############# Textbox 1
$textBox1 = New-Object System.Windows.Forms.TextBox  # Crea el primer cuadro de entrada.
$textBox1.Left = 150                                 # Posición horizontal.
$textBox1.Top = 20                                   # Posición vertical.
$textBox1.Width = 200                                # Ancho del cuadro de texto.

############# Textbox 2
$textBox2 = New-Object System.Windows.Forms.TextBox  # Segundo cuadro de entrada.
$textBox2.Left = 150                                 # Posición horizontal.
$textBox2.Top = 60                                   # Posición vertical.
$textBox2.Width = 200                                # Ancho del cuadro.

############# Textbox 3
$textBox3 = New-Object System.Windows.Forms.TextBox  # Tercer cuadro de entrada.
$textBox3.Left = 150                                 # Posición horizontal.
$textBox3.Top = 100                                  # Posición vertical.
$textBox3.Width = 200                                # Ancho del cuadro.

############# Default values
$defaultValue = ""               # Valor por defecto vacío.
$textBox1.Text = $defaultValue   # Asigna el valor por defecto al cuadro 1.
$textBox2.Text = $defaultValue   # Asigna el valor por defecto al cuadro 2.
$textBox3.Text = $defaultValue   # Asigna el valor por defecto al cuadro 3.

############# OK Button
$button = New-Object System.Windows.Forms.Button  # Crea un botón.
$button.Left = 360                                # Posición horizontal dentro del formulario.
$button.Top = 140                                  # Posición vertical.
$button.Width = 100                                # Ancho del botón.
$button.Text = "OK"                                # Texto que aparece en el botón.

############# Button click event
$button.Add_Click({
    $form.Tag = @{                # Guarda los valores ingresados en una estructura tipo “diccionario”.
        Box1 = $textBox1.Text     # Guarda el texto del cuadro 1.
        Box2 = $textBox2.Text     # Guarda el texto del cuadro 2.
        Box3 = $textBox3.Text     # Guarda el texto del cuadro 3.
    }
    $form.Close()                 # Cierra la ventana cuando se presiona el botón.
})

############# Add controls
$form.Controls.Add($button)       # Agrega el botón al formulario.
$form.Controls.Add($textLabel1)   # Agrega la etiqueta 1.
$form.Controls.Add($textLabel2)   # Agrega la etiqueta 2.
$form.Controls.Add($textLabel3)   # Agrega la etiqueta 3.
$form.Controls.Add($textBox1)     # Agrega el cuadro de texto 1.
$form.Controls.Add($textBox2)     # Agrega el cuadro de texto 2.
$form.Controls.Add($textBox3)     # Agrega el cuadro de texto 3.

############# Show dialog
$form.ShowDialog() | Out-Null     # Muestra la ventana en pantalla y espera a que el usuario interactúe.

############# Return values
return $form.Tag.Box1, $form.Tag.Box2, $form.Tag.Box3  # Devuelve los textos escritos por el usuario.
