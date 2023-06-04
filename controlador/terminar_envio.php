<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

   //toma los valores deseados
   $id_venta = $_POST['id_venta'];

   //realiza la consulta MySQL deseada, y la guarda en una variable

   $mysql->efectuarConsulta("UPDATE sol.inventario_has_ventas 
   SET sol.inventario_has_ventas.estado_domicilio_idestado_domicilio = 2 
   WHERE sol.inventario_has_ventas.ventas_idventas='".$id_venta."'");
   
   echo $id_venta;
   
    //desconecta la base de datos

    $mysql->desconectar();
?>