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

    $.ajax({
      type: "POST",
      url: "controlador/menu_usuario.php",
      success:function(d) {

        Swal.fire({
          html: d,
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
    })
    
  }
  
  function registro() {

    var datos = {
      "usuario":$("#usuario").val(),
      "contraseña":$("#contraseña").val()
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
                window.location.href = './ventas.html';
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