<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $proveedores = $mysql->efectuarConsulta("SELECT 
    sol.proveedor.idproveedor, 
    sol.proveedor.nombre 
    FROM sol.proveedor");
?>

<?php //inicio del ciclo para ir colocando HTML 

while ($prov = mysqli_fetch_array($proveedores)) { ?>
    
    <option value="<?php echo $prov['idproveedor'] ?>"><?php echo $prov['nombre'] ?></option>

<?php } //fin del ciclo

?>

<option onclick="provedores_renovar()">actualizar</option>

<?php //desconecta la base de datos

    $mysql->desconectar();

?>