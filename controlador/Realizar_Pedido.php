<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $renovar_valor_total = $_POST['renovar_valor_total'];
    $Productos = $_POST['Productos'];
    $cantidad = $_POST['cantidad'];
    $provedores_renovar = $_POST['provedores_renovar'];
    
    //Inserta los datos en Pedidos

    $mysql->efectuarConsulta("INSERT INTO sol.pedidos_proveedor 
    VALUES (NULL,NOW(),'".$renovar_valor_total."',0)");

    //se saca el ID del ultimo pedido creado

    $pedido_id = $mysql->efectuarConsulta("SELECT 
    sol.pedidos_proveedor.idpedidos_proveedor 
    FROM sol.pedidos_proveedor 
    ORDER BY sol.pedidos_proveedor.idpedidos_proveedor DESC");

    $id = mysqli_fetch_array($pedido_id);

    //Se cuentas cuantos productos se van a insertar

    $elementos = count($Productos);

    //se inserta los productos

    for ($i=0; $i < $elementos ; $i++) {

        $mysql->efectuarConsulta("INSERT INTO sol.proveedor_has_producto_has_pedidos_proveedor 
        VALUES ('".$provedores_renovar."',
        '".$Productos[$i]."',
        '".$id[0]."',
        '".$cantidad[$i]."')");

        
    }

    //desconecta la base de datos

    $mysql->desconectar();
?>