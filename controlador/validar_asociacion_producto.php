<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $seleccionar_producto = $_POST['seleccionar_producto'];
    $proveedores_crear_producto = $_POST['proveedores_crear_producto'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $existencia = $mysql->efectuarConsulta("SELECT sol.proveedor_has_producto.proveedor_idproveedor, 
    sol.proveedor_has_producto.producto_idproducto 
    FROM sol.proveedor_has_producto 
    WHERE sol.proveedor_has_producto.proveedor_idproveedor = '".$proveedores_crear_producto."' 
    AND sol.proveedor_has_producto.producto_idproducto = '".$seleccionar_producto."'");

    if (mysqli_num_rows($existencia) > 0) { //el producto existe
        echo "existe";
    } else {
         echo "disponible";
    };

    //desconecta la base de datos

    $mysql->desconectar();
?>