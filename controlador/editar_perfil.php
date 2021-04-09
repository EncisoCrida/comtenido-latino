<?php
/**
 * modulo: controlador
 * funcion: se encarga de editar el perfel de usuario
 */
// iniciamos la variable de sesion 
if (!isset($_SESSION)) session_start();
//llamado al modelo y conexion a base de datos
include("../modelo/conexionDB.php");
include("../modelo/editar_perfil.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
//traigo el id del usuario que esta logeado 
$id_usuario = $_SESSION['userLogin']['id_usuario'];
//recibo parametros
$nombres = (isset($_POST['nombres'])) ? $_POST['nombres'] : '';
$apellidos = (isset($_POST['apellidos'])) ? $_POST['apellidos'] : '';
$usuario = (isset($_POST['usuario'])) ? $_POST['usuario'] : '';
$correo = (isset($_POST['correo'])) ? $_POST['correo'] : '';
$telefono = (isset($_POST['telefono'])) ? $_POST['telefono'] : '';

//llamo la funcion que se encarga de hacer la peticion a la base de datos y envio el resultado a ajax
echo editar_perfil($conexion, $id_usuario, $nombres, $apellidos, $usuario, $correo, $telefono);





?>