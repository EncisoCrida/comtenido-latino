<?php
/**
 * madulo: controlador
 * funcion: listar los libros que ha registrado el usuario logeado
 * autor:  Cristian Encsio @Enciso_Crida
 */
// iniciamos la variable de sesion 
if (!isset($_SESSION)) session_start();
//llamado al modelo y conexion a base de datos
include("../modelo/conexionDB.php");
include("../modelo/tabla_imagenes.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
//traigo el id del usuario que esta logeado 
$id_usuario = $_SESSION['userLogin']['id_usuario'];
//recibo variablles enviadas desde ajax
$archivoRuta = '';
$img = '';
$autor = (isset($_POST['autor_img'])) ? $_POST['autor_img'] : '';
$nombrePublicacion = (isset($_POST['nombre_img'])) ? $_POST['nombre_img'] : '';
$volumen = (isset($_POST['volumen_img'])) ? $_POST['volumen_img'] : '';
$reseña = (isset($_POST['reseña_img'])) ? $_POST['reseña_img'] : '';
//validacion de imagen de caratula para el libro
if(!empty($_FILES['img']['name'])){
    if(!empty($_FILES["img"]["type"])){
        $fileName = time().'_'.$_FILES['img']['name'];
        $valid_extensions = array("jpeg", "jpg", "png");
        $temporary = explode(".", $_FILES["img"]["name"]);
        $file_extension = end($temporary);
        if((($_FILES["img"]["type"] == "image/png") || ($_FILES["img"]["type"] == "image/jpg") || ($_FILES["img"]["type"] == "image/jpeg")) && in_array($file_extension, $valid_extensions)){
            $sourcePath = $_FILES['img']['tmp_name'];
            $targetPath = "../archivos_Publicaciones/imagenes/".$fileName;
            if(move_uploaded_file($sourcePath,$targetPath)){
                $img = $fileName;
            }
        }
    }
    
}



$categoria = (isset($_POST['categoria_img'])) ? $_POST['categoria_img'] : '';
$tags = (isset($_POST['tags_img'])) ? $_POST['tags_img'] : '';
$id = (isset($_POST['id'])) ? $_POST['id'] : '';
$opcion = (isset($_POST['opcion'])) ? $_POST['opcion'] : '';


    $data =   tabla_img($conexion, $opcion, $autor, $nombrePublicacion, $volumen, $reseña, $img, $categoria,  $id_usuario, $tags, $id);
    print json_encode($data, JSON_UNESCAPED_UNICODE);//envio el array final el formato json a AJAX
?>