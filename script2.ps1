Add-Type -AssemblyName System.Windows.Forms      # Agrega la librería de Windows Forms para crear ventanas y controles gráficos.
Add-Type -AssemblyName System.Drawing            # Agrega la librería para manejar tamaños, posiciones, colores y gráficos.

# Create form
$form = New-Object System.Windows.Forms.Form     # Crea un nuevo formulario (ventana).
$form.Text = "Input Form"                        # Establece el título de la ventana.
$form.Size = New-Object System.Drawing.Size(500,250)  # Define el tamaño de la ventana (500 ancho, 250 alto).
$form.StartPosition = "CenterScreen"             # Hace que la ventana aparezca centrada en la pantalla.

############# Define labels
$textLabel1 = New-Object System.Windows.Forms.Label  # Crea la primera etiqueta.
$textLabel1.Text = "Input 1:"                        # Texto que mostrará la etiqueta.
$textLabel1.Left = 20                                # Posición horizontal.
$textLabel1.Top = 20                                 # Posición vertical.
$textLabel1.Width = 120                              # Ancho del área de texto.

$textLabel2 = New-Object System.Windows.Forms.Label
$textLabel2.Text = "Input 2:"
$textLabel2.Left = 20
$textLabel2.Top = 60
$textLabel2.Width = 120

$textLabel3 = New-Object System.Windows.Forms.Label
$textLabel3.Text = "Input 3:"
$textLabel3.Left = 20
$textLabel3.Top = 100
$textLabel3.Width = 120

############# Textbox 1
$textBox1 = New-Object System.Windows.Forms.TextBox  # Crea el primer cuadro de texto.
$textBox1.Left = 150                                 # Posición horizontal.
$textBox1.Top = 20                                   # Posición vertical.
$textBox1.Width = 200                                # Ancho del cuadro de texto.

############# Textbox 2
$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Left = 150
$textBox2.Top = 60
$textBox2.Width = 200

############# Textbox 3
$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Left = 150
$textBox3.Top = 100
$textBox3.Width = 200

############# Default values
$defaultValue = ""               # Valor por defecto vacío.
$textBox1.Text = $defaultValue   # Aplica el valor por defecto al cuadro 1.
$textBox2.Text = $defaultValue   # Aplica el valor por defecto al cuadro 2.
$textBox3.Text = $defaultValue   # Aplica el valor por defecto al cuadro 3.

############# OK Button
$button = New-Object System.Windows.Forms.Button  # Crea un botón.
$button.Left = 360                                # Posición horizontal.
$button.Top = 140                                  # Posición vertical.
$button.Width = 100                                # Ancho del botón.
$button.Text = "OK"                                # Texto que muestra el botón.

############# Button click event
$button.Add_Click({
    $form.Tag = @{                # Guarda los valores de los cuadros de texto en un "Tag" del formulario.
        Box1 = $textBox1.Text
        Box2 = $textBox2.Text
        Box3 = $textBox3.Text
    }
    $form.Close()                 # Cierra la ventana al hacer clic.
})

############# Add controls
$form.Controls.Add($button)       # Agrega el botón al formulario.
$form.Controls.Add($textLabel1)   # Agrega etiqueta 1.
$form.Controls.Add($textLabel2)   # Agrega etiqueta 2.
$form.Controls.Add($textLabel3)   # Agrega etiqueta 3.
$form.Controls.Add($textBox1)     # Agrega cuadro de texto 1.
$form.Controls.Add($textBox2)     # Agrega cuadro de texto 2.
$form.Controls.Add($textBox3)     # Agrega cuadro de texto 3.

############# Show dialog
$form.ShowDialog() | Out-Null     # Muestra la ventana gráfica y espera a que el usuario interactúe.

############# Return values
return $form.Tag.Box1, $form.Tag.Box2, $form.Tag.Box3  # Devuelve los valores ingresados en los 3 cuadros de texto.
