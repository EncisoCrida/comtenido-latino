<?php

function editar_perfil($conexion, $id_usuario, $nombres, $apellidos, $usuario, $correo, $telefono){
    $salida = "";
    $sql = "UPDATE `tb_usuarios` SET `nombres` = '$nombres', `apellidos` = '$apellidos', `usuario` = '$usuario', `correo` = '$correo', `telefono` = '$telefono' WHERE (`id_usuario` = '$id_usuario');";
    $resultado = $conexion->prepare($sql);
    $resultado->execute();        
    if($resultado)
    {
        $salida = 1;
    }else{
        $salida = 2;
    }
    return $salida;
}



?>