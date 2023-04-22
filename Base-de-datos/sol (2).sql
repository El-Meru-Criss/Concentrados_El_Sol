-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-04-2023 a las 22:59:40
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

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
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idclientes` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `telefonos_idtelefonos` int(11) NOT NULL,
  `dirreciones_iddirreciones` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dirreciones`
--

CREATE TABLE `dirreciones` (
  `iddirreciones` int(11) NOT NULL,
  `ciudad` varchar(45) NOT NULL,
  `indicacion` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `domicilio`
--

CREATE TABLE `domicilio` (
  `idpedidos` int(11) NOT NULL,
  `fecha_pedido` datetime NOT NULL,
  `fecha_entrega` datetime NOT NULL,
  `ventas_idventas` int(11) NOT NULL,
  `estado_domicilio_idestado_domicilio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_domicilio`
--

CREATE TABLE `estado_domicilio` (
  `idestado_domicilio` int(11) NOT NULL,
  `nombre_estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_producto`
--

CREATE TABLE `estado_producto` (
  `idestado_producto` int(11) NOT NULL,
  `nombre_estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_venta`
--

CREATE TABLE `estado_venta` (
  `idestado_venta` int(11) NOT NULL,
  `nombre_estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `idinventario` int(11) NOT NULL,
  `cantidad` float NOT NULL,
  `fecha_entrada` date NOT NULL,
  `precio_publico` varchar(45) NOT NULL,
  `pedidos_proveedor_idpedidos_proveedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_has_ventas`
--

CREATE TABLE `inventario_has_ventas` (
  `inventario_idinventario` int(11) NOT NULL,
  `ventas_idventas` int(11) NOT NULL,
  `cantidad_vendida` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_proveedor`
--

CREATE TABLE `pedidos_proveedor` (
  `idpedidos_proveedor` int(11) NOT NULL,
  `fecha_pedido` datetime NOT NULL,
  `cantidad_total` float NOT NULL,
  `proveedor_has_producto_proveedor_idproveedor` int(11) NOT NULL,
  `proveedor_has_producto_producto_idproducto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL,
  `fecha_caducidad` date NOT NULL,
  `estado_producto_idestado_producto` int(11) NOT NULL,
  `nombre_producto` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `idproveedor` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `cuenta_bancaria` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_has_producto`
--

CREATE TABLE `proveedor_has_producto` (
  `proveedor_idproveedor` int(11) NOT NULL,
  `producto_idproducto` int(11) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefonos`
--

CREATE TABLE `telefonos` (
  `idtelefonos` int(11) NOT NULL,
  `numero` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `idvendedores` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idventas` int(11) NOT NULL,
  `precio_total` float NOT NULL,
  `clientes_idclientes` int(11) NOT NULL,
  `vendedores_idvendedores` int(11) NOT NULL,
  `cantidad_pagada_idcantidad_pagada` int(11) NOT NULL,
  `estado_venta_idestado_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cantidad_pagada`
--
ALTER TABLE `cantidad_pagada`
  ADD PRIMARY KEY (`idcantidad_pagada`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idclientes`),
  ADD KEY `fk_clientes_telefonos1_idx` (`telefonos_idtelefonos`),
  ADD KEY `fk_clientes_dirreciones1_idx` (`dirreciones_iddirreciones`);

--
-- Indices de la tabla `dirreciones`
--
ALTER TABLE `dirreciones`
  ADD PRIMARY KEY (`iddirreciones`);

--
-- Indices de la tabla `domicilio`
--
ALTER TABLE `domicilio`
  ADD PRIMARY KEY (`idpedidos`),
  ADD KEY `fk_domicilio_ventas1_idx` (`ventas_idventas`),
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
  ADD KEY `fk_inventario_pedidos_proveedor1_idx` (`pedidos_proveedor_idpedidos_proveedor`);

--
-- Indices de la tabla `inventario_has_ventas`
--
ALTER TABLE `inventario_has_ventas`
  ADD PRIMARY KEY (`inventario_idinventario`,`ventas_idventas`),
  ADD KEY `fk_inventario_has_ventas_ventas1_idx` (`ventas_idventas`),
  ADD KEY `fk_inventario_has_ventas_inventario1_idx` (`inventario_idinventario`);

--
-- Indices de la tabla `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  ADD PRIMARY KEY (`idpedidos_proveedor`),
  ADD KEY `fk_pedidos_proveedor_proveedor_has_producto1_idx` (`proveedor_has_producto_proveedor_idproveedor`,`proveedor_has_producto_producto_idproducto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idproducto`),
  ADD KEY `fk_producto_estado_producto1_idx` (`estado_producto_idestado_producto`);

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
-- Indices de la tabla `telefonos`
--
ALTER TABLE `telefonos`
  ADD PRIMARY KEY (`idtelefonos`);

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
  MODIFY `idcantidad_pagada` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idclientes` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `dirreciones`
--
ALTER TABLE `dirreciones`
  MODIFY `iddirreciones` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `domicilio`
--
ALTER TABLE `domicilio`
  MODIFY `idpedidos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_domicilio`
--
ALTER TABLE `estado_domicilio`
  MODIFY `idestado_domicilio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_producto`
--
ALTER TABLE `estado_producto`
  MODIFY `idestado_producto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_venta`
--
ALTER TABLE `estado_venta`
  MODIFY `idestado_venta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `idinventario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  MODIFY `idpedidos_proveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idproveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `telefonos`
--
ALTER TABLE `telefonos`
  MODIFY `idtelefonos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  MODIFY `idvendedores` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idventas` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_clientes_dirreciones1` FOREIGN KEY (`dirreciones_iddirreciones`) REFERENCES `dirreciones` (`iddirreciones`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_clientes_telefonos1` FOREIGN KEY (`telefonos_idtelefonos`) REFERENCES `telefonos` (`idtelefonos`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `domicilio`
--
ALTER TABLE `domicilio`
  ADD CONSTRAINT `fk_domicilio_estado_domicilio1` FOREIGN KEY (`estado_domicilio_idestado_domicilio`) REFERENCES `estado_domicilio` (`idestado_domicilio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_domicilio_ventas1` FOREIGN KEY (`ventas_idventas`) REFERENCES `ventas` (`idventas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_inventario_pedidos_proveedor1` FOREIGN KEY (`pedidos_proveedor_idpedidos_proveedor`) REFERENCES `pedidos_proveedor` (`idpedidos_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `inventario_has_ventas`
--
ALTER TABLE `inventario_has_ventas`
  ADD CONSTRAINT `fk_inventario_has_ventas_inventario1` FOREIGN KEY (`inventario_idinventario`) REFERENCES `inventario` (`idinventario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_inventario_has_ventas_ventas1` FOREIGN KEY (`ventas_idventas`) REFERENCES `ventas` (`idventas`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pedidos_proveedor`
--
ALTER TABLE `pedidos_proveedor`
  ADD CONSTRAINT `fk_pedidos_proveedor_proveedor_has_producto1` FOREIGN KEY (`proveedor_has_producto_proveedor_idproveedor`,`proveedor_has_producto_producto_idproducto`) REFERENCES `proveedor_has_producto` (`proveedor_idproveedor`, `producto_idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_producto_estado_producto1` FOREIGN KEY (`estado_producto_idestado_producto`) REFERENCES `estado_producto` (`idestado_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `proveedor_has_producto`
--
ALTER TABLE `proveedor_has_producto`
  ADD CONSTRAINT `fk_proveedor_has_producto_producto1` FOREIGN KEY (`producto_idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_proveedor_has_producto_proveedor` FOREIGN KEY (`proveedor_idproveedor`) REFERENCES `proveedor` (`idproveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
