<?php

/**
 * madulo: controlador
 * funcion: trae los likes, dislikes y comentarios de una publicacion
 * autor:  Cristian Encsio @Enciso_Crida
 */
// iniciamos la variable de sesion 
if (!isset($_SESSION)) session_start();
//llamado al modelo y conexion a base de datos
include("../../modelo/conexionDB.php");
include("../../modelo/publicaciones/libros.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
// id usario por variable de sesion
$id_usuario = $_SESSION['userLogin']['id_usuario'];
//id del libro enviado por ajax
if (isset($_POST['id'])) $id_libro = $_POST['id'];
//accion enviada por ajax like, dislike, comentario
if (isset($_POST['accion'])) $accion = $_POST['accion'];
//en caso de enviar un nuevo comentario por ajax
if(isset($_POST['id_publicacion'])) $id_publicacion = $_POST['id_publicacion'];
if(isset($_POST['comentario'])) $comentario = $_POST['comentario'];
//llamado de funcion
//se verifica si el usario ya dio like o no
$buscar_like = buscar_like($conexion, $id_libro, $id_usuario);
$buscar_dislike = buscar_dislike($conexion, $id_libro, $id_usuario);
//cantidad de disllikes de la publicacion
$contador_dislikes = contar_dislikes($conexion, $id_libro);
switch ($accion) {
    case 1:
        if ($buscar_like == 0) {
            /**en caso de que el usuario le alla dado dislike y precione el boton de like
             * se tendra que borrar el dislike y agregar el like
             */
            if ($buscar_dislike == 1) {
                borrar_dislike_libro($conexion, $id_libro, $id_usuario);
                $contador_dislikes = contar_dislikes($conexion, $id_libro);
                $contador_dislikes = $contador_dislikes--;
            }
            //si no dio like se registra un like
            like_libro($conexion, $id_libro, $id_usuario);
        } else {
            //si ya dio like se borra el like
            borrar_like_libro($conexion, $id_libro, $id_usuario);
        }
        //cantidad de likes de la publicacion
        $contador_likes = contar_likes($conexion, $id_libro);
        if ($buscar_like >= 1) {
            $contador_likes = $contador_likes--;
        } else {
            $contador_likes = $contador_likes++;
        }
        // se crea un arreglo con los datos que se quieren enviar a ajax
        $data = array('likes' => $contador_likes, 'buscar_like' => $buscar_like, 'dislikes' => $contador_dislikes);
        
    break;
    case 2:
        if ($buscar_dislike == 0) {
            /**en caso de que el usuario le alla dado dislike y precione el boton de like
             * se tendra que borrar el dislike y agregar el like
             */
            if ($buscar_like == 1) {
                borrar_like_libro($conexion, $id_libro, $id_usuario);
                $contador_likes = contar_likes($conexion, $id_libro);
                $contador_likes = $contador_likes--;
            }
            //si no dio dislike se registra un dislike
            dislike_libro($conexion, $id_libro, $id_usuario);
        } else {
            //si ya dio dislike se borra el dislike
            borrar_dislike_libro($conexion, $id_libro, $id_usuario);
        }
        //cantidad de likes de la publicacion
        $contador_dislikes = contar_dislikes($conexion, $id_libro);
            //cantidad de likes de la publicacion
    $contador_likes = contar_likes($conexion, $id_libro);
        if ($buscar_dislike >= 1) {
            $contador_dislikes = $contador_dislikes--;
        } else {
            $contador_dislikes = $contador_dislikes++;
        }
        // se crea un arreglo con los datos que se quieren enviar a ajax
        $data = array('likes' => $contador_likes, 'buscar_dislike' => $buscar_dislike, 'dislikes' => $contador_dislikes);
    break;
    case 3:
        $contador_comentarios = contar_comentarios($conexion, $id_libro);
        if ($contador_comentarios == 0) {
            $data = array("comentarios" => $contador_comentarios);
        }else{

            $data = comentarios_libros($conexion, $id_libro);
        }
    break;
    case 4:
        //verifico que el comentario no sea vacio
        if($comentario == '')
        {
            $data = comentarios_libros($conexion, $id_libro);
        }else{
            add_new_comentario($conexion, $id_publicacion, $comentario,$id_usuario);
            $data = comentarios_libros($conexion, $id_libro);
        }

    break;
    case 5:
        //comentarios echos por el usuario
         $contador_comentarios_usuario = contar_comentarios_usuario($conexion, $id_libro, $id_usuario);
        if ($contador_comentarios_usuario == 0) {
            $data = array("comentarios" => $contador_comentarios_usuario);
        }else{

           $data = usuario_comentarios_libros($conexion, $id_libro, $id_usuario);
        }

    break;
    
    default:
        # code...
        break;
}



//se envian los datos a ajax
echo json_encode($data);
?>