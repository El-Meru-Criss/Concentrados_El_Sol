<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    
    $id_producto = $_POST['id_producto'];
    $nombre = $_POST['nombre'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $mysql->efectuarConsulta("UPDATE sol.producto 
    SET sol.producto.nombre_producto = '".$nombre."' 
    WHERE sol.producto.idproducto = '".$id_producto."'");

    //desconecta la base de datos

    $mysql->desconectar();
?>