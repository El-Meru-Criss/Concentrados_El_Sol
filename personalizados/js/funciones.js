
  var contador=0;//variable de apoyo para determinar la identidad de cada producto
  function Agregar_producto_renovar() {

    contador += 1;

    var datos = {
      "provedores_renovar":$("#provedores_renovar").val(),
      "idcasilla":contador
    }

    var proveedor = $("#provedores_renovar").val();

    if (proveedor == "") {
      alert("Debes de elegir un proveedor primero");      
    } else {
      $.ajax({
        type: "POST",
        url: "controlador/Agregar_producto_renovar.php",
        data:datos,
        success:function(d) {
            $("#Renovar_productos").append(d);
        }
      })
    }
    
  }

  function Refrescar_seleccion() {
    $("#Renovar_productos").html("");
    $("#renovar_valor_total").val("");
  }

  function Realizar_Pedido() {
    var Productos = [];
    var validacion = 0;
  
    $('.productos_renovar').each(function() {
      Productos.push($(this).val());
      if ($(this).val() != "") {
        validacion += 1;
      }
    });

    var cantidad = [];
  
    $('.cantidad_renovar').each(function() {
      cantidad.push($(this).val());
    });

    if (validacion == 0) {
      alert("Se debe seleccionar almenos un producto!");
    } else {

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

          Refrescar_seleccion();
          $("#provedores_renovar").html("");

        }
      })

    }

    
    
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

  

  function precio_renovar(id_casilla) {
   var nombre_id = "precio" + id_casilla;
   var producto_id = "producto" + id_casilla;
   var precio = 0
   precio = $("#" + producto_id + " option:selected").attr("data-precio");
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

    Refrescar_seleccion();
    
  }

  function pedidos_proveedores() {

    $.ajax({
      type: "POST",
      url: "controlador/pedidos_proveedores.php",
      success:function(d) {
          
          $("#Contenido_inventario").html(d);
      }
    })
    
  }

  function productos_pedidos(id_acordeon) {
    var tabla = 'tabla' + id_acordeon;

    var datos = {
      "id_acordeon":id_acordeon
    }

    $.ajax({
      type: "POST",
      url: "controlador/productos_pedidos.php",
      data:datos,
      success:function(d) {
        $("#"+tabla).html(d);
        
      }
    })
  }

  function recibir_pedido(id_pedido) {

    Swal.fire({
      title: 'Recibir el pedido?',
      text: "no podras revocar esta opcion",
      icon: 'warning',
      showCancelButton: true,
      //confirmButtonColor: '#d33',
      cancelButtonColor: 'success',
      confirmButtonText: 'Recibir'
    }).then((result) => {
      if (result.isConfirmed) {

        var datos = { //capturo los datos
          "id_pedido":id_pedido
        };
    
        $.ajax({
          type: "POST",
          url: "controlador/recibir_pedido.php",
          data:datos,
          success:function(d) {
            
            Swal.fire(
               'Recibido!',
               'Los productos se han agregado al inventario.',
               'success'
            );
            pedidos_proveedores();
          }
        })  
      }
    })

  }

  function tabla_inventario() {

    $.ajax({
      type: "POST",
      url: "controlador/tabla_inventario.php",
      success:function(d) {
          
          $("#Contenido_inventario").html(d);
          alertas();
      }
    })
    
  }

  function precioKL_inventario(id_inventario) {
    var input_id = "precio_kl" + id_inventario;
    var precio_kl = $("#" + input_id).val();

    
    var datos = {
      "id_inventario":id_inventario,
      "precio_kl":precio_kl
    }

    $.ajax({
      type: "POST",
      url: "controlador/precioKL_inventario.php",
      data:datos,
      success:function(d) {
        
      }
    })
   
  }

  function precioBL_inventario(id_inventario) {
    var input_id = "precio_bulto" + id_inventario;
    var precio_bulto = $("#" + input_id).val();

    
    var datos = {
      "id_inventario":id_inventario,
      "precio_bulto":precio_bulto
    }

    $.ajax({
      type: "POST",
      url: "controlador/precioBL_inventario.php",
      data:datos,
      success:function(d) {
        
      }
    })
   
  }

  function F_vencimiento(id_inventario) {
    var input_id = "F_vencimiento" + id_inventario;
    var F_vencimiento = $("#" + input_id).val();

    

    var datos = {
      "id_inventario":id_inventario,
      "F_vencimiento":F_vencimiento
    }

    $.ajax({
      type: "POST",
      url: "controlador/F_vencimiento.php",
      data:datos,
      success:function(d) {
        alertas();
      }
    })
   
  }

  function StockMinimo(id_inventario) {
    var input_id = "StockMinimo" + id_inventario;
    var StockMinimo = $("#" + input_id).val();

    

    var datos = {
      "id_inventario":id_inventario,
      "StockMinimo":StockMinimo
    }

    $.ajax({
      type: "POST",
      url: "controlador/StockMinimo.php",
      data:datos,
      success:function(d) {
        alertas();
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
      "producto_nombre":$("#producto_nombre").val(),
      "peso_producto":$("#peso_producto").val()
    };

    var producto = $("#producto_nombre").val();
    var peso = $("#peso_producto").val();

    if (producto == "" || peso == "") {
      alert("No se ha especificado el Nombre de producto o Peso :/");
    } else {

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

          document.getElementById("producto_nombre").value = "";
          document.getElementById("peso_producto").value = "";
          
        }
      })

    }

  }

  function Producto_y_proveedor() {

    var datos = {
      "seleccionar_producto":$("#seleccionar_producto").val(),
      "proveedores_crear_producto":$("#proveedores_crear_producto").val(),
      "producto_precio":$("#producto_precio").val(),
    }

    var producto = $("#seleccionar_producto").val();
    var proveedor = $("#proveedores_crear_producto").val();
    var precio = $("#producto_precio").val();

    if (precio == "" || proveedor == "" || producto == "") {
      alert("El producto, proveedor o precio esta vacio :/")
    } else {
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
          document.getElementById("producto_precio").value = "";
          document.getElementById("proveedores_crear_producto").innerHTML = "";
          document.getElementById("seleccionar_producto").innerHTML = "";
          
        }
      })
    }

    
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

  function info_proveedor(idproveedor) {
    var datos = { //capturo los datos
      "idproveedor":idproveedor
    };

    $.ajax({
      type: "POST",
      url: "controlador/info_proveedor.php",
      data:datos,
      success:function(d) {
        $("#editar_proveedores").html(d);
      }
    }) 
  }

  function editar_proveedor() {
    var datos = { //capturo los datos
      "id_proveedor_edit":$("#id_proveedor_edit").val(),
      "Nombre_proveedor_editar":$("#Nombre_proveedor_editar").val(),
      "Proveedor_telefono_edit":$("#Proveedor_telefono_edit").val(),
      "Proveedor_banco_edit":$("#Proveedor_banco_edit").val()
    };

    var Nombre = $("#Nombre_proveedor_editar").val();

    if (Nombre == "") {
      alert("Se requiere almenos un nombre");
    } else {
      $.ajax({
        type: "POST",
        url: "controlador/editar_proveedor.php",
        data:datos,
        success:function(d) {
          Swal.fire(
            'Editado!',
            'Has editado con exito este proveedor.',
            'success'
          );
          mostrar_provedores();     
        }
      })
    }
 
  }

  function crear_proveedor() {

    var datos = {
      "Nombre_proveedor":$("#Nombre_proveedor").val(),
      "Proveedor_telefono":$("#Proveedor_telefono").val(),
      "Proveedor_banco":$("#Proveedor_banco").val()
    }

    var Nombre = $("#Nombre_proveedor").val();

    if (Nombre == "") {
      alert ("Se requiere un nombre");
    } else {
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

  }

  function alertas() {

    $.ajax({
      type: "POST",
      url: "controlador/alertas.php",
      success:function(d) {
        $('#Numero_alertas').html(d);
      }
    })
    
  }

  function MostrarAlertas() {

    $.ajax({
      type: "POST",
      url: "controlador/MostrarAlertas.php",
      success:function(d) {
        $('#MostrarAlertas').html(d);
      }
    })
    
  }