<?php 
include("conexionDB.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
function getListaMunicipio($conexion)
{
    $id = $_POST['id'];
    $sql = "SELECT * FROM tb_municipios WHERE id_estado=$id";
    $ejecutar = $conexion->prepare($sql);
    $ejecutar->execute();
    $municipios = '<option value="0">Elige una opción</option>';
    $row = $ejecutar->fetchAll(PDO::FETCH_ASSOC);
    for ($i=0; $i < count($row) ; $i++) { 
      $id_mcpio = $row[$i]['id_mcpio'];
      $nombre_mcpio = $row[$i]['nombre_mcpio'];
      $municipios .= '<option value='.$id_mcpio.'>'.$nombre_mcpio.'</option>';
    }
    
    return $municipios;
}
echo getListaMunicipio($conexion);
?>