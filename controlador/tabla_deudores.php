<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $deudores = $mysql->efectuarConsulta("SELECT sol.clientes.nombre, sol.clientes.idclientes, sol.producto.nombre_producto,
	sol.inventario.precio_publico, sol.inventario_has_ventas.cantidad_vendida, sol.producto.nombre_producto, sol.ventas.fecha_venta,
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
    WHERE sol.ventas.estado_venta_idestado_venta=2 GROUP BY sol.ventas.idventas");

        $abonado = $mysql->efectuarConsulta("SELECT * FROM sol.cantidad_pagada WHERE sol.cantidad_pagada.dinero >= 0");
        

?>
<div class="container-fluid m-4"><input type="text" class="form-control me-2 light-table-filter" id="searchInput" placeholder="Buscar..."></div>
<?php //inicio del ciclo para ir colocando HTML

while ($deud = mysqli_fetch_array($deudores)) { ?>

    <div class="accordion-item">
              <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<?php echo $deud['idventas'] ?>" aria-expanded="false" aria-controls="collapseOne">
                  <?php echo $deud['nombre'] ?> - (<?php echo $deud['fecha_venta'] ?>)
                </button>
              </h2>
              <div id="collapse<?php echo $deud['idventas'] ?>" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                <div class="table-responsive">
                    <table class="tabla-deudores">
                        <thead>
                            <tr>
                                <th>Producto</th>
                                <th>Cantidad</th>
                                <th>Unidad de medida</th>
                                <th>Precio</th>
                                
                            </tr>
                        </thead>
                        <tbody>

                            <?php
                                $compra = $mysql->efectuarConsulta("SELECT sol.clientes.idclientes, sol.producto.nombre_producto,
                                sol.inventario.precio_publico, sol.inventario_has_ventas.cantidad_vendida, sol.ventas.fecha_venta,
                                sol.inventario_has_ventas.unidad_medida_idunidad_medida,
                                sol.unidad_medida.nombre AS nombre_unidad,sol.inventario.precio_bulto
                                FROM sol.inventario_has_ventas
                                INNER JOIN sol.unidad_medida ON sol.inventario_has_ventas.unidad_medida_idunidad_medida = sol.unidad_medida.idunidad_medida
                                INNER JOIN sol.inventario ON sol.inventario_has_ventas.inventario_idinventario = sol.inventario.idinventario
                                INNER JOIN sol.ventas ON sol.inventario_has_ventas.ventas_idventas = sol.ventas.idventas
                                INNER JOIN sol.clientes ON sol.ventas.clientes_idclientes = sol.clientes.idclientes
                                INNER JOIN sol.proveedor_has_producto ON sol.inventario.proveedor_has_producto_producto_idproducto = sol.proveedor_has_producto.producto_idproducto
                                INNER JOIN sol.producto ON sol.proveedor_has_producto.producto_idproducto = sol.producto.idproducto
                                WHERE sol.ventas.estado_venta_idestado_venta=2 AND sol.ventas.idventas= '".$deud['idventas']."' 
                                GROUP BY sol.unidad_medida.idunidad_medida, sol.inventario.idinventario");
                                while ($comp = mysqli_fetch_array($compra)) {
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
                                    

                                </tr>
                            <?php } ?>
                        </tbody>
                        <tfoot>

                        <tr>
                            <td>Total</td>
                            <?php

                            $total = $mysql->efectuarConsulta("SELECT  sol.cartera.cantidad_debida AS total_deuda,
                            sol.cartera.cantidad_abonada AS abonado
                            FROM sol.cartera
                            INNER JOIN sol.clientes ON sol.cartera.clientes_idclientes = sol.clientes.idclientes
                            INNER JOIN sol.ventas ON sol.cartera.ventas_idventas = sol.ventas.idventas
                            WHERE sol.ventas.estado_venta_idestado_venta=2 AND sol.ventas.idventas= '".$deud['idventas']."'  GROUP BY sol.ventas.idventas");


                            while ($tot = mysqli_fetch_array($total)) { ?>
                            <td><?php echo $tot['total_deuda'] ?></td>
                            <?php } ?>

                            <td>Abonado</td>
                            <?php
                             $total = $mysql->efectuarConsulta("SELECT  sol.cartera.cantidad_debida AS total_deuda,
                             sol.cartera.cantidad_abonada AS abonado
                             FROM sol.cartera
                             INNER JOIN sol.clientes ON sol.cartera.clientes_idclientes = sol.clientes.idclientes
                             INNER JOIN sol.ventas ON sol.cartera.ventas_idventas = sol.ventas.idventas
                             WHERE sol.ventas.estado_venta_idestado_venta=2 AND sol.ventas.idventas= '".$deud['idventas']."'  GROUP BY sol.ventas.idventas"); 
                            while ($abon = mysqli_fetch_array($total)) { ?>
                            <td><?php echo $abon['abonado'] ?></td>
                            <?php } ?>
                            
                            



                        </tr>
                        <tr>
                            <?php   
                                
                                    $abona = $mysql->efectuarConsulta("SELECT  sol.cartera.cantidad_debida,
                                    sol.cartera.cantidad_abonada, sol.ventas.idventas
                                    FROM sol.cartera
                                    INNER JOIN sol.clientes ON sol.cartera.clientes_idclientes = sol.clientes.idclientes
                                    INNER JOIN sol.ventas ON sol.cartera.ventas_idventas = sol.ventas.idventas
                                    WHERE sol.ventas.estado_venta_idestado_venta=2 AND sol.ventas.idventas= '".$deud['idventas']."'  GROUP BY sol.ventas.idventas");

                                    
                                    
                             while ($abon = mysqli_fetch_array($abona)) { ?>
                            <?php  
                                    $abono_t = $abon['cantidad_abonada'];
                                    $debido_t = $abon['cantidad_debida'];
                                if($abono_t != $debido_t) {
                            ?>
                            <button type="button" class="btn btn-success m-1" onclick="abonar(<?php echo $abon['cantidad_abonada'] ?>, <?php echo $abon['idventas'] ?>,<?php echo $abon['cantidad_debida'] ?> )">Abonar</button>
                            <?php
                                } 
                            ?>
                            

                            <?php  
                                    $abono_t = $abon['cantidad_abonada'];
                                    $debido_t = $abon['cantidad_debida'];
                                if($abono_t == $debido_t) {
                            ?>
                                <button type="button" class="btn btn-danger m-1" onclick="eliminardeudor(<?php echo $deud['idventas'] ?>)">Terminar deuda</button>
                            <?php
                                } 
                            ?>



                            <?php } 
                               
                            ?>
                                
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