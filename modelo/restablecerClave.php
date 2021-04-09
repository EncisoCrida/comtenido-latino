<?php
function restablecerClave($conexion, $correo, $clave)
{
    $salida = "";
    $sql = "CALL restablecerClave('$correo','$clave')";
    $ejecutar = $conexion->prepare($sql);
    $ejecutar->execute(); 
    $salida = $ejecutar->fetchAll(PDO::FETCH_ASSOC);
    return $salida[0]["@resultado"];
    
}

function getUserName($conexion, $correo)
{
    $salida = "";
    $sql = "SELECT * FROM tb_usuarios WHERE correo='$correo'";
    $ejecutar = mysqli_query($conexion, $sql);
    $row_usuario = mysqli_fetch_assoc($ejecutar);
    $salida = $row_usuario['nombres']." ".$row_usuario['apellidos'];
    return $salida;

}

?>