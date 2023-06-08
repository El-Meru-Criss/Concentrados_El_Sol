var contador=0;//variable de apoyo para determinar la identidad de cada producto

  function agregar_Productos_def() { //funcion del criss -----------------------------------
    //Lo mismo de arriba, pero mas simplificado
    contador += 1;
    var datos = {
      "producto":$("#producto").val(),
      "idcasilla":contador
    }
    $.ajax({
      type: "POST",
      url: "controlador/seleccionar_producto_ven.php",
      data:datos,
      success:function(d) {
          $("#producto").append(d);
      }
    })
    }

    $(document).ready(function() {
      $("#botonEliminar").click(eliminar_Productos_def);
    });
    
    function eliminar_Productos_def() {
      // Obtén el contador actual o ajústalo según tus necesidades
      var contadorE = obtenerContadorActual();
      
      if (contadorE >= 1) {
        // Selecciona y elimina solo el último elemento creado
        var ultimoElemento = contadorE;
        var producto = $("#producto" + ultimoElemento).val();
        var unidadMedida = $("#unidad_medida" + ultimoElemento).val();
        var cantidad = $("#cantidad" + ultimoElemento).val();
        var precio = $("#precio" + ultimoElemento).val();
        
        // Verifica si los elementos están vacíos antes de eliminarlos
        if (producto === "" && unidadMedida === "" && cantidad === "") {
          $("#producto" + ultimoElemento).remove();
          $("#unidad_medida" + ultimoElemento).remove();
          $("#cantidad" + ultimoElemento).remove();
          $("#precio" + ultimoElemento).remove();
          
          // Disminuye el contador en 1
          contadorE -= 1;
          actualizarContador(contadorE);
        }
      }
    }

    function obtenerContadorActual() {
      return contador;
    }

    function actualizarContador(contadorE) {
      if(contadorE>0){
        contador = contadorE;
      }
    }

  function revelar_tabla() {
    $.get("./Elementos-Ocultos/tabla.html", function(data) {
      $("#Prueba_tablaOculta").html(data);
    });
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

function AgregarVendedor() {
  if(document.getElementById("vendedor_nombre").value == ""){alert("por favor ingrese un nombre");document.getElementById("vendedor_nombre").focus();return false;}
  else{
  var datos = {
    "vendedor_nombre":$("#vendedor_nombre").val()
  }

  $.ajax({
    type: "POST",
    url: "controlador/agregar_vendedor.php",
    data:datos,
    success:function(d) {
      Swal.fire(
        'Creado!',
        'Has creado con exito el nuevo vendedor.',
        'success'
      );
      
    }
    })
  }
}

function mostrar_vendedores() {

  $.ajax({
    type: "POST",
    url: "controlador/mostrar_vendedores.php",
    success:function(d) {
        
        $("#lista_vendedores").html(d);
    }
  })
  
}

function eliminar_vendedor(idvendedores) {

  Swal.fire({
    title: 'Descartar este vendedor?',
    text: "no podras revocar esta opcion",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: 'success',
    confirmButtonText: 'descartar'
  }).then((result) => {
    if (result.isConfirmed) {

      var datos = { //capturo los datos
        "idvendedores":idvendedores
      };
  
      $.ajax({
        type: "POST",
        url: "controlador/eliminar_vendedor.php",
        data:datos,
        success:function(d) {
          Swal.fire(
            'Eliminado!',
            'Has eliminado con exito este vendedor.',
            'success'
          );
          mostrar_vendedores();
        }
      })  
    }
  })
  }

  function mostrar_datos_vendedor(idvendedores) {
    var datos = { //capturo los datos
      "idvendedores":idvendedores
    };
    $.ajax({
      type: "POST",
      url: "controlador/mostrar_datos_vendedor.php",
      data:datos,
      success:function(d) {
          
          $("#mostrar_datos_vendedor").html(d);
      }
    })
    
  }

  function EditarVendedor(idvendedores) {
    if($("#vendedor_nombre_edi").val() == "")
    {alert("por favor ingrese un nombre");document.getElementById("vendedor_nombre_edi").focus();
    return false;}
    else{
      Swal.fire({
        title: 'editar este vendedor?',
        text: "no podras revocar esta opcion",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: 'success',
        confirmButtonText: 'aceptar'
      }).then((result) => {
        if (result.isConfirmed) {
    
          var datos = { //capturo los datos
            "idvendedores":idvendedores,
            "vendedor_nombre":$("#vendedor_nombre_edi").val()
          };
      
          $.ajax({
            type: "POST",
            url: "controlador/editar_vendedor.php",
            data:datos,
            success:function(d) {
              Swal.fire(
                'editado!',
                'Has editado con exito este vendedor.',
                'success'
              );
              mostrar_vendedores();
            }
          }) 
          location.reload() 
        }
      })
    }
  }

  function seleccionar_vendedor() {

    $.ajax({
      type: "POST",
      url: "controlador/seleccionar_vendedor.php",
      success:function(d) {
          
          $("#seleccionar_vendedor").html(d);
      }
    })

  }

  function seleccionar_producto_ven() {

    $.ajax({
      type: "POST",
      url: "controlador/seleccionar_producto_ven.php",
      success:function(d) {
          
          $("#seleccionar_producto_ven").html(d);
      }
    })
    
  }

  function valor_total() {
    var cantidad = [];
  
    $('.cantidad').each(function() {
      cantidad.push($(this).val());
    });

    var Precios = [];
  
    $('.precio').each(function() {
      Precios.push($(this).val());
    });

    var total = 0;
  
    for (let i = 0; i < cantidad.length; i++) {
      total += cantidad[i] * Precios[i];
    }

    var mensaje2 = 'Total a consignar: ' + total;

    document.getElementById("valor_total").value = total;
  }

  function precio_renovar(id_casilla) {
    var nombre_id = "precio" + id_casilla;
    var producto_id = "producto" + id_casilla;
    var cantidad_id = "cantidad" + id_casilla;
    var precio = 0;
    var cantidad=0; 
    var idunidad_medida = "unidad_medida" + id_casilla;
    var idmedida = document.getElementById(idunidad_medida).value;
    if(idmedida == 1)
    {
      precio = $("#" + producto_id + " option:selected").attr("data-precio");
    }
    if(idmedida == 2)
    {
      precio = $("#" + producto_id + " option:selected").attr("data-bulto");
    }
    document.getElementById(nombre_id).value = precio;
    cantidad = $("#" + producto_id + " option:selected").attr("data-cantidad");
    document.getElementById(cantidad_id).max=cantidad;
   }

   function seleccionar_cliente() {

    $.ajax({
      type: "POST",
      url: "controlador/seleccionar_cliente.php",
      success:function(d) {
          
          $("#seleccionar_cliente").html(d);
      }
    })
    
  }

  function AgregarCliente() {
    if(document.getElementById("cliente_nombre").value == ""){alert("por favor ingrese un nombre");document.getElementById("cliente_nombre").focus();return false;}
    else{
    var datos = {
      "cliente_nombre":$("#cliente_nombre").val(),
      "cliente_telefono":$("#cliente_telefono").val(),
      "cliente_direccion":$("#cliente_direccion").val(),
      "email":$("#email").val(),
      "documento":$("#documento").val()
    }
  
    $.ajax({
      type: "POST",
      url: "controlador/agregar_cliente.php",
      data:datos,
      success:function(d) {
        Swal.fire(
          'Creado!',
          'Has creado con exito el nuevo cliente.',
          'success'
        );
        
      }
      })
    }
  }

  function mostrar_clientes() {

    $.ajax({
      type: "POST",
      url: "controlador/mostrar_clientes.php",
      success:function(d) {
          
          $("#lista_clientes").html(d);
      }
    })
    
  }

  function eliminar_cliente(idclientes) {

    Swal.fire({
      title: 'Descartar este cliente?',
      text: "no podras revocar esta opcion",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: 'success',
      confirmButtonText: 'descartar'
    }).then((result) => {
      if (result.isConfirmed) {
  
        var datos = { //capturo los datos
          "idclientes":idclientes
        };
    
        $.ajax({
          type: "POST",
          url: "controlador/eliminar_cliente.php",
          data:datos,
          success:function(d) {
            Swal.fire(
              'Eliminado!',
              'Has eliminado con exito este cliente.',
              'success'
            );
            mostrar_clientes();
          }
        })  
      }
    })
    }

    function mostrar_datos_cliente(idclientes) {
      var datos = { //capturo los datos
        "idclientes":idclientes
      };
      $.ajax({
        type: "POST",
        url: "controlador/mostrar_datos_cliente.php",
        data:datos,
        success:function(d) {
            
            $("#mostrar_datos_cliente").html(d);
        }
      })
      
    }

    function EditarCliente(idcliente) {
      if($("#cliente_nombre_edi").val() == "")
      {alert("por favor ingrese un nombre");document.getElementById("cliente_nombre_edi").focus();
      return false;}
      if($("#cliente_nombre_edi").val() == "")
      {alert("por favor ingrese un nombre");document.getElementById("cliente_nombre_edi").focus();
      return false;}
      else{
        Swal.fire({
          title: 'editar este cliente?',
          text: "no podras revocar esta opcion",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#d33',
          cancelButtonColor: 'success',
          confirmButtonText: 'descartar'
        }).then((result) => {
          if (result.isConfirmed) {
      
            var datos = { //capturo los datos
              "idcliente":idcliente,
              "cliente_nombre":$("#cliente_nombre_edi").val()
            };
        
            $.ajax({
              type: "POST",
              url: "controlador/editar_cliente.php",
              data:datos,
              success:function(d) {
                Swal.fire(
                  'editado!',
                  'Has editado con exito este cliente.',
                  'success'
                );
                mostrar_clientes();
              }
            }) 
            location.reload() 
          }
        })
      }
    }
  

    function seleccionar_venta() {

      $.ajax({
        type: "POST",
        url: "controlador/seleccionar_venta.php",
        success:function(d) {
            
            $("#seleccionar_venta").html(d);
        }
      })
      
    }

   function Realizar_venta() {
    if(document.getElementById("seleccionar_vendedor").value == ""){alert("por favor seleccione un vendedor");document.getElementById("seleccionar_vendedor").focus();return false;}
    if(document.getElementById("seleccionar_cliente").value == ""){alert("por favor seleccione un cliente");document.getElementById("seleccionar_cliente").focus();return false;}
    if(document.getElementById("seleccionar_venta").value == ""){alert("por favor seleccione el tipo de venta");document.getElementById("seleccionar_venta").focus();return false;}
    if(document.getElementById("valor_total").value == ""){alert("por favor haga click en Agregar y seleciona un producto, una unidad de medida y escribe una cantidad");document.getElementById("agregar").focus();return false;}
    if(document.getElementById("valor_total").value == 0){alert("por favor escribe una cantidad mayor que 0 para el producto que se va a vender");document.getElementById("agregar").focus();return false;}
    if(document.getElementById("cantidad_pagada").value == ""){alert("por favor escriba la cantidad pagada por el cliente");document.getElementById("cantidad_pagada").focus();return false;}
    if(document.getElementById("seleccionar_venta").value == 1 && parseFloat(document.getElementById("valor_total").value) >= parseFloat(document.getElementById("cantidad_pagada").value)){alert("por favor seleccione que el tipo de venta es a credito");document.getElementById("seleccionar_venta").focus();return false;}
    if(document.getElementById("seleccionar_venta").value == 2 && parseFloat(document.getElementById("valor_total").value) <= parseFloat(document.getElementById("cantidad_pagada").value)){alert("por favor seleccione que el tipo de venta es a contado");document.getElementById("seleccionar_venta").focus();return false;}
    else{
    var producto = [];
  
    $('.producto').each(function() {
      producto.push($(this).val());
    });

    var unidad = [];
  
    $('.unidad').each(function() {
      unidad.push($(this).val());
    });

    var cantidad = [];
  
    $('.cantidad').each(function() {
      cantidad.push($(this).val());
    });

    Swal.fire({
      title: 'Realizar venta?',
      text: "Podrás revocar esta acción después si deseas!",
      icon: 'info',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Realizar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
      if (result.isConfirmed) {

        var datos = {
          "vendedor":$("#seleccionar_vendedor").val(),
          "cliente":$("#seleccionar_cliente").val(),
          "producto":producto,
          "unidad":unidad,
          "cantidad":cantidad,
          "valor_total":$("#valor_total").val(),
          "cantidad_pagada":$("#cantidad_pagada").val(),
          "seleccionar_venta":$("#seleccionar_venta").val(),
        }
    
        $.ajax({
          type: "POST",
          url: "controlador/realizar_venta.php",
          data:datos,
          success:function(d) {
            Swal.fire(
              'Realizado!',
              'Se ha realizado el venta con exito!',
              'success',
              
            );
          }
        })
        location.reload()
      }
    })
    }
  }

function Realizar_domicilio() {

  var valor_total = document.getElementById("valor_total").value;

  if(document.getElementById("seleccionar_vendedor").value == ""){alert("por favor seleccione un vendedor");document.getElementById("seleccionar_vendedor").focus();return false;}
    if(document.getElementById("seleccionar_cliente").value == ""){alert("por favor seleccione un cliente");document.getElementById("seleccionar_cliente").focus();return false;}
    if(document.getElementById("seleccionar_venta").value == ""){alert("por favor seleccione el tipo de venta");document.getElementById("seleccionar_venta").focus();return false;}
    if(document.getElementById("valor_total").value == ""){alert("por favor agregue click a agregar y seleciona un producto, una unidad de medida y escribe una cantidad");document.getElementById("agregar").focus();return false;}
    if(document.getElementById("cantidad_pagada").value == ""){alert("por favor escriba la cantidad pagada por el cliente");document.getElementById("cantidad_pagada").focus();return false;}
    if(document.getElementById("seleccionar_venta").value == 1 && parseFloat(document.getElementById("valor_total").value) > parseFloat(document.getElementById("cantidad_pagada").value)){alert("por favor seleccione que el tipo de venta es a credito");document.getElementById("seleccionar_venta").focus();return false;}
    if(document.getElementById("seleccionar_venta").value == 2 && parseFloat(document.getElementById("valor_total").value) <= parseFloat(document.getElementById("cantidad_pagada").value)){alert("por favor seleccione que el tipo de venta es a contado");document.getElementById("seleccionar_venta").focus();return false;}
    else{

  var producto = [];

  $('.producto').each(function() {
    producto.push($(this).val());
  });

  var unidad = [];

  $('.unidad').each(function() {
    unidad.push($(this).val());
  });

  var cantidad = [];

  $('.cantidad').each(function() {
    cantidad.push($(this).val());
  });

  Swal.fire({
    title: 'Realizar venta?',
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
        "vendedor":$("#seleccionar_vendedor").val(),
        "cliente":$("#seleccionar_cliente").val(),
        "producto":producto,
        "unidad":unidad,
        "cantidad":cantidad,
        "valor_total":$("#valor_total").val(),
        "cantidad_pagada":$("#cantidad_pagada").val(),
        "seleccionar_venta":$("#seleccionar_venta").val(),
      }
  
      $.ajax({
        type: "POST",
        url: "controlador/realizar_domicilio.php",
        data:datos,
        success:function(d) {
          Swal.fire(
            'Realizado!',
            'Se ha realizado la venta con èxito!',
            'success'
          );
          
        }
      })
    }
    })
    }
  }

function tabla_historial_venta() {

  $.ajax({
    type: "POST",
    url: "controlador/tabla_historial_venta.php",
    success:function(d) {
        
        $("#tabla_historial_venta").html(d);
    }
  })
  
}

function validar_cantidad(id_casilla) { 
  var producto_id = "producto" + id_casilla;
  var cantidad_id = "cantidad" + id_casilla;
  var unidad_medida_id = "unidad_medida" + id_casilla;

  if ( $("#" + producto_id).val() == "") {
    alert("Selecciona un producto primero");
    $("#" + cantidad_id).val("");
    document.getElementById(unidad_medida_id).selectedIndex = 0;
  }
  valor_total();

  }

function validar_duplicacion(id_casilla) {
  var producto_id = "producto" + id_casilla;
  var unidad_medida_id = "unidad_medida" + id_casilla;
  
  var Productos = [];
  var unidad_medida = [];

  $('.producto').each(function() {
    Productos.push($(this).val());
  });
  $('.unidad').each(function() {
    unidad_medida.push($(this).val());
  });

  for (let i = 0; i < Productos.length; i++) {
    for (let j = 0; j < unidad_medida.length; j++) {
      if ($("#" + producto_id).val() == Productos[i] &&
          i != (id_casilla - 1) &&
          $("#" + producto_id).val() != "" &&
          $("#" + unidad_medida_id).val() == unidad_medida[j] &&
          j != (id_casilla - 1) &&
          $("#" + unidad_medida_id).val() != "") {
        alert("¡Ya se ha seleccionado ese producto y con esa unidad de medida!");
        document.getElementById(producto_id).selectedIndex = 0;
        document.getElementById(unidad_medida_id).selectedIndex = 0;
      }
    }
  }
}