<?php
function info_user($conexion, $id){
    $salida ='';
    $sql = "SELECT * FROM tb_usuarios where id_usuario = '$id'";
    $resultado = $conexion->prepare($sql);
    $resultado->execute();        
    $salida = $resultado->fetchAll(PDO::FETCH_ASSOC);
    return $salida;
}
?>