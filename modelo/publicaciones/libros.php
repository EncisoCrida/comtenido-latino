<?php


function ver_libros($conexion)
{
    $libros = "";
    $consulta = "select 
    t1.id, t1.autor, t1.nombre, t1.volumen, t1.caratula, t1.paginas, t1.resena,
    t1.archivo, t2.categoria, t1.id_usuario, t1.tags, Date_format(t1.fecha_registro,'%Y/%M/%d') as fecha_registro,
    t1.likes, t1.dislikes, t1.comentarios
    from tb_libros as t1, tb_categorias as t2
    where t1.id_categoria = t2.id_categoria;";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    while($libros = $resultado->fetch(PDO::FETCH_ASSOC))
    {
        $data_libros[] = $libros; 
    }
    

    return $data_libros;

}

function buscar_like($conexion, $id_libro, $id_usuario)
{
    $contador = "";
    $consulta = "SELECT id_like from tb_likes_libros where id_publicacion = '$id_libro' and id_usuario = '$id_usuario';";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    $cont_resultado = $resultado->rowCount();
    $contador = $cont_resultado;
    return $contador;
}

function like_libro($conexion, $id_libro, $id_usuario)
{
    $consulta1 = "INSERT INTO `tb_likes_libros` (`id_publicacion`, `id_usuario`, `fecha_like`) VALUES ('$id_libro', '$id_usuario', now());";
    $resultado1 = $conexion->prepare($consulta1);
    $resultado1->execute();

    $consulta2 = "UPDATE `tb_libros` SET `likes` = likes+1 WHERE (`id` = '$id_libro');";
    $resultado2 = $conexion->prepare($consulta2);
    $resultado2->execute();
}

function borrar_like_libro($conexion, $id_libro, $id_usuario)
{
    $consulta1 = "DELETE FROM `tb_likes_libros` WHERE `id_publicacion` = '$id_libro' and `id_usuario` = '$id_usuario';";
    $resultado1 = $conexion->prepare($consulta1);
    $resultado1->execute();

    $consulta2 = "UPDATE `tb_libros` SET `likes` = likes-1 WHERE (`id` = '$id_libro');";
    $resultado2 = $conexion->prepare($consulta2);
    $resultado2->execute();
}

function contar_likes($conexion, $id_libro)
{
    $likes = "";
    $consulta = "SELECT `likes` FROM `tb_libros` WHERE `id` = '$id_libro';";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    $likes = $resultado->fetch(PDO::FETCH_ASSOC);
    

    return $likes['likes'];
}
// dislikes

function buscar_dislike($conexion, $id_libro, $id_usuario)
{
    $contador = "";
    $consulta = "SELECT id_like from tb_dislikes_libros where id_publicacion = '$id_libro' and id_usuario = '$id_usuario';";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    $cont_resultado = $resultado->rowCount();
    $contador = $cont_resultado;
    return $contador;
}

function dislike_libro($conexion, $id_libro, $id_usuario)
{
    $consulta1 = "INSERT INTO `tb_dislikes_libros` (`id_publicacion`, `id_usuario`, `fecha_like`) VALUES ('$id_libro', '$id_usuario', now());";
    $resultado1 = $conexion->prepare($consulta1);
    $resultado1->execute();

    $consulta2 = "UPDATE `tb_libros` SET `dislikes` = dislikes+1 WHERE (`id` = '$id_libro');";
    $resultado2 = $conexion->prepare($consulta2);
    $resultado2->execute();
}

function borrar_dislike_libro($conexion, $id_libro, $id_usuario)
{
    $consulta1 = "DELETE FROM `tb_dislikes_libros` WHERE `id_publicacion` = '$id_libro' and `id_usuario` = '$id_usuario';";
    $resultado1 = $conexion->prepare($consulta1);
    $resultado1->execute();

    $consulta2 = "UPDATE `tb_libros` SET `dislikes` = dislikes-1 WHERE (`id` = '$id_libro');";
    $resultado2 = $conexion->prepare($consulta2);
    $resultado2->execute();   
}


function contar_dislikes($conexion, $id_libro)
{
    $likes = "";
    $consulta = "SELECT `dislikes` FROM `tb_libros` WHERE `id` = '$id_libro';";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    $likes = $resultado->fetch(PDO::FETCH_ASSOC);
    

    return $likes['dislikes'];
}

function comentarios_libros($conexion, $id_libro)
{
    $consulta = "SELECT t1.id_comentario, t1.id_publicacion, t1.comentario, t1.id_usuario, Date_format(t1.fecha_comentario,'%Y/%M/%d') as fecha_comentario,t2.foto_perfil, t2.usuario from tb_comentarios_libros as t1, tb_usuarios as t2 where t1.id_usuario = t2.id_usuario and id_publicacion = '$id_libro';";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    while($data = $resultado->fetch(PDO::FETCH_ASSOC))
    {
        $comentarios[] = $data; 
    }
    

    return $comentarios;
}

function contar_comentarios($conexion, $id_libro)
{
    $comentarios = "";
    $consulta = "SELECT count(*) as comentarios FROM tb_comentarios_libros WHERE id_publicacion = '$id_libro';";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    $comentarios = $resultado->fetch(PDO::FETCH_ASSOC);
    

    return $comentarios['comentarios'];
}

function add_new_comentario($conexion, $id_publicacion, $comentario,$id_usuario)
{
    $consulta1 = "INSERT INTO `tb_comentarios_libros` (`id_publicacion`, `comentario`, `id_usuario`, `fecha_comentario`) VALUES ('$id_publicacion', '$comentario', '$id_usuario', now());";
    $resultado1 = $conexion->prepare($consulta1);
    $resultado1->execute();

    $consulta2 = "UPDATE `tb_libros` SET `comentarios` = comentarios+1 WHERE (`id` = '$id_publicacion');";
    $resultado2 = $conexion->prepare($consulta2);
    $resultado2->execute();
}

function usuario_comentarios_libros($conexion, $id_libro, $id_usuario)
{
    $consulta = "SELECT t1.id_comentario, t1.id_publicacion, t1.comentario, t1.id_usuario, Date_format(t1.fecha_comentario,'%Y/%M/%d') as fecha_comentario,t2.foto_perfil, t2.usuario from tb_comentarios_libros as t1, tb_usuarios as t2 where t1.id_usuario = t2.id_usuario and id_publicacion = '$id_libro' and t1.id_usuario = '$id_usuario';";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    while($data = $resultado->fetch(PDO::FETCH_ASSOC))
    {
        $comentarios[] = $data; 
    }
    

    return $comentarios;
}
function contar_comentarios_usuario($conexion, $id_libro, $id_usuario)
{
    $comentarios_usuario = "";
    $consulta = "SELECT count(*) as comentarios FROM tb_comentarios_libros WHERE id_publicacion = '$id_libro' and id_usuario = '$id_usuario';";
    $resultado = $conexion->prepare($consulta);
    $resultado->execute();
    $comentarios_usuario = $resultado->fetch(PDO::FETCH_ASSOC);
    

    return $comentarios_usuario['comentarios'];
}
?>


