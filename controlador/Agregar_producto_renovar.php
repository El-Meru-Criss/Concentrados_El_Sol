<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $provedores_renovar = $_POST['provedores_renovar'];
    $idcasilla = $_POST['idcasilla'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $productos = $mysql->efectuarConsulta("SELECT sol.proveedor_has_producto.producto_idproducto, 
    sol.producto.nombre_producto,
    sol.proveedor_has_producto.precio
    FROM sol.proveedor_has_producto 
    INNER JOIN sol.producto 
    ON sol.producto.idproducto = sol.proveedor_has_producto.producto_idproducto 
    WHERE sol.proveedor_has_producto.proveedor_idproveedor = ".$provedores_renovar."");
?>

<div class="input-group">
    <select onchange="precio_renovar(<?php echo $idcasilla ?>)" id="producto<?php echo $idcasilla ?>" class="form-select productos_renovar" aria-label="Default select example">
        <option selected=""> </option>

        <?php //inicio del ciclo para ir colocando HTML 

        while ($prod = mysqli_fetch_array($productos)) { ?>

            <option data-precio="<?php echo $prod['precio'] ?>" value="<?php echo $prod['producto_idproducto'] ?>"><?php echo $prod['nombre_producto'] ?></option>            

        <?php } //fin del ciclo

        ?>
    </select>
    <input type="number" onchange="renovar_valor_total()" class="form-control cantidad_renovar" id="basic-url" placeholder="cantidad" aria-describedby="basic-addon3 basic-addon4">
    <input type="number" onchange="renovar_valor_total(); cambiar_precio_compra(<?php echo $idcasilla ?>)" class="form-control precio_renovar" id="precio<?php echo $idcasilla ?>" placeholder="Precio" aria-describedby="basic-addon3 basic-addon4">
</div>

<?php //desconecta la base de datos

    $mysql->desconectar();

?>