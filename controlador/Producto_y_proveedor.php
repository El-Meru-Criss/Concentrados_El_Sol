<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $seleccionar_producto = $_POST['seleccionar_producto'];
    $proveedores_crear_producto = $_POST['proveedores_crear_producto'];
    $producto_precio = $_POST['producto_precio'];

    //se asocia el producto aun proveedor

    $mysql->efectuarConsulta("INSERT INTO sol.proveedor_has_producto 
    VALUES ('".$proveedores_crear_producto."',
    '".$seleccionar_producto."',
    '".$producto_precio."',
    1)");

    $mysql->efectuarConsulta("UPDATE sol.proveedor_has_producto 
    SET sol.proveedor_has_producto.estado=1,
    sol.proveedor_has_producto.precio='".$producto_precio."'
    WHERE sol.proveedor_has_producto.proveedor_idproveedor = '".$proveedores_crear_producto."' 
    AND sol.proveedor_has_producto.producto_idproducto = '".$seleccionar_producto."'");







    //desconecta la base de datos

    $mysql->desconectar();
?>