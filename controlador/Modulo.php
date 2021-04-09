<?php

class Modulo
{
    function buscar_modulo($modulo)
        {
            $salida = "";
                    switch($modulo)
                    {
                        case "1":
                                $salida = "libros.php";
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
                

            return $salida;
        }

}