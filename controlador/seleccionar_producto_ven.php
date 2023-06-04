<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();
    $producto = $_POST['producto'];
    $idcasilla = $_POST['idcasilla'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $productos = $mysql->efectuarConsulta("SELECT sol.proveedor_has_producto.producto_idproducto, 
    sol.producto.nombre_producto,
    sol.inventario.precio_publico,
    sol.inventario.precio_bulto,
    sol.inventario.idinventario,
    sol.inventario.cantidad
    FROM sol.proveedor_has_producto 
    INNER JOIN sol.producto ON sol.producto.idproducto = sol.proveedor_has_producto.producto_idproducto
    INNER JOIN sol.inventario ON sol.inventario.proveedor_has_producto_producto_idproducto =  sol.proveedor_has_producto.producto_idproducto
    WHERE sol.inventario.cantidad > 0");

    
    
?>

<div class="input-group">
    <select class="form-select producto" aria-label="Default select example" onchange="precio_renovar(<?php echo $idcasilla ?>)" id="producto<?php echo $idcasilla ?>" >
    <option selected></option>
<?php //inicio del ciclo para ir colocando HTML 

while ($prod = mysqli_fetch_array($productos)) { ?>
    
    <option data-precio="<?php echo $prod['precio_publico']?>" data-bulto="<?php echo $prod['precio_bulto']?>" data-cantidad="<?php echo $prod['cantidad']?>"  value="<?php echo $prod['idinventario'] ?>"><?php echo $prod['nombre_producto'] ?></option>
<?php } //fin del ciclo

?>
</select>
<select class="form-select unidad" aria-label="Default select example" onchange="precio_renovar(<?php echo $idcasilla ?>)" id="unidad_medida<?php echo $idcasilla ?>" >
    <option selected=""> </option>
    <?php //inicio del ciclo para ir colocando HTML 

    $unidad_medida = $mysql->efectuarConsulta("SELECT sol.unidad_medida.idunidad_medida,
    sol.unidad_medida.nombre
    FROM sol.unidad_medida");

while ($uni = mysqli_fetch_array($unidad_medida)) { ?>
    <option value="<?php echo $uni['idunidad_medida'] ?>"><?php echo $uni['nombre'] ?></option>
<?php } //fin del ciclo

?>
</select>
    <input type="number" onchange="valor_total()" class="form-control cantidad" id="cantidad<?php echo $idcasilla ?>" placeholder="cantidad" aria-describedby="basic-addon3 basic-addon4" min="0" max="0">
    <input type="number" onchange="valor_total()" class="form-control precio" id="precio<?php echo $idcasilla ?>" placeholder="Precio" aria-describedby="basic-addon3 basic-addon4"  disabled=""?>
</div>

<?php //desconecta la base de datos

    $mysql->desconectar();

?>