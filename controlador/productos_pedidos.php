<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    $id_acordeon = $_POST['id_acordeon'];
    

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $productos = $mysql->efectuarConsulta("SELECT sol.pedidos_proveedor.idpedidos_proveedor, 
    sol.producto.nombre_producto,
    sol.proveedor_has_producto_has_pedidos_proveedor.cantidad
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
            <th scope="col">Cantidad</th>
        </tr>
    </thead>
    <tbody>

    <?php //inicio del ciclo para ir colocando HTML 

    while ($prod = mysqli_fetch_array($productos)) { ?>    
        <tr>
            <td><?php echo $prod['nombre_producto'] ?></td>
            <td><?php echo $prod['cantidad'] ?></td>
        </tr>
    <?php } //fin del ciclo

    ?>

    </tbody>

<?php //desconecta la base de datos

    $mysql->desconectar();

?>