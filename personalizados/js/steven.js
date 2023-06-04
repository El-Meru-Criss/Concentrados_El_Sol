
// Funciones Steven
function checkenvio(id_producto,id_venta,estado) {

  Swal.fire({
    title: '¿Verificar domicilio?',
    text: "No podras revocar esta accion, ¿esta seguro?",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Enviado',
    cancelButtonText: 'Cancelar'
  }).then((result) => {



    if (result.isConfirmed) {
      var datos = {
            "id_producto":id_producto,
            "id_venta":id_venta,
            "estado":estado
          }

          $.ajax({
            type: "POST",
            url: "controlador/checkenvio.php",
            data:datos,
            success:function(d){

              Swal.fire(
                'Enviado!',
                'Se ha realizado el domicilio con exito',
                'success'
              );
              tabla_envios();
              
            }
            
            })
    }
  })
}

function eliminarenvio(id_venta) {
  Swal.fire({
    title: '¿Terminar domicilio?',
    text: "No podras revocar esta accion, ¿esta seguro?",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Eliminar',
    cancelButtonText: 'Cancelar'
  }).then((result) => {
    if (result.isConfirmed) {
          var datos = {
            "id_venta":id_venta
          }

          $.ajax({
            type: "POST",
            url: "controlador/terminar_envio.php",
            data:datos,
            success:function(d){

              Swal.fire(
                'Enviado!',
                'Se ha terminado el domicilio con exito',
                'success'
              );

              
              
            }
            
            })
    }
  })
}



function abonar(cantidad_abonada,idventas,cantidad_debida) {

  


  Swal.fire({
    title: 'Abonar a la deuda',
    text: "No podras revocar esta accion, ¿esta seguro?",
    icon: 'warning',
    html: '<input class="form-control" type="number" id="abono">',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Abonar',
    cancelButtonText: 'Cancelar'
  }).then((result) => {

    if (result.isConfirmed) {

      var datos = {
        "abono":$("#abono").val(),
        "cantidad_abonada":cantidad_abonada,
        "idventas":idventas,
        "cantidad_debida":cantidad_debida
      }
      if(document.getElementById("abono").value == ""){
        alert("por favor ingrese la cantidad a abonar");
        document.getElementById("abono").focus();
        return false;
      }
      $.ajax({
        type: "POST",
        url: "controlador/abonar.php",
        data:datos,
        success:function(d){

          Swal.fire(
            'Abonado!',
            'Se ha abonado con exito devolver: ' + d,
            'success'
          );
          tabla_deudores()
          
        }
        
        })

      
    }
  })
}

function eliminardeudor(idventas) {
  Swal.fire({
    title: 'Terminar deuda/deudor',
    text: "No podras revocar esta accion, ¿esta seguro?",
    icon: 'warning',
    
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Terminar deuda',
    cancelButtonText: 'Cancelar'
  }).then((result) => {

    if (result.isConfirmed) {

      var datos = {
        "idventas":idventas
      }

      $.ajax({
        type: "POST",
        url: "controlador/terminar_deuda.php",
        data:datos,
        success:function(d){

          Swal.fire(
            'Terminado!',
            'Se ha terminado la deuda con exito',
            'success'
          );
          tabla_deudores()
          
        }
        
        })

      
    }
  })
}


function tabla_deudores() {

  $.ajax({
    type: "POST",
    url: "controlador/tabla_deudores.php",
    success:function(d) {
        
        $("#tabla_deudores").html(d);
    }
  })
  
}

function tabla_envios() {

  $.ajax({
    type: "POST",
    url: "controlador/tabla_envios.php",
    success:function(d) {
        
        $("#tabla_envios").html(d);

    }
  })
  
}
// Fin funciones Steven