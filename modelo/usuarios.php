<?php

class Usuario {
    
    private $Usuario;
    private $idusuarios;
   // private $roles_idroles;



    public function __construct(){}

    //recibame el Usuario
    public function setUsuario($Usuario){
        $this->Usuario = $Usuario;
    }

    //recibame el idusuarios
    public function setIdusuarios($idusuarios){
        $this->idusuarios = $idusuarios;
    }

    //recibame el roles_idroles
    // public function setRoles_idroles($roles_idroles){
    //     $this->roles_idroles = $roles_idroles;
    // }

    
    public function getUsuario(){
        return $this->Usuario;
    }

    public function getIdusuarios(){
        return $this->idusuarios;
    }

    // public function getRoles_idroles(){
    //     return $this->roles_idroles;
    // }

}
?>