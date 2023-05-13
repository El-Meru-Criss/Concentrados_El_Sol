<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $productos = $mysql->efectuarConsulta("SELECT sol.inventario.idinventario, 
    sol.producto.nombre_producto, 
    sol.inventario.cantidad, 
    sol.inventario.precio_publico, 
    sol.inventario.precio_bulto, 
    sol.inventario.fecha_entrada, 
    sol.inventario.fecha_caducidad FROM sol.inventario 
    INNER JOIN sol.proveedor_has_producto ON sol.proveedor_has_producto.producto_idproducto = sol.inventario.proveedor_has_producto_producto_idproducto
    INNER JOIN sol.producto ON sol.proveedor_has_producto.producto_idproducto = sol.producto.idproducto");
?>

<div class="table-responsive">



        <table class="table tabla-deudores">
            <thead class="">
              <tr>
                <th scope="col">Opciones</th>
                <th scope="col">Producto</th>
                <th scope="col">Kg</th>
                <th scope="col">Precio KL</th>
                <th scope="col">Precio Bulto</th>
                <th scope="col">Ingreso</th>
                <th scope="col">Vencimiento</th>
              </tr>
            </thead>
            <tbody>
              
              
<?php //inicio del ciclo para ir colocando HTML 



while ($prod = mysqli_fetch_array($productos)) { ?>
    
            <tr>
                <td>
                  <button onclick="eliminar_inventario()" type="button" class="btn btn-outline-danger btn-sm"><i class="fa-solid fa-trash"></i></button>
                  <button type="button" class="btn btn-outline-info btn-sm"><i class="fa-solid fa-pen"></i></button>
              </td>
                <td><?php echo $prod['nombre_producto'] ?></td>
                <td><?php echo $prod['cantidad'] ?></td>
                <td>
                  
                <input value="<?php echo $prod['precio_publico'] ?>" class="form-control form-control-sm" id="precio_kl" type="number" style="width: 10rem;">
        
                </td>
                <td>
                <input value="<?php echo $prod['precio_bulto'] ?>" type="number" class="form-control form-control-sm" id="precio_bulto" style="width: 10rem;">
                  
                </td>
                <td>
                <input value="<?php echo $prod['fecha_entrada'] ?>" type="date" class="form-control-plaintext form-control-sm" id="F_vencimiento">
              
              </td>
                <td>
                  <input value="<?php echo $prod['fecha_caducidad'] ?>" type="date" class="form-control-plaintext form-control-sm" id="F_vencimiento">
                </td>
            </tr>

<?php } //fin del ciclo

?>

            </tbody>
          </table>          
      </div>

<?php //desconecta la base de datos

    $mysql->desconectar();

?>