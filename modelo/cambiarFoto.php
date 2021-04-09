<?php

function cambiarImgPerfil($conexion, $uploadedFile, $id)
{
$salida = "";
$uploadedFile = "fotoPerfil/".$uploadedFile;
$consulta = "UPDATE `tb_usuarios` SET `foto_perfil` = '$uploadedFile' WHERE `id_usuario` = '$id'    ";	
$resultado = $conexion->prepare($consulta);
$resultado->execute();
if ($resultado) {
    $salida = 1;
}else{
    $salida = 2;
}
return $salida;
}