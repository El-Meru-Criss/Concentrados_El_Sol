<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $inventario_idinventario = $_POST['inventario_idinventario'];
    $ventas_idventas = $_POST['ventas_idventas'];
    $cantidad_vendida = $_POST['cantidad_vendida'];
    //toma el valor de cantidad enviada
    $cantidad_enviada = $_POST['cantidad_enviada'];


    //realiza la consulta MySQL deseada, y la guarda en una variable
if ($cantidad_enviada>=$cantidad_vendida) {
    $mysql->efectuarConsulta("UPDATE sol.inventario_has_ventas 
    SET sol.inventario_has_ventas.cantidad_enviada = '".$cantidad_vendida."' 
    WHERE sol.inventario_has_ventas.inventario_idinventario = '".$inventario_idinventario."' 
    AND sol.inventario_has_ventas.ventas_idventas = '".$ventas_idventas."' 
    AND sol.inventario_has_ventas.cantidad_vendida = '".$cantidad_vendida."' ");

    $mysql->efectuarConsulta("UPDATE sol.inventario_has_ventas 
        SET sol.inventario_has_ventas.estado_domicilio_idestado_domicilio = 3 
        WHERE  sol.inventario_has_ventas.inventario_idinventario='".$inventario_idinventario."' 
        AND sol.inventario_has_ventas.ventas_idventas='".$ventas_idventas."'
        AND sol.inventario_has_ventas.cantidad_vendida='".$cantidad_vendida."'");   
    
}else {
    $mysql->efectuarConsulta("UPDATE sol.inventario_has_ventas 
    SET sol.inventario_has_ventas.cantidad_enviada = '".$cantidad_enviada."' 
    WHERE sol.inventario_has_ventas.inventario_idinventario = '".$inventario_idinventario."' 
    AND sol.inventario_has_ventas.ventas_idventas = '".$ventas_idventas."' 
    AND sol.inventario_has_ventas.cantidad_vendida = '".$cantidad_vendida."' ");

    $mysql->efectuarConsulta("UPDATE sol.inventario_has_ventas 
        SET sol.inventario_has_ventas.estado_domicilio_idestado_domicilio = 1 
        WHERE  sol.inventario_has_ventas.inventario_idinventario='".$inventario_idinventario."' 
        AND sol.inventario_has_ventas.ventas_idventas='".$ventas_idventas."'
        AND sol.inventario_has_ventas.cantidad_vendida='".$cantidad_vendida."'"); 
}
if ($cantidad_enviada<=0) {
    $mysql->efectuarConsulta("UPDATE sol.inventario_has_ventas 
    SET sol.inventario_has_ventas.cantidad_enviada = 0 
    WHERE sol.inventario_has_ventas.inventario_idinventario = '".$inventario_idinventario."' 
    AND sol.inventario_has_ventas.ventas_idventas = '".$ventas_idventas."' 
    AND sol.inventario_has_ventas.cantidad_vendida = '".$cantidad_vendida."' "); 
}
    

    //desconecta la base de datos
    $mysql->desconectar();
?>