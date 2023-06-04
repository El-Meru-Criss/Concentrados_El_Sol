<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $deudores = $mysql->efectuarConsulta("SELECT 
    sol.inventario_has_ventas.ventas_idventas,
    sol.inventario_has_ventas.inventario_idinventario,
    sol.estado_domicilio.nombre_estado,
    sol.clientes.nombre,
    sol.inventario_has_ventas.cantidad_vendida,
    sol.inventario.precio_publico,
    sol.ventas.fecha_venta,
    sol.clientes.idclientes,
    sol.inventario_has_ventas.unidad_medida_idunidad_medida,
    sol.inventario.precio_bulto,
    sol.unidad_medida.nombre AS nombre_unidad,
    sol.ventas.idventas
    FROM sol.inventario_has_ventas
    INNER JOIN sol.unidad_medida ON sol.inventario_has_ventas.unidad_medida_idunidad_medida = sol.unidad_medida.idunidad_medida
    INNER JOIN sol.estado_domicilio ON inventario_has_ventas.estado_domicilio_idestado_domicilio = sol.estado_domicilio.idestado_domicilio
    INNER JOIN sol.ventas ON inventario_has_ventas.ventas_idventas = sol.ventas.idventas
    INNER JOIN sol.clientes ON sol.ventas.clientes_idclientes = sol.clientes.idclientes
    INNER JOIN sol.inventario ON sol.inventario_has_ventas.inventario_idinventario = sol.inventario.idinventario
    WHERE sol.inventario_has_ventas.estado_domicilio_idestado_domicilio=1
    OR sol.inventario_has_ventas.estado_domicilio_idestado_domicilio=3
    GROUP BY sol. inventario_has_ventas.ventas_idventas");
       // $abonado = $mysql->efectuarConsulta("SELECT * FROM sol.cantidad_pagada WHERE sol.cantidad_pagada.dinero >= 0");
        
    $contador = 0;       

?>
<div class="container-fluid m-4"><input type="text" class="form-control me-2 light-table-filter" id="searchInput" placeholder="Buscar..."></div>
<?php //inicio del ciclo para ir colocando HTML 

while ($deud = mysqli_fetch_array($deudores)) { ?>
    
    <div class="accordion-item">
              <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<?php echo $deud['ventas_idventas'] ?>" aria-expanded="false" aria-controls="collapseOne">
                  <?php echo $deud['nombre'] ?> - (<?php echo $deud['fecha_venta'] ?>)
              </h2>
              <div id="collapse<?php echo $deud['ventas_idventas'] ?>" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                <div class="table-responsive">
                    <table class="tabla-deudores">
                        <thead>
                            <tr>
                                <th>Producto</th>
                                <th>Cantidad</th>
                                <th>Unidad de medida</th>
                                <th>precio</th>
                                <th>¿Enviado?</th>
                            </tr>
                        </thead>
                        <tbody>

                            <?php
                                 $compra = $mysql->efectuarConsulta("SELECT sol.clientes.nombre, sol.clientes.idclientes, sol.producto.nombre_producto,
                                 sol.inventario.precio_publico, sol.inventario_has_ventas.cantidad_vendida, sol.ventas.fecha_venta,
                                 sol.inventario_has_ventas.estado_domicilio_idestado_domicilio,
                                 sol.inventario_has_ventas.inventario_idinventario,
                                 sol.inventario_has_ventas.ventas_idventas,
                                 sol.inventario_has_ventas.unidad_medida_idunidad_medida,
                                 sol.inventario.precio_bulto,
                                 sol.unidad_medida.nombre AS nombre_unidad,
                                 sol.ventas.idventas
                                 FROM sol.inventario_has_ventas
                                 INNER JOIN sol.unidad_medida ON sol.inventario_has_ventas.unidad_medida_idunidad_medida = sol.unidad_medida.idunidad_medida
                                 INNER JOIN sol.inventario ON sol.inventario_has_ventas.inventario_idinventario = sol.inventario.idinventario
                                 INNER JOIN sol.ventas ON sol.inventario_has_ventas.ventas_idventas = sol.ventas.idventas
                                 INNER JOIN sol.clientes ON sol.ventas.clientes_idclientes = sol.clientes.idclientes
                                 INNER JOIN sol.proveedor_has_producto ON sol.inventario.proveedor_has_producto_producto_idproducto = sol.proveedor_has_producto.producto_idproducto
                                 INNER JOIN sol.producto ON sol.proveedor_has_producto.producto_idproducto = sol.producto.idproducto
                                 WHERE sol.inventario_has_ventas.ventas_idventas= '".$deud['ventas_idventas']."'
                                 AND (sol.inventario_has_ventas.estado_domicilio_idestado_domicilio=1
                                 OR sol.inventario_has_ventas.estado_domicilio_idestado_domicilio=3) 
                                  ");

                                  
                                 while ($comp = mysqli_fetch_array($compra)) { $contador += 1; 
                            ?>
                                <tr>
                                
                                    <td><?php echo $comp['nombre_producto'] ?></td>
                                    <td><?php echo $comp['cantidad_vendida'] ?></td>
                                    <td><?php echo $comp['nombre_unidad'] ?></td>
                                    <?php if ($comp['unidad_medida_idunidad_medida'] == 1) { ?>
                                        <td><?php echo $comp['precio_publico'] ?></td>
                                    <?php } if ($comp['unidad_medida_idunidad_medida'] == 2) { ?>
                                        <td><?php echo $comp['precio_bulto'] ?></td>
                                    <?php } ?>
                                    
                                    <td>
                                    <input type="checkbox" id="checkenvio<?php echo $contador ?>" onclick="checkenvio(<?php echo $comp['inventario_idinventario'] ?>,<?php echo $comp['ventas_idventas'] ?>,<?php echo $comp['estado_domicilio_idestado_domicilio'] ?> )" 
                                    <?php if ($comp['estado_domicilio_idestado_domicilio'] == 3) { ?>
                                        checked
                                    <?php } ?>
                                    >
                                    </td> 
                                    
                                </tr>
                                   
                            <?php  }
                            ?>
                        </tbody>
                        <tfoot>
                            
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            
                        </tr>
                        <tr>
                            <button class="btn btn-danger" onclick="eliminarenvio(<?php echo $deud['ventas_idventas'] ?>)">Todo enviado</button>
                        </tr>
                        </tfoot>
                    </table>                
                </div>
               </div>
            </div>

<?php } //fin del ciclo
?>
    <script>
    const searchInput = document.getElementById('searchInput');
    const searchResults = document.getElementById('searchResults');

    searchInput.addEventListener('input', handleSearch);

    function handleSearch() {
        const searchTerm = searchInput.value.toLowerCase();

        const accordions = document.getElementsByClassName('accordion-item');

        for (let i = 0; i < accordions.length; i++) {
        const accordionHeader = accordions[i].querySelector('.accordion-header');
        const itemName = accordionHeader.textContent.toLowerCase();

        if (searchTerm === '' || itemName.includes(searchTerm)) {
            accordions[i].style.display = 'block';
        } else {
            accordions[i].style.display = 'none';
        }
        }
    }
    </script>
<?php //desconecta la base de datos
    $mysql->desconectar();
?>