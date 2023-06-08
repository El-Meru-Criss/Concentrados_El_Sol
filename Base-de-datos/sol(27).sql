-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sol
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sol
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sol` DEFAULT CHARACTER SET utf8mb4 ;
USE `sol` ;

-- -----------------------------------------------------
-- Table `sol`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`clientes` (
  `idclientes` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(100) NULL DEFAULT NULL,
  `correo` VARCHAR(100) NULL DEFAULT NULL,
  `documento` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idclientes`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`estado_cartera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`estado_cartera` (
  `idestado_cartera` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestado_cartera`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sol`.`estado_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`estado_venta` (
  `idestado_venta` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestado_venta`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`vendedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`vendedores` (
  `idvendedores` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idvendedores`))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`ventas` (
  `idventas` INT(11) NOT NULL AUTO_INCREMENT,
  `precio_total` FLOAT NULL DEFAULT NULL,
  `clientes_idclientes` INT(11) NOT NULL,
  `vendedores_idvendedores` INT(11) NOT NULL,
  `estado_venta_idestado_venta` INT(11) NOT NULL,
  `fecha_venta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `cantidad_pagada` FLOAT NOT NULL,
  PRIMARY KEY (`idventas`),
  INDEX `fk_ventas_clientes1_idx` (`clientes_idclientes` ASC),
  INDEX `fk_ventas_vendedores1_idx` (`vendedores_idvendedores` ASC),
  INDEX `fk_ventas_estado_venta1_idx` (`estado_venta_idestado_venta` ASC),
  CONSTRAINT `fk_ventas_clientes1`
    FOREIGN KEY (`clientes_idclientes`)
    REFERENCES `sol`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_estado_venta1`
    FOREIGN KEY (`estado_venta_idestado_venta`)
    REFERENCES `sol`.`estado_venta` (`idestado_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_vendedores1`
    FOREIGN KEY (`vendedores_idvendedores`)
    REFERENCES `sol`.`vendedores` (`idvendedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`cartera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`cartera` (
  `idcartera` INT(11) NOT NULL AUTO_INCREMENT,
  `clientes_idclientes` INT(11) NOT NULL,
  `ventas_idventas` INT(11) NOT NULL,
  `cantidad_debida` FLOAT NOT NULL,
  `cantidad_abonada` FLOAT NOT NULL,
  `fecha_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `fecha_edicion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `estado_cartera_idestado_cartera` INT(11) NOT NULL,
  PRIMARY KEY (`idcartera`),
  INDEX `fk_cartera_clientes_idx` (`clientes_idclientes` ASC),
  INDEX `fk_cartera_ventas1_idx` (`ventas_idventas` ASC),
  INDEX `fk_cartera_estado_cartera1_idx` (`estado_cartera_idestado_cartera` ASC),
  CONSTRAINT `fk_cartera_clientes`
    FOREIGN KEY (`clientes_idclientes`)
    REFERENCES `sol`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartera_estado_cartera1`
    FOREIGN KEY (`estado_cartera_idestado_cartera`)
    REFERENCES `sol`.`estado_cartera` (`idestado_cartera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartera_ventas1`
    FOREIGN KEY (`ventas_idventas`)
    REFERENCES `sol`.`ventas` (`idventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sol`.`estado_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`estado_domicilio` (
  `idestado_domicilio` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestado_domicilio`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`estado_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`estado_producto` (
  `idestado_producto` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idestado_producto`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`producto` (
  `idproducto` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_producto` VARCHAR(45) NOT NULL,
  `peso` FLOAT NOT NULL,
  PRIMARY KEY (`idproducto`),
  UNIQUE INDEX `nombre_producto_UNIQUE` (`nombre_producto` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`proveedor` (
  `idproveedor` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `cuenta_bancaria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idproveedor`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`proveedor_has_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`proveedor_has_producto` (
  `proveedor_idproveedor` INT(11) NOT NULL,
  `producto_idproducto` INT(11) NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`proveedor_idproveedor`, `producto_idproducto`),
  INDEX `fk_proveedor_has_producto_producto1_idx` (`producto_idproducto` ASC),
  INDEX `fk_proveedor_has_producto_proveedor_idx` (`proveedor_idproveedor` ASC),
  CONSTRAINT `fk_proveedor_has_producto_producto1`
    FOREIGN KEY (`producto_idproducto`)
    REFERENCES `sol`.`producto` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_has_producto_proveedor`
    FOREIGN KEY (`proveedor_idproveedor`)
    REFERENCES `sol`.`proveedor` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`inventario` (
  `idinventario` INT(11) NOT NULL AUTO_INCREMENT,
  `cantidad` FLOAT NOT NULL,
  `fecha_entrada` DATE NOT NULL,
  `precio_publico` FLOAT NULL DEFAULT NULL,
  `proveedor_has_producto_producto_idproducto` INT(11) NOT NULL,
  `estado_producto_idestado_producto` INT(11) NOT NULL,
  `fecha_caducidad` DATE NULL DEFAULT NULL,
  `precio_bulto` FLOAT NULL DEFAULT NULL,
  `stock_minimo` FLOAT NULL,
  PRIMARY KEY (`idinventario`),
  INDEX `fk_inventario_proveedor_has_producto1_idx` (`proveedor_has_producto_producto_idproducto` ASC),
  INDEX `fk_inventario_estado_producto1_idx` (`estado_producto_idestado_producto` ASC),
  CONSTRAINT `fk_inventario_estado_producto1`
    FOREIGN KEY (`estado_producto_idestado_producto`)
    REFERENCES `sol`.`estado_producto` (`idestado_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventario_proveedor_has_producto1`
    FOREIGN KEY (`proveedor_has_producto_producto_idproducto`)
    REFERENCES `sol`.`proveedor_has_producto` (`producto_idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`unidad_medida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`unidad_medida` (
  `idunidad_medida` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idunidad_medida`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sol`.`inventario_has_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`inventario_has_ventas` (
  `inventario_idinventario` INT(11) NOT NULL,
  `ventas_idventas` INT(11) NOT NULL,
  `cantidad_vendida` FLOAT NOT NULL,
  `cantidad_enviada` FLOAT NULL,
  `estado_domicilio_idestado_domicilio` INT(11) NULL DEFAULT NULL,
  `unidad_medida_idunidad_medida` INT(11) NOT NULL,
  PRIMARY KEY (`inventario_idinventario`, `ventas_idventas`, `unidad_medida_idunidad_medida`),
  INDEX `fk_inventario_has_ventas_ventas1_idx` (`ventas_idventas` ASC),
  INDEX `fk_inventario_has_ventas_inventario1_idx` (`inventario_idinventario` ASC),
  INDEX `fk_inventario_has_ventas_estado_domicilio1_idx` (`estado_domicilio_idestado_domicilio` ASC),
  INDEX `fk_inventario_has_ventas_unidad_medida1_idx` (`unidad_medida_idunidad_medida` ASC),
  CONSTRAINT `fk_inventario_has_ventas_estado_domicilio1`
    FOREIGN KEY (`estado_domicilio_idestado_domicilio`)
    REFERENCES `sol`.`estado_domicilio` (`idestado_domicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventario_has_ventas_inventario1`
    FOREIGN KEY (`inventario_idinventario`)
    REFERENCES `sol`.`inventario` (`idinventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventario_has_ventas_unidad_medida1`
    FOREIGN KEY (`unidad_medida_idunidad_medida`)
    REFERENCES `sol`.`unidad_medida` (`idunidad_medida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventario_has_ventas_ventas1`
    FOREIGN KEY (`ventas_idventas`)
    REFERENCES `sol`.`ventas` (`idventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`pedidos_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`pedidos_proveedor` (
  `idpedidos_proveedor` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_pedido` DATETIME NOT NULL,
  `cantidad_total` FLOAT NOT NULL,
  `estado_pedido` BINARY(1) NULL DEFAULT NULL,
  PRIMARY KEY (`idpedidos_proveedor`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sol`.`proveedor_has_producto_has_pedidos_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sol`.`proveedor_has_producto_has_pedidos_proveedor` (
  `proveedor_has_producto_proveedor_idproveedor` INT(11) NOT NULL,
  `proveedor_has_producto_producto_idproducto` INT(11) NOT NULL,
  `pedidos_proveedor_idpedidos_proveedor` INT(11) NOT NULL,
  `cantidad` INT(11) NOT NULL,
  `recibidos` VARCHAR(45) NULL,
  PRIMARY KEY (`proveedor_has_producto_proveedor_idproveedor`, `proveedor_has_producto_producto_idproducto`, `pedidos_proveedor_idpedidos_proveedor`),
  INDEX `fk_proveedor_has_producto_has_pedidos_proveedor_pedidos_pro_idx` (`pedidos_proveedor_idpedidos_proveedor` ASC),
  INDEX `fk_proveedor_has_producto_has_pedidos_proveedor_proveedor_h_idx` (`proveedor_has_producto_proveedor_idproveedor` ASC, `proveedor_has_producto_producto_idproducto` ASC),
  CONSTRAINT `fk_proveedor_has_producto_has_pedidos_proveedor_pedidos_prove1`
    FOREIGN KEY (`pedidos_proveedor_idpedidos_proveedor`)
    REFERENCES `sol`.`pedidos_proveedor` (`idpedidos_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_has_producto_has_pedidos_proveedor_proveedor_has1`
    FOREIGN KEY (`proveedor_has_producto_proveedor_idproveedor` , `proveedor_has_producto_producto_idproducto`)
    REFERENCES `sol`.`proveedor_has_producto` (`proveedor_idproveedor` , `producto_idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
