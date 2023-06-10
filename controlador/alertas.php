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
    $dias = floor(($diferencia - ($meses * 30 * 24 * 60 * 60)) / (24 * 60 * 60));

    return array('meses' => $meses, 'dias' => $dias);
}

//llama a la base de datos con el modelo
require_once '../modelo/mysql.php';
$mysql = new MySQL();

$mysql->conectar();

//toma los valores deseados
$fechaActual = date('Y-m-d');

//realiza la consulta MySQL deseada, y la guarda en una variable

$producto = $mysql->efectuarConsulta("SELECT sol.inventario.idinventario, 
sol.producto.nombre_producto, 
sol.inventario.fecha_entrada, 
sol.inventario.fecha_caducidad,
sol.inventario.cantidad,
sol.inventario.stock_minimo 
FROM sol.inventario 
INNER JOIN sol.proveedor_has_producto 
ON sol.proveedor_has_producto.producto_idproducto = sol.inventario.proveedor_has_producto_producto_idproducto 
INNER JOIN sol.producto 
ON sol.producto.idproducto = sol.proveedor_has_producto.producto_idproducto
GROUP BY sol.inventario.idinventario");

$Alertas = 0;

while ($Productos = mysqli_fetch_array($producto)) {
    $comparacion = calcularDiferencia($fechaActual, $Productos['fecha_caducidad']);
    
    if ($comparacion['meses'] <= 0 && $Productos['fecha_caducidad'] != '') {
        $Alertas += 1;
    };

    if ($Productos['cantidad'] <= $Productos['stock_minimo'] && $Productos['stock_minimo'] != '') {
        $Alertas += 1;
    };

};

echo $Alertas;

//desconecta la base de datos

$mysql->desconectar();



?>