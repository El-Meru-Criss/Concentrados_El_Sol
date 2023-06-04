<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

   //toma los valores deseados
   $id_venta = $_POST['id_venta'];
   $id_producto = $_POST['id_producto'];
   $estado=$_POST['estado'];

   //realiza la consulta MySQL deseada, y la guarda en una variable
    if ($estado==1) {
        $mysql->efectuarConsulta("UPDATE sol.inventario_has_ventas 
        SET sol.inventario_has_ventas.estado_domicilio_idestado_domicilio = 3 
        WHERE sol.inventario_has_ventas.ventas_idventas='".$id_venta."' AND sol.inventario_has_ventas.inventario_idinventario='".$id_producto."'");   
    }else {
        $mysql->efectuarConsulta("UPDATE sol.inventario_has_ventas 
        SET sol.inventario_has_ventas.estado_domicilio_idestado_domicilio = 1 
        WHERE sol.inventario_has_ventas.ventas_idventas='".$id_venta."' AND sol.inventario_has_ventas.inventario_idinventario='".$id_producto."'");   
    }
   
   echo $id_venta;
   
    //desconecta la base de datos

    $mysql->desconectar();
?>