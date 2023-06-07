<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    $id_acordeon = $_POST['id_acordeon'];
    

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $productos = $mysql->efectuarConsulta("SELECT sol.pedidos_proveedor.idpedidos_proveedor, 
    sol.producto.nombre_producto,
    sol.proveedor_has_producto_has_pedidos_proveedor.cantidad,
    sol.proveedor_has_producto_has_pedidos_proveedor.recibidos,
    sol.proveedor_has_producto_has_pedidos_proveedor.proveedor_has_producto_producto_idproducto
    FROM sol.proveedor_has_producto 
    INNER JOIN sol.producto
    ON sol.producto.idproducto = sol.proveedor_has_producto.producto_idproducto
    INNER JOIN sol.proveedor_has_producto_has_pedidos_proveedor 
    ON sol.proveedor_has_producto_has_pedidos_proveedor.proveedor_has_producto_proveedor_idproveedor = sol.proveedor_has_producto.proveedor_idproveedor AND sol.proveedor_has_producto_has_pedidos_proveedor.proveedor_has_producto_producto_idproducto = sol.proveedor_has_producto.producto_idproducto
    INNER JOIN sol.pedidos_proveedor 
    ON sol.pedidos_proveedor.idpedidos_proveedor = sol.proveedor_has_producto_has_pedidos_proveedor.pedidos_proveedor_idpedidos_proveedor
    WHERE pedidos_proveedor.idpedidos_proveedor = '".$id_acordeon."'");
?>

    <thead>
        <tr>
            <th scope="col">Producto</th>
            <th scope="col">Pedido</th>
            <th scope="col">Recibido</th>
            <th scope="col">Recibir</th>
        </tr>
    </thead>
    <tbody>

    <?php //inicio del ciclo para ir colocando HTML 

    $contador = 0;

    while ($prod = mysqli_fetch_array($productos)) { ?>    
        <tr>
            <td><?php echo $prod['nombre_producto'] ?></td>
            <td><?php echo $prod['cantidad'] ?></td>
            <td><?php echo $prod['recibidos'] ?></td>
            <td><input <?php if ($prod['cantidad'] == $prod['recibidos']) { ?>disabled<?php } ?> data-producto="<?php echo $prod['proveedor_has_producto_producto_idproducto'] ?>" min="0" max="<?php echo ($prod['cantidad'] - $prod['recibidos']) ?>" onchange="habilitar_envios(<?php echo $id_acordeon ?>)" value="" class="form-control form-control-sm productos_pedido<?php echo $id_acordeon ?>" id="producto<?php echo $contador ?>-<?php echo $id_acordeon ?>" type="number" style="width: 10rem;"></td>
        </tr>
    <?php
    
    $contador += 1;} //fin del ciclo

    ?>

    </tbody>

<?php //desconecta la base de datos

    $mysql->desconectar();

?>