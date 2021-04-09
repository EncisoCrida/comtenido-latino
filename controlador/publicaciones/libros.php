<?php
/**
 * madulo: controlador
 * funcion: listar todos los libros para mostrarlo en el modulo de libros 
 * autor:  Cristian Encsio @Enciso_Crida
 */
// iniciamos la variable de sesion 
if (!isset($_SESSION)) session_start();
//llamado al modelo y conexion a base de datos
include("../modelo/conexionDB.php");
include("../modelo/publicaciones/libros.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
//llamado de funcion
$libros_array = ver_libros($conexion);
// id usario por variable de sesion

//buscamos le like




$array_data =  json_encode($libros_array, JSON_UNESCAPED_UNICODE);
?>