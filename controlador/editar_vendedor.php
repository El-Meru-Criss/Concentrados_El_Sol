<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $idvendedores = $_POST['idvendedores'];
    $vendedor_nombre = $_POST['vendedor_nombre'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $mysql->efectuarConsulta("UPDATE sol.vendedores
    SET sol.vendedores.nombre = '".$vendedor_nombre."'
    WHERE sol.vendedores.idvendedores = '".$idvendedores."'");

    //desconecta la base de datos

    $mysql->desconectar();
?>