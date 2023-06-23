<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $valor_total = $_POST['valor_total'];
    $producto = $_POST['producto'];
    $cantidad = $_POST['cantidad'];
    $vendedor = $_POST['vendedor'];
    $cliente = $_POST['cliente'];
    $unidad = $_POST['unidad'];
    $cantidad_pagada = $_POST['cantidad_pagada'];
    $seleccionar_venta = $_POST['seleccionar_venta'];
    $cantidad_debida = $valor_total - $cantidad_pagada;



    //Inserta los datos en ventas

    $mysql->efectuarConsulta("INSERT INTO sol.ventas 
    VALUES (NULL,'".$valor_total."','".$cliente."',
    '".$vendedor."','".$seleccionar_venta."'
    ,NOW(),'".$cantidad_pagada."')");
    
    //se saca el ID del ultimo pedido creado

    $venta_id = $mysql->efectuarConsulta("SELECT 
    sol.ventas.idventas
    FROM sol.ventas
    ORDER BY sol.ventas.idventas DESC");

    $id = mysqli_fetch_array($venta_id);

    //Se cuentas cuantos productos se van a insertar

    $elementos = count($producto);

    //se inserta los productos

    for ($i=0; $i < $elementos ; $i++) {

        $mysql->efectuarConsulta("INSERT INTO sol.inventario_has_ventas 
        VALUES ('".$producto[$i]."',
        '".$id[0]."',
        '".$cantidad[$i]."',
        NULL,
        NULL,
        '".$unidad[$i]."')");

        $mysql->efectuarConsulta("UPDATE sol.inventario 
        SET sol.inventario.cantidad = sol.inventario.cantidad - '".$cantidad[$i]."'
        WHERE sol.inventario.idinventario = '"  .$producto[$i]."'");

        }

    //se inserta los datos de cartera

    if ($seleccionar_venta == 2)
    {
        $mysql->efectuarConsulta("INSERT INTO sol.cartera 
        VALUES (NULL,'".$cliente."','".$id[0]."',
        '".$cantidad_debida."', 0, NOW(),NOW(), 1)");
    }

    //desconecta la base de datos

    $mysql->desconectar();
?>