<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '../PHPMailer/src/Exception.php';
require '../PHPMailer/src/PHPMailer.php';
require '../PHPMailer/src/SMTP.php';
include("../modelo/conexionDB.php");
include("../modelo/restablecerClave.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
$correo = $_POST['correo'];

$clave1 = $_POST['clave'];
$clave = $_POST['clave'];
$clave = password_hash($clave, PASSWORD_DEFAULT);
$name = "crida";
if(restablecerClave($conexion, $correo, $clave) == 1)
{

$mail = new PHPMailer(true);

try {
    $mail->SMTPOptions = array(
		'ssl' => array(
		'verify_peer' => false,
		'verify_peer_name' => false,
		'allow_self_signed' => true
		)
	);           
    $mail->isSMTP();                                          
    $mail->Host       = 'smtp.gmail.com';                    
    $mail->SMTPAuth   = true;                                   
    $mail->Username   = 'contenidolatino@gmail.com';                     
    $mail->Password   = 'cdegyadz1209';                               
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;        
    $mail->Port       = 587;                                    


    $mail->setFrom('contenidolatino@gmail.com', 'Contenido Latino');
    $mail->addAddress($correo, $name);     



    $mail->isHTML(true);                                
    $mail->Subject = 'Recuperar clave';
    $mail->Body    = 'su clave fue restablecida<br> su nueva clave:<b>'.$clave1.'</b><br>
    esta es una clave generada para cambiarla inicie sesion con su correo y la clave generada<br>
    ingrese a configuracionde de perfil y cambie la clave a una personalizada o puede seguir usando<br>
    la clave generada esto no ocacionara ningun problema
    ';

    $mail->send();
    echo 1;
} catch (Exception $e) {
    echo "error perro: {$mail->ErrorInfo}";
}
}else{
    echo "no se encontro";
}

?>
