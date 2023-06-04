-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-05-2023 a las 18:53:00
-- Versión del servidor: 10.4.18-MariaDB
-- Versión de PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sol`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cartera`
--

CREATE TABLE `cartera` (
  `idcartera` int(11) NOT NULL,
  `clientes_idclientes` int(11) NOT NULL,
  `ventas_idventas` int(11) NOT NULL,
  `cantidad_debida` float NOT NULL,
  `cantidad_abonada` float NOT NULL DEFAULT 0,
  `fecha_creacion` date NOT NULL DEFAULT current_timestamp(),
  `fecha_edicion` datetime NOT NULL DEFAULT current_timestamp(),
  `estado_cartera_idestado_cartera` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idclientes` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `documento` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idclientes`, `nombre`, `telefono`, `direccion`, `correo`, `documento`) VALUES
(7, 'Casual', '', '', '', ''),
(8, 'Jaider', '3102536985', 'carrera 2# 4-56', 'lacra@gmail.com', ''),
(9, 'ARTUR', '3152536985', 'carrera 2# 4-8', 'ARTUR@gmail.com', ''),
(10, 'Monica', '3132536980', 'calle 2# 4-8', 'mon@gmail.com', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_cartera`
--

CREATE TABLE `estado_cartera` (
  `idestado_cartera` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estado_cartera`
--

INSERT INTO `estado_cartera` (`idestado_cartera`, `nombre`) VALUES
(1, 'debido'),
(2, 'pagado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_domicilio`
--

CREATE TABLE `estado_domicilio` (
  `idestado_domicilio` int(11) NOT NULL,
  `nombre_estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `estado_domicilio`
--

INSERT INTO `estado_domicilio` (`idestado_domicilio`, `nombre_estado`) VALUES
(1, 'sin enviar'),
(2, 'envio total'),
(3, 'envio parcial');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_producto`
--

CREATE TABLE `estado_producto` (
  `idestado_producto` int(11) NOT NULL,
  `nombre_estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `estado_producto`
--

INSERT INTO `estado_producto` (`idestado_producto`, `nombre_estado`) VALUES
(1, 'Buen estado'),
(2, 'Vencido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_venta`
--

CREATE TABLE `estado_venta` (
  `idestado_venta` int(11) NOT NULL,
  `nombre_estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `estado_venta`
--

INSERT INTO `estado_venta` (`idestado_venta`, `nombre_estado`) VALUES
(1, 'Contado'),
(2, 'Credito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `idinventario` int(11) NOT NULL,
  `cantidad` float NOT NULL,
  `fecha_entrada` date NOT NULL,
  `precio_publico` float DEFAULT NULL,
  `proveedor_has_producto_producto_idproducto` int(11) NOT NULL,
  `estado_producto_idestado_producto` int(11) NOT NULL,
  `fecha_caducidad` date DEFAULT NULL,
  `precio_bulto` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`idinventario`, `cantidad`, `fecha_entrada`, `precio_publico`, `proveedor_has_producto_producto_idproducto`, `estado_producto_idestado_producto`, `fecha_caducidad`, `precio_bulto`) VALUES
(4, 60, '2023-05-15', 4000, 7, 1, '2023-05-31', 45000),
(5, 8, '2023-05-15', 7000, 8, 1, '2023-05-31', 75000),
(6, 30, '2023-05-15', 1000, 9, 1, '2023-05-31', 52000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_has_ventas`
--

CREATE TABLE `inventario_has_ventas` (
  `inventario_idinventario` int(11) NOT NULL,
  `ventas_idventas` int(11) NOT NULL,
  `cantidad_vendida` float NOT NULL,
  `estado_domicilio_idestado_domicilio` int(11) DEFAULT NULL,
  `unidad_medida_idunidad_medida` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `inventario_has_ventas`
--

INSERT INTO `inventario_has_ventas` (`inventario_idinventario`, `ventas_idventas`, `cantidad_vendida`, `estado_domicilio_idestado_domicilio`, `unidad_medida_idunidad_medida`) VALUES
(4, 10, 10, NULL, 1),
(4, 11, 10, 1, 1),
(4, 12, 5, 3, 1),
(4, 13, 4, 1, 1),
(5, 12, 3, 1, 1),
(6, 12, 1, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_proveedor`
--

CREATE TABLE `pedidos_proveedor` (
  `idpedidos_proveedor` int(11) NOT NULL,
  `fecha_pedido` datetime NOT NULL,
  `cantidad_total` float NOT NULL,
  `estado_pedido` binary(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pedidos_proveedor`
--

INSERT INTO `pedidos_proveedor` (`idpedidos_proveedor`, `fecha_pedido`, `cantidad_total`, `estado_pedido`) VALUES
(1, '2023-05-15 09:51:09', 310000, 0x31),
(2, '2023-05-15 09:52:00', 300000, 0x31);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL,
  `nombre_producto` varchar(45) NOT NULL,
  `peso` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idproducto`, `nombre_producto`, `peso`) VALUES
(7, 'Perro', 30),
(8, 'Gato', 8),
(9, 'Pajarina', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `idproveedor` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `cuenta_bancaria` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`idproveedor`, `nombre`, `telefono`, `cuenta_bancaria`) VALUES
(6, 'Contegral', '', ''),
(7, 'DistriAvez', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_has_producto`
--

CREATE TABLE `proveedor_has_producto` (
  `proveedor_idproveedor` int(11) NOT NULL,
  `producto_idproducto` int(11) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `proveedor_has_producto`
--

INSERT INTO `proveedor_has_producto` (`proveedor_idproveedor`, `producto_idproducto`, `precio`) VALUES
(6, 7, 110000),
(6, 8, 90000),
(7, 9, 100000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_has_producto_has_pedidos_proveedor`
--

CREATE TABLE `proveedor_has_producto_has_pedidos_proveedor` (
  `proveedor_has_producto_proveedor_idproveedor` int(11) NOT NULL,
  `proveedor_has_producto_producto_idproducto` int(11) NOT NULL,
  `pedidos_proveedor_idpedidos_proveedor` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `proveedor_has_producto_has_pedidos_proveedor`
--

INSERT INTO `proveedor_has_producto_has_pedidos_proveedor` (`proveedor_has_producto_proveedor_idproveedor`, `proveedor_has_producto_producto_idproducto`, `pedidos_proveedor_idpedidos_proveedor`, `cantidad`) VALUES
(6, 7, 1, 2),
(6, 8, 1, 1),
(7, 9, 2, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidad_medida`
--

CREATE TABLE `unidad_medida` (
  `idunidad_medida` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `unidad_medida`
--

INSERT INTO `unidad_medida` (`idunidad_medida`, `nombre`) VALUES
(1, 'kl'),
(2, 'bulto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `idvendedores` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`idvendedores`, `nombre`) VALUES
(23, 'steven'),
(24, 'Brayan'),
(25, 'cris');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idventas` int(11) NOT NULL,
  `precio_total` float DEFAULT NULL,
  `clientes_idclientes` int(11) NOT NULL,
  `vendedores_idvendedores` int(11) NOT NULL,
  `estado_venta_idestado_venta` int(11) NOT NULL,
  `fecha_venta` datetime NOT NULL DEFAULT current_timestamp(),
  `cantidad_pagada` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idventas`, `precio_total`, `clientes_idclientes`, `vendedores_idvendedores`, `estado_venta_idestado_venta`, `fecha_venta`, `cantidad_pagada`) VALUES
(10, 40000, 7, 23, 1, '2023-05-15 10:02:44', 40000),
(11, 40000, 7, 23, 2, '2023-05-15 10:06:10', 20000),
(12, 93000, 9, 23, 2, '2023-05-15 10:09:07', 10000),
(13, 16000, 9, 23, 2, '2023-05-15 11:38:15', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cartera`
--
ALTER TABLE `cartera`
  ADD PRIMARY KEY (`idcartera`),
  ADD KEY `fk_cartera_clientes_idx` (`clientes_idclientes`),
  ADD KEY `fk_cartera_ventas1_idx` (`ventas_idventas`),
  ADD KEY `fk_cartera_estado_cartera1_idx` (`estado_cartera_idestado_cartera`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idclientes`);

--
-- Indices de la tabla `estado_cartera`
--
ALTER TABLE `estado_cartera`
  ADD PRIMARY KEY (`idestado_cartera`);

--
-- Indices de la tabla `estado_domicilio`
--
ALTER TABLE `estado_domicilio`
  ADD PRIMARY KEY (`idestado_domicilio`);

--
-- Indices de la tabla `estado_producto`
--
ALTER TABLE `estado_producto`
  ADD PRIMARY KEY (`idestado_producto`);

--
-- Indices de la tabla `estado_venta`
--
ALTER TABLE `estado_venta`
  ADD PRIMARY KEY (`idestado_venta`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`idinventario`),
  ADD KEY `fk_inventario_proveedor_has_producto1_idx` (`proveedor_has_producto_producto_idproducto`),
  ADD KEY `fk_inventario_estado_producto1_idx` (`estado_producto_idestado_producto`);

--
-- Indices de la tabla `inventario_has_ventas`
--
ALTER TABLE `inventario_has_ventas`
  ADD PRIMARY KEY (`inventario_idinventario`,`ventas_idventas`,`unidad_medida_idunidad_medida`),
  ADD KEY `fk_inventario_has_ventas_ventas1_idx` (`ventas_idventas`),
  ADD KEY `fk_inventario_has_ventas_inventario1_idx` (`inventario_idinventario`),
  ADD KEY `fk_inventario_has_ventas_estado_domicilio1_idx` (`estado_domicilio_idestado_domicilio`),
  ADD KEY `fk_inventario_has_ventas_unidad_medida1_idx` (`unidad_medida_idunidad_medida`);

--
-- Indices de la tabla `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  ADD PRIMARY KEY (`idpedidos_proveedor`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idproducto`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`idproveedor`);

--
-- Indices de la tabla `proveedor_has_producto`
--
ALTER TABLE `proveedor_has_producto`
  ADD PRIMARY KEY (`proveedor_idproveedor`,`producto_idproducto`),
  ADD KEY `fk_proveedor_has_producto_producto1_idx` (`producto_idproducto`),
  ADD KEY `fk_proveedor_has_producto_proveedor_idx` (`proveedor_idproveedor`);

--
-- Indices de la tabla `proveedor_has_producto_has_pedidos_proveedor`
--
ALTER TABLE `proveedor_has_producto_has_pedidos_proveedor`
  ADD PRIMARY KEY (`proveedor_has_producto_proveedor_idproveedor`,`proveedor_has_producto_producto_idproducto`,`pedidos_proveedor_idpedidos_proveedor`),
  ADD KEY `fk_proveedor_has_producto_has_pedidos_proveedor_pedidos_pro_idx` (`pedidos_proveedor_idpedidos_proveedor`),
  ADD KEY `fk_proveedor_has_producto_has_pedidos_proveedor_proveedor_h_idx` (`proveedor_has_producto_proveedor_idproveedor`,`proveedor_has_producto_producto_idproducto`);

--
-- Indices de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  ADD PRIMARY KEY (`idunidad_medida`);

--
-- Indices de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD PRIMARY KEY (`idvendedores`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idventas`),
  ADD KEY `fk_ventas_clientes1_idx` (`clientes_idclientes`),
  ADD KEY `fk_ventas_vendedores1_idx` (`vendedores_idvendedores`),
  ADD KEY `fk_ventas_estado_venta1_idx` (`estado_venta_idestado_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idclientes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `estado_cartera`
--
ALTER TABLE `estado_cartera`
  MODIFY `idestado_cartera` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estado_domicilio`
--
ALTER TABLE `estado_domicilio`
  MODIFY `idestado_domicilio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `estado_producto`
--
ALTER TABLE `estado_producto`
  MODIFY `idestado_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `estado_venta`
--
ALTER TABLE `estado_venta`
  MODIFY `idestado_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `idinventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  MODIFY `idpedidos_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idproveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  MODIFY `idunidad_medida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `idvendedores` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idventas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cartera`
--
ALTER TABLE `cartera`
  ADD CONSTRAINT `fk_cartera_clientes` FOREIGN KEY (`clientes_idclientes`) REFERENCES `clientes` (`idclientes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cartera_estado_cartera1` FOREIGN KEY (`estado_cartera_idestado_cartera`) REFERENCES `estado_cartera` (`idestado_cartera`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cartera_ventas1` FOREIGN KEY (`ventas_idventas`) REFERENCES `ventas` (`idventas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_inventario_estado_producto1` FOREIGN KEY (`estado_producto_idestado_producto`) REFERENCES `estado_producto` (`idestado_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventario_proveedor_has_producto1` FOREIGN KEY (`proveedor_has_producto_producto_idproducto`) REFERENCES `proveedor_has_producto` (`producto_idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `inventario_has_ventas`
--
ALTER TABLE `inventario_has_ventas`
  ADD CONSTRAINT `fk_inventario_has_ventas_estado_domicilio1` FOREIGN KEY (`estado_domicilio_idestado_domicilio`) REFERENCES `estado_domicilio` (`idestado_domicilio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventario_has_ventas_inventario1` FOREIGN KEY (`inventario_idinventario`) REFERENCES `inventario` (`idinventario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventario_has_ventas_unidad_medida1` FOREIGN KEY (`unidad_medida_idunidad_medida`) REFERENCES `unidad_medida` (`idunidad_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventario_has_ventas_ventas1` FOREIGN KEY (`ventas_idventas`) REFERENCES `ventas` (`idventas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `proveedor_has_producto`
--
ALTER TABLE `proveedor_has_producto`
  ADD CONSTRAINT `fk_proveedor_has_producto_producto1` FOREIGN KEY (`producto_idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_proveedor_has_producto_proveedor` FOREIGN KEY (`proveedor_idproveedor`) REFERENCES `proveedor` (`idproveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `proveedor_has_producto_has_pedidos_proveedor`
--
ALTER TABLE `proveedor_has_producto_has_pedidos_proveedor`
  ADD CONSTRAINT `fk_proveedor_has_producto_has_pedidos_proveedor_pedidos_prove1` FOREIGN KEY (`pedidos_proveedor_idpedidos_proveedor`) REFERENCES `pedidos_proveedor` (`idpedidos_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_proveedor_has_producto_has_pedidos_proveedor_proveedor_has1` FOREIGN KEY (`proveedor_has_producto_proveedor_idproveedor`,`proveedor_has_producto_producto_idproducto`) REFERENCES `proveedor_has_producto` (`proveedor_idproveedor`, `producto_idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_ventas_clientes1` FOREIGN KEY (`clientes_idclientes`) REFERENCES `clientes` (`idclientes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ventas_estado_venta1` FOREIGN KEY (`estado_venta_idestado_venta`) REFERENCES `estado_venta` (`idestado_venta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ventas_vendedores1` FOREIGN KEY (`vendedores_idvendedores`) REFERENCES `vendedores` (`idvendedores`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
