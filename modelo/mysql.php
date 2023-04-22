<?php
	//clase para conexiones
	class MySQL{
		//datos validacion para conexion
		private $ipServidor="localhost";
		private $usuarioBase='root';
		private $contraseña='';

		private $conexion;
		//metodo para conectar la base de datos
	public function conectar()
	{
		$this->conexion = mysqli_connect($this->ipServidor, $this->usuarioBase, $this->contraseña);
	}

	//metodo que cierra la conexion
	public function desconectar()
	{
		mysqli_close($this->conexion);
	}

	//metodo que efectua una consulta y devuelve su resultado
	public function efectuarConsulta($consulta)
	{
		mysqli_query($this->conexion, "SET lc_time_names = 'es_ES' ");
		mysqli_query($this->conexion, "SET NAMES 'utf8'");
		mysqli_query($this->conexion,"SET CHARACTER 'utf8'");

		$this->resultadoConsulta = mysqli_query($this->conexion, $consulta);

		return $this->resultadoConsulta; 
	}

	}


?>