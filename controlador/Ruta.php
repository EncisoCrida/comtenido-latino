<?php

class Ruta
{
    function buscar_sesion($sesion, $tipo_usuario)
        {
            $salida = "";
            switch ($tipo_usuario) {
                case 1:
                    switch($sesion)
                    {
                        case 1:
                                $salida = "welcome.phtml";
                        break;
        
                        case 2:
                                $salida = "lector/home_lector.phtml";
                        break;
                        
                        default : $salida = 0;
                    }
                    break;
                
                case 2:
                    switch($sesion)
                    {
                        case 1:
                                $salida = "welcome.phtml";
                        break;
        
                        case 2:
                                $salida = "autor/home_autor.phtml";
                        break;
        
                        case 3:
                                $salida = "autor/autor_libros.phtml";
                        break;
        
                        case 4:
                                $salida = "autor/autor_imagenes.phtml";
                        break;
                        case 10:
                                $salida = "publicaciones/libros.phtml";
                        break;

                        
                        default : $salida = 0;
                    }
                    break;
                
                case 3:
                    switch($sesion)
                    {
                        case 1:
                                $salida = "welcome.phtml";
                        break;
        
                        case 2:
                                $salida = "home_autor.phtml";
                        break;
        
                        case 3:
                                $salida = "hacer_publicacion.phtml";
                        break;
        
                        case 4:
                                $salida = "mis_publicaciones.phtml";
                        break;
                        case 30:
                                $salida = "admin_home.phtml";
                        break;
                        
                        default : $salida = 0;
                    }
                    break;
                
                default:

                    break;
            }
                

            return $salida;
        }

}