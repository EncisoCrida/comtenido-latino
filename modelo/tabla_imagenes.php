<?php
function tabla_img($conexion, $opcion, $autor, $nombrePublicacion, $volumen, $reseña, $archivoRuta, $categoria,  $id_usuario, $tags, $id)
{
    $data = "";
    switch ($opcion) {
        case 1:
            $sql = "CALL RegistrarImagen(";
            $sql .= "'$autor', '$nombrePublicacion', '$reseña', '$archivoRuta', '$categoria', '$tags' ,'$id_usuario' );";
                $ejecutar = $conexion->prepare($sql);
                $ejecutar->execute();
                $consulta = "SELECT * FROM tb_imagenes ORDER BY id DESC LIMIT 1";
                $resultado = $conexion->prepare($consulta);
                $data = $resultado->fetchAll(PDO::FETCH_ASSOC);
            break;
        case 2:
            $consulta = "UPDATE   `tb_imagenes` SET `autor` = '$autor', `nombre` = '$nombrePublicacion', `resena` = '$reseña', `id_categoria` = '$categoria', `tags` = '$tags' WHERE (`id` = '$id');";
            $data = $consulta;
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();

            $consulta = "SELECT * FROM tb_imagenes WHERE id='$id' ";
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();
            $data = $resultado->fetchAll(PDO::FETCH_ASSOC);
            break;
        case 3:
            $consulta = "DELETE FROM tb_imagenes WHERE id='$id' ";
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();
            break;
        case 4:
            $consulta = "SELECT * FROM tb_imagenes WHERE id_usuario = '$id_usuario'";
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();
            $data = $resultado->fetchAll(PDO::FETCH_ASSOC);
            break;

        case 5:
            $consulta = "SELECT * FROM tb_imagenes WHERE id = '$id'";
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();
            $data = $resultado->fetchAll(PDO::FETCH_ASSOC);
            break;
    }
    return $data;
}

function buscarLibro($conexion, $nombre)
{
    $salida = "";
    $consulta = "select buscar_libro('$nombre')";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    $salida = $resultado->fetchAll(PDO::FETCH_ASSOC);
    return $salida[0]["buscar_libro('haker')"];
}
