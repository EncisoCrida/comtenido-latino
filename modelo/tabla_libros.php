<?php

function tabla_libros($conexion, $opcion, $autor, $nombrePublicacion, $volumen, $caratulaRuta, $paginas, $reseña, $archivoRuta, $categoria,  $id_usuario, $tags, $id){
    $data = "";
    switch($opcion){
        case 1:		
            $sql = "call RegistrarLibro";
            $sql .= "('$autor', '$nombrePublicacion', '$volumen', '$caratulaRuta', '$paginas', '$reseña', '$archivoRuta', '$categoria', '$tags', '$id_usuario');";
            $ejecutar = $conexion->prepare($sql);
            $ejecutar->execute();
                $consulta = "SELECT * FROM tb_libros ORDER BY id DESC LIMIT 1";
                $resultado = $conexion->prepare($consulta);
                $data=$resultado->fetchAll(PDO::FETCH_ASSOC); 
    
            break;    
        case 2:        	
            $consulta = "UPDATE tb_libros SET `autor` = '$autor', `nombre` = '$nombrePublicacion', `volumen` = '$volumen', `paginas` = '$paginas', `resena` = '$reseña', `id_categoria` = '$categoria', `tags` = '$tags' WHERE (`id` = '$id');";		
            $data = $consulta;
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();        
            
            $consulta = "SELECT * FROM tb_libros WHERE id='$id' ";       
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();
            $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
            break;
        case 3:
            //elimino los likes de esta publicacion
            $consulta1 = "DELETE FROM tb_likes_libros WHERE id_publicacion = '$id'"; 
            $resultado1 = $conexion->prepare($consulta1);
            $resultado1->execute();        
            //elimino comentarios de esta publicacion
            $consulta2 = "DELETE FROM tb_dislikes_libros WHERE id_publicacion = '$id'"; 
            $resultado2 = $conexion->prepare($consulta2);
            $resultado2->execute();        
            //elimino comentarios de esta publicacion
            $consulta3 = "DELETE FROM tb_comentarios_libros WHERE id_publicacion = '$id'"; 
            $resultado3 = $conexion->prepare($consulta3);
            $resultado3->execute();        
            //elimino la publicacion
            $consulta4 = "DELETE FROM tb_libros WHERE id='$id' ";		
            $resultado4 = $conexion->prepare($consulta4);
            $resultado4->execute();                           
            break;
        case 4:    
            $consulta = "SELECT * FROM tb_libros WHERE id_usuario = '$id_usuario'";
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();        
            $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
            break;

        case 5:    
            $consulta = "SELECT * FROM tb_libros WHERE id = '$id'";
            $resultado = $conexion->prepare($consulta);
            $resultado->execute();        
            $data=$resultado->fetchAll(PDO::FETCH_ASSOC);
            break;
    }
    return $data;
}

function buscarLibro($conexion,$nombre)
{
    $salida = "";
    $consulta = "select buscar_libro('$nombre')";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();        
    $salida=$resultado->fetchAll(PDO::FETCH_ASSOC);
    return $salida[0]["buscar_libro('haker')"];
}


?>