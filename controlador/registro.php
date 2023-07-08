<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $cc = $_POST['usuario'];
    $ingresa = "No";
    
    //realiza la consulta MySQL deseada, y la guarda en una variable

    $existencia = $mysql->efectuarConsulta("SELECT sol.vendedores.idvendedores, 
    sol.vendedores.nombre 
    FROM sol.vendedores 
    WHERE sol.vendedores.nombre = '".$cc."'");

    if (mysqli_num_rows($existencia) > 0) {
        $ingresa = "Si";

        require_once '../modelo/usuarios.php';
			session_start();
			$usuario = new usuario();

			while($resultado= mysqli_fetch_assoc($existencia))
			{
				
				$Nombre=$resultado["nombre"];
				$idusuarios=$resultado["idvendedores"];
				//$roles_idroles=$resultado["roles_idroles"];

				$usuario->setUsuario($Nombre);
				$usuario->setIdusuarios($idusuarios);
				//$usuario->setRoles_idroles($roles_idroles);
			}

			$_SESSION['usuario'] = $usuario;
			$_SESSION['acceso'] = true;

            
    }

    echo $ingresa;

    //desconecta la base de datos

    $mysql->desconectar();
?>