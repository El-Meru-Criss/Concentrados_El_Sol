
  var contador=0;//variable de apoyo para determinar la identidad de cada producto
  function Agregar_producto_renovar() {

    contador += 1;

    var datos = {
      "provedores_renovar":$("#provedores_renovar").val(),
      "idcasilla":contador
    }

    $.ajax({
      type: "POST",
      url: "controlador/Agregar_producto_renovar.php",
      data:datos,
      success:function(d) {
          $("#Renovar_productos").append(d);
      }
    })
    
  }

  function Realizar_Pedido() {
    var Productos = [];
  
    $('.productos_renovar').each(function() {
      Productos.push($(this).val());
    });

    var cantidad = [];
  
    $('.cantidad_renovar').each(function() {
      cantidad.push($(this).val());
    });

    Swal.fire({
      title: 'Realizar Pedido?',
      text: "Podras revocar esta accion despues si deseas!",
      icon: 'info',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Realizar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {

        var datos = {
          "Productos":Productos,
          "cantidad":cantidad,
          "renovar_valor_total":$("#renovar_valor_total").val(),
          "provedores_renovar":$("#provedores_renovar").val(),
        }
    
        $.ajax({
          type: "POST",
          url: "controlador/Realizar_Pedido.php",
          data:datos,
          success:function(d) {
            Swal.fire(
              'Realizado!',
              'Se ha realizado el pedido con exito!',
              'success'
            )
          }
        })
      }
    })
    
  }

  function renovar_valor_total() {
    var cantidad = [];
  
    $('.cantidad_renovar').each(function() {
      cantidad.push($(this).val());
    });

    var Precios = [];
  
    $('.precio_renovar').each(function() {
      Precios.push($(this).val());
    });

    var total = 0;
  
    for (let i = 0; i < cantidad.length; i++) {
      total += cantidad[i] * Precios[i];
    }

    var mensaje2 = 'Total a consignar: ' + total;

    document.getElementById("renovar_valor_total").value = total;
  }

  

  function precio_renovar(precio,id_casilla) {
   var nombre_id = "precio" + id_casilla;
   document.getElementById(nombre_id).value = precio;
  }
  

  function eliminar_inventario() {
    Swal.fire({
      title: 'Eliminar del inventario?',
      text: "No podras revocar esta accion",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Eliminar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {
        Swal.fire(
          'Eliminado!',
          'Se ha eliminado del inventario con exito',
          'success'
        )
      }
    })
  }

  function mostrar_provedores() {

    $.ajax({
      type: "POST",
      url: "controlador/mostrar_proveedores_modal.php",
      success:function(d) {
          
          $("#lista_provedoores").html(d);
      }
    })
    
  }

  function crear_proveedor() {

    var datos = {
      "Nombre_proveedor":$("#Nombre_proveedor").val(),
      "Proveedor_telefono":$("#Proveedor_telefono").val(),
      "Proveedor_banco":$("#Proveedor_banco").val()
    }

    $.ajax({
      type: "POST",
      url: "controlador/crear_proveedor.php",
      data:datos,
      success:function(d) {
        mostrar_provedores();
        Swal.fire(
          'Creado!',
          'Has creado con exito este provvedor!.',
          'success'
        );
        
      }
    })
  }

  function mostrar_provedores_producto() {

    $.ajax({
      type: "POST",
      url: "controlador/mostrar_provedores_producto.php",
      success:function(d) {
          
          $("#proveedores_crear_producto").html(d);
      }
    })
    
  }

  function provedores_renovar() {

    $.ajax({
      type: "POST",
      url: "controlador/provedores_renovar.php",
      success:function(d) {
          
          $("#provedores_renovar").html(d);
      }
    })
    
  }

  function seleccionar_producto() {

    $.ajax({
      type: "POST",
      url: "controlador/seleccionar_producto.php",
      success:function(d) {
          
          $("#seleccionar_producto").html(d);
      }
    })
    
  }

  function crear_producto() {

    var datos = {
      "producto_nombre":$("#producto_nombre").val()
    }

    $.ajax({
      type: "POST",
      url: "controlador/crear_producto.php",
      data:datos,
      success:function(d) {
        Swal.fire(
          'Creado!',
          'Has creado con exito este producto.',
          'success'
        );
        
      }
    })
  }

  function Producto_y_proveedor() {

    var datos = {
      "seleccionar_producto":$("#seleccionar_producto").val(),
      "proveedores_crear_producto":$("#proveedores_crear_producto").val(),
      "producto_precio":$("#producto_precio").val(),
    }

    $.ajax({
      type: "POST",
      url: "controlador/Producto_y_proveedor.php",
      data:datos,
      success:function(d) {
        Swal.fire(
          'Creado!',
          'Has creado con exito este producto.',
          'success'
        );
        
      }
    })
  }

  function eliminar_proveedor(idproveedor) {

    Swal.fire({
      title: 'Descartar este Proveedor?',
      text: "no podras revocar esta opcion",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: 'success',
      confirmButtonText: 'descartar'
    }).then((result) => {
      if (result.isConfirmed) {

        var datos = { //capturo los datos
          "idproveedor":idproveedor
        };
    
        $.ajax({
          type: "POST",
          url: "controlador/eliminar_proveedor.php",
          data:datos,
          success:function(d) {
            Swal.fire(
              'Eliminado!',
              'Has eliminado con exito este proveedor.',
              'success'
            );
            mostrar_provedores();
          }
        })  
      }
    })

    
    
  }