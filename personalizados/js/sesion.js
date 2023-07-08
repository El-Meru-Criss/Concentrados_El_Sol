function sesion() {

    $.ajax({
      type: "POST",
      url: "controlador/sesion.php",
      success:function(d) {
        if (d == "ECHAR") {
          window.location.href = './index.html';
        } else {
          $("#sesion").html(d);
        }
      }
    })
    
  }

  function cerrar_sesion(id,nombre) {
    Swal.fire({
      title: nombre,
      text: "Tu id es: " + id,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      confirmButtonText: 'Salir'
    }).then((result) => {
      if (result.isConfirmed) {
        $.ajax({
          type: "POST",
          url: "controlador/cerrar_sesion.php",
          success:function(d) {
            window.location.href = './index.html';
          }
        })
      }
    })
  }
  
  function registro() {

    var datos = {
      "usuario":$("#usuario").val(),
      // "idcasilla":contador
    }

    $.ajax({
      type: "POST",
      url: "controlador/registro.php",
      data:datos,
      success:function(d) {
  
          if (d == "Si") {

            Swal.fire({
              icon: 'success',
              title: 'Identificado!',
              text: 'Se permitira el ingreso en breves!',
              showConfirmButton: false,
              timer: 1500
            }).then((result) => {
              /* Read more about handling dismissals below */
              if (result.dismiss === Swal.DismissReason.timer) {
                window.location.href = './inventario.html';
              }
            })
            
          } else {

            Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: 'El usuario o contraseña son incorrectas!',
              showConfirmButton: false,
              timer: 1500
            }).then((result) => {
              /* Read more about handling dismissals below */
              if (result.dismiss === Swal.DismissReason.timer) {
                
              }
            })

          }
      }
    })


    
  }