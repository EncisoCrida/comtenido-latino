<?php
/**
 * modulo: controlador
 * funcion: trae la informacion de usuario del modelo para mostrarla en el menu de usuario
 */
// iniciamos la variable de sesion 
if (!isset($_SESSION)) session_start();
//llamado al modelo y conexion a base de datos
include("../modelo/conexionDB.php");
include("../modelo/info_user.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
//traigo el id del usuario que esta logeado 
$id_usuario = $_SESSION['userLogin']['id_usuario'];
//guardo en la variable data el resultado del modelo
$data = info_user($conexion, $id_usuario);
//envio el array final el formato json a AJAX
print json_encode($data, JSON_UNESCAPED_UNICODE);
?>