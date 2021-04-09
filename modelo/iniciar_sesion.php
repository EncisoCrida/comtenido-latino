<?php

function buscarUsuario($conexion, $correo)
{
    $salida='';
    $sql = "SELECT  buscarUsuario('$correo') as resultado";
     $ejecutar = $conexion->prepare($sql);
    $ejecutar->execute(); 
    $salida=$ejecutar->fetchAll(PDO::FETCH_ASSOC);

    return $salida[0]['resultado'];
}

function verificarClave($conexion, $correo, $clave)
{
    $salida = "";

    $sql = "SELECT buscarClave('$correo') as resultado";
    $ejecutar = $conexion->prepare($sql);
    $ejecutar->execute(); 
    $claveRe = $ejecutar->fetchAll(PDO::FETCH_ASSOC);
    $claveDB = $claveRe[0]['resultado'];
    
    if(password_verify($clave, $claveDB))
    {
        $salida = 1;
    }else{
        $salida = 0;
    }
    return $salida;
}

function getUser($conexion, $correo)
{
    $salida = "";
    $sql = "SELECT * FROM tb_usuarios WHERE correo='$correo'";
    $ejecutar = $conexion->prepare($sql);
    $ejecutar->execute(); 
    $row_usuario = $ejecutar->fetchAll(PDO::FETCH_ASSOC);
    $salida = $row_usuario[0]['usuario'];
    return $salida;

}

function getUserlogin($conexion, $correo)
{
    $salida = "";
    $sql = "SELECT * FROM tb_usuarios WHERE correo='$correo'";
    $ejecutar = $conexion->prepare($sql);
    $ejecutar->execute(); 
    $row_usuario = $ejecutar->fetchAll(PDO::FETCH_ASSOC);
    $salida = $row_usuario[0];
    return $salida;

}
