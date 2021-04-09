<!-- 
modulo: controlador
cargo:  controlador univarsal
autor:  Cridatian Enciso @Enciso_Crida 
-->

<?php
//declaro la variable de sesion la cual hace referencia a la sesion o ruta que se va a mostrar en pantalla (la variablle sesion solo hacereferencia a la ruta)
$sesion = 0;
//se declara la variable ruta por defecto se deja la pagina de registro eh inicio de seseion 
$ruta = "welcome.phtml";
// se declara la variable tipo de usuario, esta define el rol de usuario si es admin autor o un eector
//importante esta variable define que tipo de acceso tendra el usuario logeado
$tipoUsuario = '';
//verifico la existencia de la ruta por url
if (isset($_GET['sesion'])) {
    //tomo la sesion que viene por url
    $sesion = $_GET['sesion'];
    //si la sesion es diferente a 1 se hace la verificacion de que el usuario este logeado
    if ($sesion != 1) {
        /** si no existe una sesion se crea */
        if (!isset($_SESSION)) session_start();
        /**se verifica que exista la sesion usuario */
        if (isset($_SESSION['usuario'])) {
            /** si existe la sesion usuario se verofoca que tengas un usuaeio */
            if ($_SESSION['usuario'] == '') $sesion = 1;
        } else {
            $sesion = 1;
        }
    }
}
// verificamos que exista la variable de seseion
if (isset($_SESSION['userLogin'])) {
    //se verifica que el usuario logeado no este vacio
    if ($_SESSION['userLogin'] == '') {
        //en caso de que este usuario este vacio se regresa al login
        $sesion = 1;
    } else {
        //en caso de que no sea vacio se guarda el tipo de usuario en una variable 
        $tipoUsuario = $_SESSION['userLogin']['id_tipo_usuario'];
    }
}

//llamo la clase ruta
include_once("Ruta.php");
$nuevo_objeto = new Ruta();
//se verifica que la sesion o ruta sea distinta a 1 
if (isset($_GET['sesion']) && $sesion != 1)
{
    $sesion = $_GET['sesion'];
    $ruta = $nuevo_objeto->buscar_sesion($sesion, $tipoUsuario);
} 
//se resive el tipo de menu a incluir en las sesiones de contenido
if(isset($_GET['menu'])) $menu = $_GET['menu']; 
//datos del modulo que se va a mostrar
$modulo = "";
//modulo enviado por url
if(isset($_GET['modulo']))
{
     $modulo = $_GET['modulo'];
     //clase encargada de verifiacr el modulo que se va a mstrar dependoendo el dato recivido por url
include_once("Modulo.php");
$nuevo_Modulo = new Modulo();
$modulo_includ = $nuevo_Modulo->buscar_modulo($modulo);
// se llama el archivo con un array que contiene las publicaciones a mostrar
include_once "publicaciones/$modulo_includ";
}

// esta variable hace referencia a lo que se va a mostrar en pantalla
//la variable ruta es el nombre del archivo que se va a mostrar este nombre se trae mediante la clase "Ruta"
$contenido = "../vista/$ruta";
require_once("../vista/plantilla.phtml");
?>