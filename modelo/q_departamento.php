<?php
include("conexionDB.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
function getListaDepartamentos($conexion)
{
    $id = $_POST['id'];
    $sql = "SELECT * FROM tb_estados WHERE id_pais=$id";
    $ejecutar = $conexion->prepare($sql);
    $ejecutar->execute(); 
    $departamentos = '<option value="0">Elige una opción</option>';
    $row = $ejecutar->fetchAll(PDO::FETCH_ASSOC);
    for ($i=0; $i < count($row) ; $i++) { 
      $id_estado = $row[$i]['id_estado'];
      $estado = $row[$i]['estado'];
      $departamentos .= '<option value='.$id_estado.'>'.$estado.'</option>';
    }
    
    return $departamentos;
}
echo getListaDepartamentos($conexion);
