<?php //llama a la base de datos con el modelo
    require_once '../modelo/mysql.php';
    $mysql = new MySQL();

    $mysql->conectar();

    $idvendedores = $_POST['idvendedores'];

    //realiza la consulta MySQL deseada, y la guarda en una variable

    $nombre = $mysql->efectuarConsulta("SELECT 
    sol.vendedores.idvendedores, 
    sol.vendedores.nombre 
    FROM sol.vendedores
    WHERE sol.vendedores.idvendedores = '".$idvendedores."'");
?>

<p>nombre</p>
<?php //inicio del ciclo para ir colocando HTML 

while ($nom = mysqli_fetch_array($nombre)) { ?>
<input type="text" class="form-control" id="vendedor_nombre_edi" placeholder="Nombre del nuevo vendedor"
 aria-describedby="basic-addon3 basic-addon4" value="<?php echo$nom["nombre"]; ?>"><br>

<?php } //fin del ciclo

?>
<div class="modal-footer bg-primary text-light align-content-center align-items-center justify-content-center text-center">
    <form class="d-flex" role="search">
        <button class="btn btn-primary" type="button" onclick="EditarVendedor(<?php echo $idvendedores;?>)"><i class="fa-solid fa-pen-to-square"></i> Editar</button>
    </form>
</div>

<?php //desconecta la base de datos

    $mysql->desconectar();

?>