<?php
 
    function registrar_usuario($conexion, $nombres, $apellidos, $usuario, $correo, $telefono, $clave, $pais, $estado, $municipio)
    {
        $salida = "";
       $sql = "call registrarUsuario('$nombres', '$apellidos','$usuario','$correo', '$telefono', '$clave', '$pais', '$estado', '$municipio')";

       $ejecutar = $conexion->prepare($sql);
       $ejecutar->execute(); 
       $salida = $ejecutar->fetchAll(PDO::FETCH_ASSOC);
       return $salida[0]['1'];
    }
?>