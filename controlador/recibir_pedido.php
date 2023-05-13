<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $id_pedido = $_POST['id_pedido'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $productos = $mysql->efectuarConsulta("SELECT sol.proveedor_has_producto_has_pedidos_proveedor.proveedor_has_producto_producto_idproducto,
    sol.proveedor_has_producto_has_pedidos_proveedor.cantidad
    FROM sol.proveedor_has_producto_has_pedidos_proveedor
    WHERE sol.proveedor_has_producto_has_pedidos_proveedor.pedidos_proveedor_idpedidos_proveedor = '".$id_pedido."'");

    while ($prod = mysqli_fetch_array($productos)) {
        
        $existencia = $mysql->efectuarConsulta("SELECT sol.inventario.idinventario, 
        sol.inventario.cantidad,
        sol.inventario.proveedor_has_producto_producto_idproducto 
        FROM sol.inventario 
        WHERE sol.inventario.proveedor_has_producto_producto_idproducto = '".$prod['proveedor_has_producto_producto_idproducto']."'");

        $peso_producto = $mysql->efectuarConsulta("SELECT sol.producto.peso 
        FROM sol.producto 
        WHERE sol.producto.idproducto = '".$prod['proveedor_has_producto_producto_idproducto']."'");

        $peso = mysqli_fetch_array($peso_producto);


        if (mysqli_num_rows($existencia) > 0) {

            $exis = mysqli_fetch_array($existencia);
            $total = $exis['cantidad'] + ($prod['cantidad'] * $peso['peso']);

            $mysql->efectuarConsulta("UPDATE sol.inventario 
            SET sol.inventario.cantidad='".$total."',
            sol.inventario.fecha_entrada=CURDATE() 
            WHERE sol.inventario.proveedor_has_producto_producto_idproducto = '".$prod['proveedor_has_producto_producto_idproducto']."'");

        } else {

            $total = $prod['cantidad'] * $peso['peso'];

            $mysql->efectuarConsulta("INSERT INTO sol.inventario
            (sol.inventario.idinventario, 
             sol.inventario.cantidad, 
             sol.inventario.fecha_entrada, 
             sol.inventario.proveedor_has_producto_producto_idproducto, 
             sol.inventario.estado_producto_idestado_producto) 
             VALUES 
             (NULL,
              '".$total."',
              CURDATE(),
              '".$prod['proveedor_has_producto_producto_idproducto']."',
              '1')");

        }

        $mysql->efectuarConsulta("UPDATE sol.pedidos_proveedor 
        SET sol.pedidos_proveedor.estado_pedido='1' 
        WHERE sol.pedidos_proveedor.idpedidos_proveedor = '".$id_pedido."'");

    }
    //desconecta la base de datos

    $mysql->desconectar();
?>