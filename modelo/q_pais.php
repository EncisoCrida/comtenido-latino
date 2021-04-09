<?php 
include("conexionDB.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
function getListaPais($conexion)
{
    $sql = "SELECT * FROM tb_paises";
    $ejecutar = $conexion->prepare($sql);
    $ejecutar->execute();
    $paises = '<option value="0">Elige una opción</option>';
    $row = $ejecutar->fetchAll(PDO::FETCH_ASSOC);
    for ($i=0; $i < count($row) ; $i++) { 
      $id_pais = $row[$i]['id_pais'];
      $pais = $row[$i]['pais'];
      $paises .= '<option value='.$id_pais.'>'.$pais.'</option>';
    }
   

 
    return $paises;
}
echo getListaPais($conexion);
?>