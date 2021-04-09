<?php
// iniciamos la variable de sesion 
if (!isset($_SESSION)) session_start();
//llamo al modelo para incluir las peticiones a la base de datos y verificaciones
include("../modelo/iniciar_sesion.php");
//se llama la conexion a la base de datos
include("../modelo/conexionDB.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
//se recibe el correo y clave enviados desde el formulario
$correo = $_POST['correo'];
$clave = $_POST['clave'];

//se inician las verificaciones y llamados de funciones y parametrisacion 
//primero verificamos que exista el usuario
if (buscarUsuario($conexion, $correo) == 1) 
{
    //si el usuario existe se verifica la clave
    if (verificarClave($conexion, $correo, $clave) == 1) {
        //si las claves son iguales se logea el usuario
       $_SESSION['usuario'] = getUser($conexion, $correo);
       $_SESSION['userLogin'] = getUserLogin($conexion, $correo);
        $tipoUsuario = $_SESSION['userLogin'];
        if ($tipoUsuario['id_tipo_usuario'] == 3) {
            /* header("location:controlador.php?sesion=30"); */
            echo "eres un admin";
        } else {
            header("location:controlador.php?sesion=2");
        }
        
    } else {
        echo "la clave es incorrecta";
    }
} else {
    echo "no existe el usuario";
}



?>