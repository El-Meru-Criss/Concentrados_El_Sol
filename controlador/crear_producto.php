<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $producto_nombre = $_POST['producto_nombre'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $mysql->efectuarConsulta("INSERT INTO sol.producto 
    VALUES (NULL,
    '".$producto_nombre."')");

    //desconecta la base de datos

    $mysql->desconectar();
?>