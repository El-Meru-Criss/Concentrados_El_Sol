<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $vendedores = $mysql->efectuarConsulta("SELECT sol.vendedores.idvendedores, 
    sol.vendedores.nombre
    FROM sol.vendedores");
?>
<div class="input-group">
    <select onchange="precio_renovar(<?php echo $idcasilla ?>)" id="producto<?php echo $idcasilla ?>" class="form-select vendedor" aria-label="Default select example">
    <option selected></option>
<?php //inicio del ciclo para ir colocando HTML 

while ($ven = mysqli_fetch_array($vendedores)) { ?>
    
    <option value="<?php echo $ven['idvendedores'] ?>" id="nombre_vendedor"><?php echo $ven['nombre'] ?></option>

<?php } //fin del ciclo

?>
</select>
<?php //desconecta la base de datos

    $mysql->desconectar();

?>