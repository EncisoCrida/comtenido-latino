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
include("../modelo/tabla_libros.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
//traigo el id del usuario que esta logeado 
$id_usuario = $_SESSION['userLogin']['id_usuario'];
//recibo variablles enviadas desde ajax
$archivoRuta = '';
$caratulaRuta = '';
$autor = (isset($_POST['autor'])) ? $_POST['autor'] : '';
$nombrePublicacion = (isset($_POST['nombre'])) ? $_POST['nombre'] : '';
$volumen = (isset($_POST['volumen'])) ? $_POST['volumen'] : '';
//validacion de imagen de caratula para el libro
if(!empty($_FILES['caratula']['name'])){
    if(!empty($_FILES["caratula"]["type"])){
        $fileName = time().'_'.$_FILES['caratula']['name'];
        $valid_extensions = array("jpeg", "jpg", "png");
        $temporary = explode(".", $_FILES["caratula"]["name"]);
        $file_extension = end($temporary);
        if((($_FILES["caratula"]["type"] == "image/png") || ($_FILES["caratula"]["type"] == "image/jpg") || ($_FILES["caratula"]["type"] == "image/jpeg")) && in_array($file_extension, $valid_extensions)){
            $sourcePath = $_FILES['caratula']['tmp_name'];
            $targetPath = "../archivos_Publicaciones/libros/caratulas/".$fileName;
            if(move_uploaded_file($sourcePath,$targetPath)){
                $caratulaRuta = $fileName;
            }
        }
    }
    
}

$paginas = (isset($_POST['paginas'])) ? $_POST['paginas'] : '';
$reseña = (isset($_POST['reseña'])) ? $_POST['reseña'] : '';
//validacion para archivo del libro
if(!empty($_FILES['libro']['name'])){
    if(!empty($_FILES["libro"]["type"])){
        $fileName = time().'_'.$_FILES['libro']['name'];
        $valid_extensions = array("pdf");
        $temporary = explode(".", $_FILES["libro"]["name"]);
        $file_extension = end($temporary);
        if((($_FILES["libro"]["type"] == "application/pdf") ) && in_array($file_extension, $valid_extensions)){
            $sourcePath = $_FILES['libro']['tmp_name'];
            $targetPath = "../archivos_Publicaciones/libros/".$fileName;
            if(move_uploaded_file($sourcePath,$targetPath)){
                $archivoRuta = $fileName;
            }
        }
    }
    
}

$categoria = (isset($_POST['categoria'])) ? $_POST['categoria'] : '';
$tags = (isset($_POST['tags'])) ? $_POST['tags'] : '';
$id = (isset($_POST['id'])) ? $_POST['id'] : '';
$opcion = (isset($_POST['opcion'])) ? $_POST['opcion'] : '';


    $data =  tabla_libros($conexion, $opcion, $autor, $nombrePublicacion, $volumen, $caratulaRuta, $paginas, $reseña, $archivoRuta, $categoria,  $id_usuario, $tags, $id);
    print json_encode($data, JSON_UNESCAPED_UNICODE);//envio el array final el formato json a AJAX
?>