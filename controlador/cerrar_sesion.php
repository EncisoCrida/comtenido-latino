  
<?php
if(! isset($_SESSION) ) session_start();
$_SESSION['usuario']='';
header("location:controlador.php?sesion=3");

?>