<?php

function calcularDiferencia($fecha1, $fecha2) {
    // Crear objetos DateTime con las fechas
    $date1 = new DateTime($fecha1);
    $date2 = new DateTime($fecha2);

    // Obtener los timestamps de las fechas
    $timestamp1 = $date1->getTimestamp();
    $timestamp2 = $date2->getTimestamp();

    // Calcular la diferencia en segundos
    $diferencia = $timestamp2 - $timestamp1;

    // Convertir la diferencia en meses y días
    $meses = floor($diferencia / (30 * 24 * 60 * 60));
    $dias = floor(($diferencia) / (24 * 60 * 60));

    return array('meses' => $meses, 'dias' => $dias);
}

// Ejemplo de uso

// $fechaFin = '2023-09-15';

// $resultado = calcularDiferencia($fechaActual, $fechaFin);

// echo $resultado['meses'] . ' meses y ' . $resultado['dias'] . ' días';

//llama a la base de datos con el modelo
require_once '../modelo/mysql.php';
$mysql = new MySQL();

$mysql->conectar();

//toma los valores deseados
$fechaActual = date('Y-m-d');

//realiza la consulta MySQL deseada, y la guarda en una variable

$producto = $mysql->efectuarConsulta("SELECT sol.clientes.nombre,sol.ventas.fecha_venta,
sol.ventas.idventas
FROM sol.inventario_has_ventas
INNER JOIN sol.unidad_medida ON sol.inventario_has_ventas.unidad_medida_idunidad_medida = sol.unidad_medida.idunidad_medida
INNER JOIN sol.inventario ON sol.inventario_has_ventas.inventario_idinventario = sol.inventario.idinventario
INNER JOIN sol.ventas ON sol.inventario_has_ventas.ventas_idventas = sol.ventas.idventas
INNER JOIN sol.clientes ON sol.ventas.clientes_idclientes = sol.clientes.idclientes
INNER JOIN sol.proveedor_has_producto ON sol.inventario.proveedor_has_producto_producto_idproducto = sol.proveedor_has_producto.producto_idproducto
INNER JOIN sol.producto ON sol.proveedor_has_producto.producto_idproducto = sol.producto.idproducto
WHERE sol.ventas.estado_venta_idestado_venta=2 GROUP BY sol.ventas.idventas");

while ($Productos = mysqli_fetch_array($producto)) {
    $comparacion = calcularDiferencia($fechaActual, $Productos['fecha_venta']);
    
    if ($comparacion['dias'] <= -15) {
        ?> 
        
        <div class="input-group p-2">
            <span class="input-group-text col" id="basic-addon1"><?php echo $Productos['nombre'] ?>: </span>
            <button class="btn btn-danger col">plaso excedido por: <?php echo $comparacion['dias'] * -1 - 15 ?> dias</button>  
        </div>
        
        <?php
    }

    

};

//desconecta la base de datos

$mysql->desconectar();



?>