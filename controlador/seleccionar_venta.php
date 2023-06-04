<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $estado_venta = $mysql->efectuarConsulta("SELECT sol.estado_venta.idestado_venta, 
    sol.estado_venta.nombre_estado
    FROM sol.estado_venta");
?>


<?php //inicio del ciclo para ir colocando HTML 

while ($est = mysqli_fetch_array($estado_venta)) { ?>
    
    <option value="<?php echo $est['idestado_venta'] ?>" id="tipo_venta"><?php echo $est['nombre_estado'] ?></option>

<?php } //fin del ciclo

?>

<?php //desconecta la base de datos

    $mysql->desconectar();

?>