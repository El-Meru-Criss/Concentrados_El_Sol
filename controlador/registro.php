<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $cc = $_POST['usuario'];
    $contraseña = $_POST['contraseña'];
    $ingresa = "No";
    
    //realiza la consulta MySQL deseada, y la guarda en una variable

    $existencia = $mysql->efectuarConsulta("SELECT sol.vendedores.idvendedores, 
    sol.vendedores.nombre,
    sol.vendedores.CC,
    sol.vendedores.contraseña,
    sol.vendedores.rol
    FROM sol.vendedores 
    WHERE sol.vendedores.contraseña = '".$contraseña."' AND sol.vendedores.CC = '".$cc."'");

    if (mysqli_num_rows($existencia) > 0) {
        $ingresa = "Si";

        require_once '../modelo/usuarios.php';
			session_start();
			$usuario = new usuario();

			while($resultado= mysqli_fetch_assoc($existencia))
			{
				
				$Nombre=$resultado["nombre"];
				$idusuarios=$resultado["idvendedores"];
                $CC=$resultado["CC"];
                $contraseña=$resultado["contraseña"];
                $rol=$resultado["rol"];

				//Ingresar los valores a la clase

				$usuario->setUsuario($Nombre);
				$usuario->setIdusuarios($idusuarios);
                $usuario->setCC($CC);
                $usuario->setContrasena($contraseña);
                $usuario->setRol($rol);
				//$usuario->setRoles_idroles($roles_idroles);
			}

			$_SESSION['usuario'] = $usuario;
			$_SESSION['acceso'] = true;

            
    }

    echo $ingresa;

    //desconecta la base de datos

    $mysql->desconectar();
?>