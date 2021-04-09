<?php
include("conexionDB.php");
$objeto = new Conexion();
$conexion = $objeto->Conectar();
// Realizamos la consulta para extraer los datos
$consulta = "SELECT * FROM tb_categorias";
$resultado = $conexion->prepare($consulta);
$resultado->execute();        

while ($row = $resultado->fetch(PDO::FETCH_ASSOC)) {
    $data[] = $row;
    // En esta sección estamos llenando el select con datos extraidos de una base de datos.
    echo '<option value="'.$row["id_categoria"].'">'.$row['categoria'].'</option>';
}
