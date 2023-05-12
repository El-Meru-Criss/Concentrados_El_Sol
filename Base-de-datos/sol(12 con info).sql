-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-05-2023 a las 22:45:22
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
-- Estructura de tabla para la tabla `cantidad_pagada`
--

CREATE TABLE `cantidad_pagada` (
  `idcantidad_pagada` int(11) NOT NULL,
  `dinero` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `clientes_idclientes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idclientes` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idclientes`, `nombre`, `telefono`, `direccion`) VALUES
(1, 'Artur', '3155020369', 'calle 8 #3-65'),
(2, 'Diana', '3125064963', 'carrera 2'),
(3, 'carlos', '3215263945', 'callew'),
(4, 'Cliente casual', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `domicilio`
--

CREATE TABLE `domicilio` (
  `idpedidos` int(11) NOT NULL,
  `fecha_pedido` datetime NOT NULL,
  `fecha_entrega` datetime DEFAULT NULL,
  `estado_domicilio_idestado_domicilio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(2, 'enviado');

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
  `fecha_caducidad` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`idinventario`, `cantidad`, `fecha_entrada`, `precio_publico`, `proveedor_has_producto_producto_idproducto`, `estado_producto_idestado_producto`, `fecha_caducidad`) VALUES
(1, 20, '2023-05-08', 5000, 2, 1, '2023-05-31'),
(2, 10, '2023-05-08', 4000, 3, 1, '2023-05-31'),
(3, 15, '2023-05-08', 3000, 4, 1, '2023-05-31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_has_ventas`
--

CREATE TABLE `inventario_has_ventas` (
  `inventario_idinventario` int(11) NOT NULL,
  `ventas_idventas` int(11) NOT NULL,
  `cantidad_vendida` float NOT NULL,
  `estado_domicilio_idestado_domicilio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `inventario_has_ventas`
--

INSERT INTO `inventario_has_ventas` (`inventario_idinventario`, `ventas_idventas`, `cantidad_vendida`, `estado_domicilio_idestado_domicilio`) VALUES
(1, 1, 1, NULL),
(1, 3, 1, NULL),
(1, 5, 1, NULL),
(1, 6, 1, NULL),
(2, 1, 1, NULL),
(2, 7, 2, NULL),
(2, 8, 3, NULL),
(3, 2, 4, NULL),
(3, 3, 1, NULL),
(3, 4, 1, NULL),
(3, 8, 1, NULL);

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL,
  `nombre_producto` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idproducto`, `nombre_producto`) VALUES
(1, 'Broiler'),
(2, 'perro'),
(3, 'gato'),
(4, 'ave');

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
(1, 'Contegral', '', ''),
(2, 'DistriAvez', '', '');

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
(1, 2, 3000),
(1, 3, 2000),
(2, 4, 1000);

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
(17, 'brayan'),
(18, 'steven'),
(19, 'cris');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idventas` int(11) NOT NULL,
  `precio_total` float NOT NULL,
  `clientes_idclientes` int(11) NOT NULL,
  `vendedores_idvendedores` int(11) NOT NULL,
  `cantidad_pagada_idcantidad_pagada` int(11) DEFAULT NULL,
  `estado_venta_idestado_venta` int(11) NOT NULL,
  `fecha_venta` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idventas`, `precio_total`, `clientes_idclientes`, `vendedores_idvendedores`, `cantidad_pagada_idcantidad_pagada`, `estado_venta_idestado_venta`, `fecha_venta`) VALUES
(1, 9000, 1, 17, NULL, 2, '2023-05-08'),
(2, 12000, 2, 19, NULL, 2, '2023-05-09'),
(3, 8000, 1, 19, NULL, 2, '2023-05-08'),
(4, 3000, 2, 18, NULL, 2, '2023-05-15'),
(5, 5000, 4, 18, NULL, 1, '2023-05-21'),
(6, 5000, 1, 19, NULL, 1, '2023-05-15'),
(7, 8000, 2, 17, NULL, 1, '2023-05-08'),
(8, 15000, 3, 17, NULL, 2, '2023-05-08');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cantidad_pagada`
--
ALTER TABLE `cantidad_pagada`
  ADD PRIMARY KEY (`idcantidad_pagada`),
  ADD KEY `fk_cantidad_pagada_clientes1_idx` (`clientes_idclientes`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idclientes`);

--
-- Indices de la tabla `domicilio`
--
ALTER TABLE `domicilio`
  ADD PRIMARY KEY (`idpedidos`),
  ADD KEY `fk_domicilio_estado_domicilio1_idx` (`estado_domicilio_idestado_domicilio`);

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
  ADD PRIMARY KEY (`inventario_idinventario`,`ventas_idventas`),
  ADD KEY `fk_inventario_has_ventas_ventas1_idx` (`ventas_idventas`),
  ADD KEY `fk_inventario_has_ventas_inventario1_idx` (`inventario_idinventario`),
  ADD KEY `fk_inventario_has_ventas_estado_domicilio1_idx` (`estado_domicilio_idestado_domicilio`);

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
  ADD KEY `fk_ventas_cantidad_pagada1_idx` (`cantidad_pagada_idcantidad_pagada`),
  ADD KEY `fk_ventas_estado_venta1_idx` (`estado_venta_idestado_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cantidad_pagada`
--
ALTER TABLE `cantidad_pagada`
  MODIFY `idcantidad_pagada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idclientes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `domicilio`
--
ALTER TABLE `domicilio`
  MODIFY `idpedidos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_domicilio`
--
ALTER TABLE `estado_domicilio`
  MODIFY `idestado_domicilio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estado_producto`
--
ALTER TABLE `estado_producto`
  MODIFY `idestado_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estado_venta`
--
ALTER TABLE `estado_venta`
  MODIFY `idestado_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `idinventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  MODIFY `idpedidos_proveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idproveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `idvendedores` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idventas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cantidad_pagada`
--
ALTER TABLE `cantidad_pagada`
  ADD CONSTRAINT `fk_cantidad_pagada_clientes1` FOREIGN KEY (`clientes_idclientes`) REFERENCES `clientes` (`idclientes`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `domicilio`
--
ALTER TABLE `domicilio`
  ADD CONSTRAINT `fk_domicilio_estado_domicilio1` FOREIGN KEY (`estado_domicilio_idestado_domicilio`) REFERENCES `estado_domicilio` (`idestado_domicilio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_ventas_cantidad_pagada1` FOREIGN KEY (`cantidad_pagada_idcantidad_pagada`) REFERENCES `cantidad_pagada` (`idcantidad_pagada`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ventas_clientes1` FOREIGN KEY (`clientes_idclientes`) REFERENCES `clientes` (`idclientes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ventas_estado_venta1` FOREIGN KEY (`estado_venta_idestado_venta`) REFERENCES `estado_venta` (`idestado_venta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ventas_vendedores1` FOREIGN KEY (`vendedores_idvendedores`) REFERENCES `vendedores` (`idvendedores`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
