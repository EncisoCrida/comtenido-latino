<?php
if(! isset($_SESSION) ) session_start();
//se incluye la conexion a la base de datos
//se incluye el archivo que contiene las funciones que guardan y validan el reporte en la base de datos
include("../modelo/cambiarFoto.php");
include("../modelo/conexionDB.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
$id_usuario = $_SESSION['userLogin']['id_usuario'];

if(!empty($_FILES['imgNueva']['name'])){
    $uploadedFile = '';
    if(!empty($_FILES["imgNueva"]["type"])){
        $fileName = time().'_'.$_FILES['imgNueva']['name'];
        $valid_extensions = array("jpeg", "jpg", "png");
        $temporary = explode(".", $_FILES["imgNueva"]["name"]);
        $file_extension = end($temporary);
        if((($_FILES["imgNueva"]["type"] == "image/png") || ($_FILES["imgNueva"]["type"] == "image/jpg") || ($_FILES["imgNueva"]["type"] == "image/jpeg")) && in_array($file_extension, $valid_extensions)){
            $sourcePath = $_FILES['imgNueva']['tmp_name'];
            $targetPath = "../fotoPerfil/".$fileName;
            if(move_uploaded_file($sourcePath,$targetPath)){
                $uploadedFile = $fileName;
                echo cambiarImgPerfil($conexion, $uploadedFile, $id_usuario); 
            }
        }
    }
    
}
