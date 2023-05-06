function Renovar_Productos() { //funcion del criss -----------------------------------
    //asi lo haciamos en clase
    //el codigo de las comillas simples es el code HTML que usted quiere agregar
    //toca ponerlo en una sola linea o sino, no funciona :v
    document.getElementById("Renovar_productos").innerHTML += '<div class="input-group"><select class="form-select" aria-label="Default select example"><option selected="">Productos</option><option value="1">Q.idacat</option><option value="2">Filpo</option><option value="3">Broiler</option></select><input type="number" class="form-control" id="basic-url" placeholder="Kl" aria-describedby="basic-addon3 basic-addon4"><input type="number" class="form-control" id="basic-url" placeholder="Precio" aria-describedby="basic-addon3 basic-addon4"></div>'

}

function Renovar_Productos2() { //funcion del criss -----------------------------------
    //lo mismo de arriba pero hecho de otra forma, con una variable
   let elemento = document.getElementById("Renovar_productos");
   elemento.innerHTML += '<div class="input-group"><select class="form-select" aria-label="Default select example"><option selected="">Productos</option><option value="1">Q.idacat</option><option value="2">Filpo</option><option value="3">Broiler</option></select><input type="number" class="form-control" id="basic-url" placeholder="Kl" aria-describedby="basic-addon3 basic-addon4"><input type="number" class="form-control" id="basic-url" placeholder="Precio" aria-describedby="basic-addon3 basic-addon4"></div>';
}

function Renovar_Productos3() { //funcion del criss -----------------------------------
    //este otro hace lo mismo pero no modifica los anteriores elementos
    //por ejemplo, ami me reseteaba los elementos seleccionados, con este ya todo va bien 
    //ahora que veo, se puede simplificar xd ya lo hago pere
    let Agregar_producto = document.createElement("div"); // crea un nuevo elemento <div>
    Agregar_producto.classList.add("input-group"); // agrega la clase "input-group" al nuevo elemento
    Agregar_producto.innerHTML = '<select class="form-select" aria-label="Default select example"><option selected="">Productos</option><option value="1">Q.idacat</option><option value="2">Filpo</option><option value="3">Broiler</option></select><input type="number" class="form-control" id="basic-url" placeholder="Kl" aria-describedby="basic-addon3 basic-addon4"><input type="number" class="form-control" id="basic-url" placeholder="Precio" aria-describedby="basic-addon3 basic-addon4">'; // agrega el código HTML dentro del nuevo elemento
  
    document.getElementById("Renovar_productos").appendChild(Agregar_producto); // agrega el nuevo elemento como hijo del elemento con el ID "Renovar_productos"
  }

  function Renovar_Productos_def() { //funcion del criss -----------------------------------
    //Lo mismo de arriba, pero mas simplificado
    let Agregar_producto = document.createElement("div"); // crea un nuevo elemento <div>
    Agregar_producto.innerHTML = '<div class="input-group"><select class="form-select" aria-label="Default select example"><option selected="">Productos</option><option value="1">Q.idacat</option><option value="2">Filpo</option><option value="3">Broiler</option></select><input type="number" class="form-control" id="basic-url" placeholder="Kl" aria-describedby="basic-addon3 basic-addon4"><input type="number" class="form-control" id="basic-url" placeholder="Precio" aria-describedby="basic-addon3 basic-addon4"></div>';

    document.getElementById("Renovar_productos").appendChild(Agregar_producto); // agrega el nuevo elemento como hijo del elemento con el ID "Renovar_productos"
  }

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

    var Precios = [];
  
    $('.precio_renovar').each(function() {
      Precios.push($(this).val());
    });
  
    var mensaje = 'Productos: ';

    var total = 0;
  
    for (let i = 0; i < Productos.length; i++) {
      mensaje += Productos[i] + '= ' + cantidad[i] + ' * ' + Precios[i] + ', ';
      total += cantidad[i] * Precios[i];
    }
  
    alert(mensaje);

    var mensaje2 = 'Total a consignar: ' + total;

    document.getElementById("renovar_valor_total").innerHTML = mensaje2;


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

    document.getElementById("renovar_valor_total").innerHTML = mensaje2;
  }

  

  function precio_renovar(precio,id_casilla) {
   var nombre_id = "precio" + id_casilla;
   document.getElementById(nombre_id).value = precio;
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