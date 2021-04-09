<?php
/**modulo: controlador
cargo:  registra un nuevo usuario
autor:  Cridatian Enciso @Enciso_Crida */

//se llama al modelo, la conexion a la base de datos y funcion de registro
include("../modelo/registrar_usuario.php");
include("../modelo/conexionDB.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
//si esta variable cambia su valor el registro sera cancelado
$estado_registro = 0;
//se reciben los datos del nuevo usuario 
$nombres = $_POST['nombre'];
$apellidos = $_POST['apellido'];
$usuario = $_POST['usuario'];
$correo = $_POST['correo'];
$telefono = $_POST['telefono'];
$clave = $_POST['password'];
$clave = password_hash($clave, PASSWORD_DEFAULT);
$pais = $_POST['pais'];
$estado = $_POST['departamento'];
$municipio = $_POST['municipio'];

//llamado de funcion y parametrizacion

echo registrar_usuario($conexion, $nombres, $apellidos, $usuario, $correo, $telefono, $clave, $pais, $estado, $municipio);


?>