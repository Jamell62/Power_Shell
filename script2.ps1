Add-Type -AssemblyName System.Windows.Forms #Agrega la librería de Windows Forms para crear ventanas y controles gráficos. 
Add-Type -AssemblyName System.Drawing #Agregar la libreria para manejar tamaños, posiciones, colores y gráficos

# Create form
$form = New-Object System.Windows.Forms.Form #Crear fotmulario
$form.Text = "Input Form" #Crear un nuevo objetivo tipo formulario
$form.Size = New-Object System.Drawing.Size(500,250) #Define el titulo de la ventana
$form.StartPosition = "CenterScreen" #Establece el tamaño de la ventana (ancho500, alto 250)

############# Define labels
$textLabel1 = New-Object System.Windows.Forms.Label #Definir etiquetas
$textLabel1.Text = "Input 1:" #Crear primera etiqueta
$textLabel1.Left = 20 #Texto que muestra la etiqueta 
$textLabel1.Top = 20 #Posicion horizontal
$textLabel1.Width = 120 #Posicion vertical

$textLabel2 = New-Object System.Windows.Forms.Label #
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
$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Left = 150
$textBox1.Top = 20
$textBox1.Width = 200

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
$defaultValue = ""
$textBox1.Text = $defaultValue
$textBox2.Text = $defaultValue
$textBox3.Text = $defaultValue

############# OK Button
$button = New-Object System.Windows.Forms.Button
$button.Left = 360
$button.Top = 140
$button.Width = 100
$button.Text = "OK"

############# Button click event
$button.Add_Click({
    $form.Tag = @{
        Box1 = $textBox1.Text
        Box2 = $textBox2.Text
        Box3 = $textBox3.Text
    }
    $form.Close()
})

############# Add controls
$form.Controls.Add($button)
$form.Controls.Add($textLabel1)
$form.Controls.Add($textLabel2)
$form.Controls.Add($textLabel3)
$form.Controls.Add($textBox1)
$form.Controls.Add($textBox2)
$form.Controls.Add($textBox3)

############# Show dialog
$form.ShowDialog() | Out-Null

############# Return values
return $form.Tag.Box1, $form.Tag.Box2, $form.Tag.Box3