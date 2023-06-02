<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $id_pedido = $_POST['id_pedido'];

    //realiza la consulta MySQL deseada

    $mysql->efectuarConsulta("UPDATE sol.pedidos_proveedor 
        SET sol.pedidos_proveedor.estado_pedido='0' 
        WHERE sol.pedidos_proveedor.idpedidos_proveedor = '".$id_pedido."'");
    
    //desconecta la base de datos

    $mysql->desconectar();
?>