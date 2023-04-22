<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $idproveedor = $_POST['idproveedor'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $mysql->efectuarConsulta("DELETE FROM sol.proveedor 
    WHERE sol.proveedor.idproveedor = ".$idproveedor."");

    //desconecta la base de datos

    $mysql->desconectar();
?>