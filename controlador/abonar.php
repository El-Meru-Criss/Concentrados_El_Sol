<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //toma los valores deseados
    $cantidad = $_POST['cantidad_abonada'];
   $idventas = $_POST['idventas'];
   $total_deuda = $_POST['cantidad_debida'];

   //toma los valores deseados
   $abono = $_POST['abono'];

   $total_abono = $abono + $cantidad;

   $sobrante = $total_abono - $total_deuda;

   $suma = $total_abono + $total_deuda;


   //realiza la consulta MySQL deseada, y la guarda en una variable
if ($total_abono>=$total_deuda) {
    $mysql->efectuarConsulta("UPDATE sol.cartera 
        SET sol.cartera.cantidad_abonada = '".$total_deuda."'
        WHERE sol.cartera.ventas_idventas = '".$idventas."' "); 
        echo $sobrante;
}else {
    $mysql->efectuarConsulta("UPDATE sol.cartera 
        SET sol.cartera.cantidad_abonada = '".$total_abono."'
        WHERE sol.cartera.ventas_idventas = '".$idventas."' "); 
}
   
   
    //desconecta la base de datos

    $mysql->desconectar();
?>