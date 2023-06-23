<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $idcliente = $_POST['idcliente'];
    $cliente_nombre = $_POST['cliente_nombre'];
    $telefono_cliente = $_POST['telefono_cliente'];
    $direccion_cliente = $_POST['direccion_cliente'];
    $email_cliente = $_POST['email_cliente'];
    $documento_cliente = $_POST['documento_cliente'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $mysql->efectuarConsulta("UPDATE sol.clientes
    SET sol.clientes.nombre = '".$cliente_nombre."',
    sol.clientes.telefono = '".$telefono_cliente."',
    sol.clientes.direccion = '".$direccion_cliente."',
    sol.clientes.correo = '".$email_cliente."',
    sol.clientes.documento = '".$documento_cliente."'
    WHERE sol.clientes.idclientes = '".$idcliente."'");

    //desconecta la base de datos

    $mysql->desconectar();
?>