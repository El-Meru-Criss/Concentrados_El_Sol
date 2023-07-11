<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $id_producto = $_POST['id_producto'];
    $id_proveedor = $_POST['id_proveedor'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $mysql->efectuarConsulta("UPDATE sol.proveedor_has_producto 
    SET sol.proveedor_has_producto.estado=0  
    WHERE sol.proveedor_has_producto.proveedor_idproveedor = '".$id_proveedor."' 
    AND sol.proveedor_has_producto.producto_idproducto = '".$id_producto."'");

    $mysql->efectuarConsulta("DELETE FROM sol.proveedor_has_producto 
    WHERE sol.proveedor_has_producto.proveedor_idproveedor = '".$id_proveedor."' 
    AND sol.proveedor_has_producto.producto_idproducto = '".$id_producto."'");

    $existencia = $mysql->efectuarConsulta("SELECT sol.proveedor_has_producto.proveedor_idproveedor, 
    sol.proveedor_has_producto.producto_idproducto 
    FROM sol.proveedor_has_producto 
    WHERE sol.proveedor_has_producto.proveedor_idproveedor = '".$id_proveedor."' 
    AND sol.proveedor_has_producto.producto_idproducto = '".$id_producto."'");

    $existe = "No";

    if (mysqli_num_rows($existencia) > 0) {
        //$existe = "Si";
    }


    echo $existe;
    //desconecta la base de datos

    $mysql->desconectar();
?>