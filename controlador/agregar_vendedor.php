<?php //llama a la base de datos con el modelo

    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $vendedor_nombre = $_POST['vendedor_nombre'];
$vendedor_documento = $_POST['vendedor_documento'];
$vendedor_contrase�a = $_POST['vendedor_contrase�a'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $mysql->efectuarConsulta("INSERT INTO sol.vendedores 
    VALUES (NULL,
    '".$vendedor_nombre."', '".$vendedor_documento."', '".$vendedor_contrase�a."', 0)");

    //desconecta la base de datos

    $mysql->desconectar();
?>