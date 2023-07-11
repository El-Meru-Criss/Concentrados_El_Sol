-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 12-07-2023 a las 01:21:50
-- Versión del servidor: 10.4.16-MariaDB
-- Versión de PHP: 7.4.12

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
  `cantidad_abonada` float NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_edicion` datetime NOT NULL DEFAULT current_timestamp(),
  `estado_cartera_idestado_cartera` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cartera`
--

INSERT INTO `cartera` (`idcartera`, `clientes_idclientes`, `ventas_idventas`, `cantidad_debida`, `cantidad_abonada`, `fecha_creacion`, `fecha_edicion`, `estado_cartera_idestado_cartera`) VALUES
(18, 8, 55, 102000, 102000, '2023-07-11 15:18:32', '2023-07-11 15:18:32', 1),
(19, 9, 56, 33000, 33000, '2023-07-11 15:18:51', '2023-07-11 15:18:51', 1),
(20, 10, 57, 96000, 96000, '2023-07-11 15:19:37', '2023-07-11 15:19:37', 1);

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
  `documento` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idclientes`, `nombre`, `telefono`, `direccion`, `correo`, `documento`) VALUES
(7, 'Casual', '', '', '', '000000'),
(8, 'Jaider', '3102536985', 'carrera 2# 4-56', 'lacra@gmail.com', '10006'),
(9, 'ARTUR', '3152536985', 'carrera 2# 4-8', 'ARTUR@gmail.com', '10007'),
(10, 'Monica', '3132536980', 'calle 2# 4-8', 'mon@gmail.com', '10008');

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
(1, 'bueno'),
(2, 'vencido');

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
(2, 'Credito'),
(3, 'pagado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_abonos`
--

CREATE TABLE `historial_abonos` (
  `idhistorial_abonos` int(11) NOT NULL,
  `cartera_idcartera` int(11) NOT NULL,
  `cantidad_abonada` float NOT NULL,
  `fecha_abono` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `historial_abonos`
--

INSERT INTO `historial_abonos` (`idhistorial_abonos`, `cartera_idcartera`, `cantidad_abonada`, `fecha_abono`) VALUES
(1, 19, 5000, '2023-07-11 17:22:54'),
(2, 18, 1000, '2023-07-11 17:23:47'),
(3, 18, 4000, '2023-07-11 17:39:40'),
(4, 18, 5000, '2023-07-11 17:39:49'),
(5, 18, 500000, '2023-07-11 17:42:45'),
(6, 19, 1000, '2023-07-11 17:49:03'),
(7, 19, 30000, '2023-07-11 17:49:20'),
(8, 20, 30000, '2023-07-11 17:50:08'),
(9, 20, 46000, '2023-07-11 17:50:30');

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
  `precio_bulto` float DEFAULT NULL,
  `stock_minimo` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`idinventario`, `cantidad`, `fecha_entrada`, `precio_publico`, `proveedor_has_producto_producto_idproducto`, `estado_producto_idestado_producto`, `fecha_caducidad`, `precio_bulto`, `stock_minimo`) VALUES
(23, -4, '2023-07-10', 4000, 32, 1, NULL, NULL, 20),
(24, 993, '2023-07-11', 3000, 12, 1, NULL, 35000, NULL),
(25, 793, '2023-07-11', 2000, 18, 1, NULL, 30000, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_has_ventas`
--

CREATE TABLE `inventario_has_ventas` (
  `inventario_idinventario` int(11) NOT NULL,
  `ventas_idventas` int(11) NOT NULL,
  `cantidad_vendida` float NOT NULL,
  `cantidad_enviada` float DEFAULT NULL,
  `estado_domicilio_idestado_domicilio` int(11) DEFAULT NULL,
  `unidad_medida_idunidad_medida` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `inventario_has_ventas`
--

INSERT INTO `inventario_has_ventas` (`inventario_idinventario`, `ventas_idventas`, `cantidad_vendida`, `cantidad_enviada`, `estado_domicilio_idestado_domicilio`, `unidad_medida_idunidad_medida`) VALUES
(24, 55, 4, 3, 1, 1),
(24, 56, 1, NULL, 1, 1),
(24, 57, 2, NULL, 1, 1),
(25, 55, 3, NULL, 1, 2),
(25, 56, 1, NULL, 1, 2),
(25, 57, 3, NULL, 1, 2);

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
(30, '2023-06-23 18:57:30', 780000, 0x31),
(31, '2023-07-08 14:29:03', 8000, 0x31),
(32, '2023-07-08 14:36:03', 200000, 0x31),
(33, '2023-07-10 18:56:31', 10000, 0x31),
(34, '2023-07-11 15:16:40', 800000, 0x31);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL,
  `nombre_producto` varchar(45) NOT NULL,
  `peso` float NOT NULL,
  `Estado_Producto` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idproducto`, `nombre_producto`, `peso`, `Estado_Producto`) VALUES
(12, 'Pajarina', 10, 1),
(18, 'Salvado', 40, 1),
(32, 'COLLAR', 1, 1);

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
(8, 'Contegral', '', ''),
(9, 'DistriAvez', '314', '1006784001');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_has_producto`
--

CREATE TABLE `proveedor_has_producto` (
  `proveedor_idproveedor` int(11) NOT NULL,
  `producto_idproducto` int(11) NOT NULL,
  `precio` float NOT NULL,
  `estado` binary(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `proveedor_has_producto`
--

INSERT INTO `proveedor_has_producto` (`proveedor_idproveedor`, `producto_idproducto`, `precio`, `estado`) VALUES
(8, 32, 1000, 0x30),
(9, 12, 0, 0x31),
(9, 18, 40000, 0x31),
(9, 32, 3000, 0x30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_has_producto_has_pedidos_proveedor`
--

CREATE TABLE `proveedor_has_producto_has_pedidos_proveedor` (
  `proveedor_has_producto_proveedor_idproveedor` int(11) NOT NULL,
  `proveedor_has_producto_producto_idproducto` int(11) NOT NULL,
  `pedidos_proveedor_idpedidos_proveedor` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `recibidos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `proveedor_has_producto_has_pedidos_proveedor`
--

INSERT INTO `proveedor_has_producto_has_pedidos_proveedor` (`proveedor_has_producto_proveedor_idproveedor`, `proveedor_has_producto_producto_idproducto`, `pedidos_proveedor_idpedidos_proveedor`, `cantidad`, `recibidos`) VALUES
(8, 32, 33, 5, 5),
(9, 12, 34, 100, 100),
(9, 18, 34, 20, 20);

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
  `nombre` varchar(45) NOT NULL,
  `CC` varchar(100) NOT NULL,
  `contraseña` varchar(250) NOT NULL,
  `rol` binary(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`idvendedores`, `nombre`, `CC`, `contraseña`, `rol`) VALUES
(23, 'steven', '1004', 'steven', 0x30),
(24, 'Brayan', '1006', 'mosquera', NULL),
(25, 'cris', '1006287604', '12345', 0x31);

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
(55, 102000, 8, 23, 2, '2023-07-11 15:18:32', 20000),
(56, 33000, 9, 23, 2, '2023-06-26 15:18:50', 20000),
(57, 96000, 10, 23, 3, '2023-06-11 15:19:37', 20000);

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
  ADD PRIMARY KEY (`idclientes`),
  ADD UNIQUE KEY `documento` (`documento`);

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
-- Indices de la tabla `historial_abonos`
--
ALTER TABLE `historial_abonos`
  ADD PRIMARY KEY (`idhistorial_abonos`),
  ADD KEY `fk_historial_abonos_cartera1_idx` (`cartera_idcartera`);

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
  ADD PRIMARY KEY (`idproducto`),
  ADD UNIQUE KEY `nombre_producto_UNIQUE` (`nombre_producto`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`idproveedor`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

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
  ADD PRIMARY KEY (`idvendedores`),
  ADD UNIQUE KEY `CC` (`CC`);

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
-- AUTO_INCREMENT de la tabla `cartera`
--
ALTER TABLE `cartera`
  MODIFY `idcartera` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
  MODIFY `idestado_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `estado_venta`
--
ALTER TABLE `estado_venta`
  MODIFY `idestado_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `historial_abonos`
--
ALTER TABLE `historial_abonos`
  MODIFY `idhistorial_abonos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `idinventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  MODIFY `idpedidos_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idproveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `unidad_medida`
--
ALTER TABLE `unidad_medida`
  MODIFY `idunidad_medida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `idvendedores` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idventas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

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
-- Filtros para la tabla `historial_abonos`
--
ALTER TABLE `historial_abonos`
  ADD CONSTRAINT `fk_historial_abonos_cartera1` FOREIGN KEY (`cartera_idcartera`) REFERENCES `cartera` (`idcartera`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
