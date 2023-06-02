<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $precio = $_POST['precio'];
    $producto = $_POST['producto'];
    $proveedor = $_POST['proveedor'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $mysql->efectuarConsulta("UPDATE sol.proveedor_has_producto 
    SET sol.proveedor_has_producto.precio='".$precio."' 
    WHERE sol.proveedor_has_producto.proveedor_idproveedor = '".$proveedor."' 
    AND sol.proveedor_has_producto.producto_idproducto = '".$producto."'");

    
?>

<?php

    //desconecta la base de datos

    $mysql->desconectar();
?>