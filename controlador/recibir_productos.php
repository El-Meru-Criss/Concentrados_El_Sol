<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $id_pedido = $_POST['id_pedido'];
    $Productos = $_POST['Productos'];
    $Cantidad = $_POST['Cantidad'];

    //Cuenta los productos se van a insertar

    $elemento = 0;

    //Cuenta todos los productos pedidos y todos los productos que llegaron

    $pedidos = 0;
    $entregados = 0;

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $productos = $mysql->efectuarConsulta("SELECT sol.proveedor_has_producto_has_pedidos_proveedor.proveedor_has_producto_producto_idproducto,
    sol.proveedor_has_producto_has_pedidos_proveedor.recibidos,
    sol.proveedor_has_producto_has_pedidos_proveedor.cantidad
    FROM sol.proveedor_has_producto_has_pedidos_proveedor
    WHERE sol.proveedor_has_producto_has_pedidos_proveedor.pedidos_proveedor_idpedidos_proveedor = '".$id_pedido."'");

    while ($prod = mysqli_fetch_array($productos)) {

        $total_recibido = 0;
        
        $existencia = $mysql->efectuarConsulta("SELECT sol.inventario.idinventario, 
        sol.inventario.cantidad,
        sol.inventario.proveedor_has_producto_producto_idproducto 
        FROM sol.inventario 
        WHERE sol.inventario.proveedor_has_producto_producto_idproducto = '".$prod['proveedor_has_producto_producto_idproducto']."'");

        $peso_producto = $mysql->efectuarConsulta("SELECT sol.producto.peso 
        FROM sol.producto 
        WHERE sol.producto.idproducto = '".$prod['proveedor_has_producto_producto_idproducto']."'");

        $peso = mysqli_fetch_array($peso_producto);


        if (mysqli_num_rows($existencia) > 0 
        && $prod['proveedor_has_producto_producto_idproducto'] == $Productos[$elemento]) {

            $exis = mysqli_fetch_array($existencia);
            $total = $exis['cantidad'] + ($Cantidad[$elemento] * $peso['peso']);

            $mysql->efectuarConsulta("UPDATE sol.inventario 
            SET sol.inventario.cantidad='".$total."',
            sol.inventario.fecha_entrada=CURDATE() 
            WHERE sol.inventario.proveedor_has_producto_producto_idproducto = '".$prod['proveedor_has_producto_producto_idproducto']."'");

            $total_recibido = $prod['recibidos'] + $Cantidad[$elemento];
            $entregados += $Cantidad[$elemento];

            $mysql->efectuarConsulta("UPDATE sol.proveedor_has_producto_has_pedidos_proveedor 
            SET sol.proveedor_has_producto_has_pedidos_proveedor.recibidos = '".$total_recibido."' 
            WHERE sol.proveedor_has_producto_has_pedidos_proveedor.pedidos_proveedor_idpedidos_proveedor = '".$id_pedido."' 
            AND sol.proveedor_has_producto_has_pedidos_proveedor.proveedor_has_producto_producto_idproducto = '".$prod['proveedor_has_producto_producto_idproducto']."'");

            $elementos_contador = count($Cantidad) - 1;
            if ($elemento != $elementos_contador) {
                $elemento += 1;
            }
            

        } else {

            if ($prod['proveedor_has_producto_producto_idproducto'] == $Productos[$elemento]) {
                $total = $Cantidad[$elemento] * $peso['peso'];

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

                $total_recibido = $prod['recibidos'] + $Cantidad[$elemento];

                $entregados += $Cantidad[$elemento];

                $mysql->efectuarConsulta("UPDATE sol.proveedor_has_producto_has_pedidos_proveedor 
                SET sol.proveedor_has_producto_has_pedidos_proveedor.recibidos = '".$total_recibido."' 
                WHERE sol.proveedor_has_producto_has_pedidos_proveedor.pedidos_proveedor_idpedidos_proveedor = '".$id_pedido."' 
                AND sol.proveedor_has_producto_has_pedidos_proveedor.proveedor_has_producto_producto_idproducto = '".$prod['proveedor_has_producto_producto_idproducto']."'");

                $elementos_contador = count($Cantidad) - 1;
                if ($elemento != $elementos_contador) {
                    $elemento += 1;
                }
            }

        }

        $pedidos += $prod['cantidad'];
        $entregados += $prod['recibidos'];
    }

    if ($pedidos == $entregados) {
        $mysql->efectuarConsulta("UPDATE sol.pedidos_proveedor 
        SET sol.pedidos_proveedor.estado_pedido='1' 
        WHERE sol.pedidos_proveedor.idpedidos_proveedor = '".$id_pedido."'");

        echo "refrescar";
    }
    //desconecta la base de datos

    $mysql->desconectar();
?>