<?php //llama a la base de datos con el modelo

    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $vendedor_nombre = $_POST['vendedor_nombre'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $mysql->efectuarConsulta("INSERT INTO sol.vendedores 
    VALUES (NULL,
    '".$vendedor_nombre."')");

    //desconecta la base de datos

    $mysql->desconectar();
?>