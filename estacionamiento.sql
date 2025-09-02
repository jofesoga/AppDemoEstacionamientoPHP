-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-07-2015 a las 11:44:09
-- Versión del servidor: 5.5.39
-- Versión de PHP: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `estacionamiento`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja`
--

CREATE TABLE IF NOT EXISTS `caja` (
`IdCierre` bigint(20) NOT NULL,
  `IdUsuario` varchar(13) NOT NULL,
  `FechaApertura` datetime NOT NULL,
  `FechaCierre` datetime DEFAULT NULL,
  `FolioInicial` bigint(20) NOT NULL,
  `FolioFinal` bigint(20) NOT NULL,
  `SaldoInicial` double NOT NULL DEFAULT '0',
  `SaldoFinal` double NOT NULL DEFAULT '0',
  `DineroRecibido` double NOT NULL DEFAULT '0',
  `Cerrada` tinyint(1) NOT NULL DEFAULT '0',
  `IdUsuarioCerro` varchar(13) DEFAULT NULL,
  `FoliosAbiertos` bigint(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `caja`
--

INSERT INTO `caja` (`IdCierre`, `IdUsuario`, `FechaApertura`, `FechaCierre`, `FolioInicial`, `FolioFinal`, `SaldoInicial`, `SaldoFinal`, `DineroRecibido`, `Cerrada`, `IdUsuarioCerro`, `FoliosAbiertos`) VALUES
(1, 'jofesoga', '2015-07-02 20:04:38', '2015-07-05 16:10:00', 1, 0, 0, 280, 0, 1, '', 2),
(2, 'jofesoga', '2015-07-05 14:26:07', '2015-07-05 16:41:00', 2, 0, 0, 0, 0, 1, 'jofesoga', 2),
(3, 'jofesoga', '2015-07-05 17:38:38', '2015-07-05 17:41:45', 0, 0, 0, 30, 0, 1, 'jofesoga', 1),
(4, 'jofesoga', '2015-07-05 17:44:54', '2015-07-05 17:58:34', 5, 0, 0, 10, 10, 1, 'jofesoga', 1),
(5, '2', '2015-07-05 18:15:03', '2015-07-05 18:17:22', 0, 0, 0, 10, 0, 1, '2', 1),
(6, '2', '2015-07-05 18:17:58', '2015-07-05 18:23:41', 7, 0, 0, 0, 0, 1, '2', 2),
(7, '2', '2015-07-05 18:26:23', NULL, 8, 0, 0, 0, 0, 0, NULL, 0);

--
-- Disparadores `caja`
--
DELIMITER //
CREATE TRIGGER `CierreDeCaja` BEFORE UPDATE ON `caja`
 FOR EACH ROW BEGIN
  SELECT SUM(Total) FROM carros WHERE IdCierre=OLD.IdCierre AND Cobrado=1 INTO @TOTALCOBRADO;
  SELECT COUNT(*) FROM carros WHERE Cobrado=0 INTO @TICKETSABIERTOS;
  IF @TOTALCOBRADO > 0 THEN
  SET NEW.SaldoFinal=@TOTALCOBRADO;
  ELSE
  SET NEW.SaldoFinal=0;
  END IF;
  SET NEW.FoliosAbiertos=@TICKETSABIERTOS;
  SET NEW.Cerrada=1;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cajeros`
--

CREATE TABLE IF NOT EXISTS `cajeros` (
  `IdUsuario` varchar(13) NOT NULL,
  `Nombre` text NOT NULL,
  `Password` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cajeros`
--

INSERT INTO `cajeros` (`IdUsuario`, `Nombre`, `Password`) VALUES
('2', 'Angel chico', '1234'),
('jofesoga', 'Jose Sosa Garcia', '1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carros`
--

CREATE TABLE IF NOT EXISTS `carros` (
`IdFolio` bigint(20) NOT NULL,
  `IdUsuario` varchar(13) NOT NULL,
  `IdCliente` varchar(13) NOT NULL DEFAULT '1',
  `FechaEntrada` datetime NOT NULL,
  `FechaSalida` datetime DEFAULT NULL,
  `MinutosReales` varchar(255) NOT NULL DEFAULT '0',
  `Placas` varchar(13) DEFAULT NULL,
  `TipoVehiculo` varchar(255) NOT NULL,
  `Total` double NOT NULL DEFAULT '0',
  `Cobrado` tinyint(1) NOT NULL DEFAULT '0',
  `CostoHora` double NOT NULL,
  `Cajon` bigint(20) DEFAULT NULL,
  `UsuarioCerro` varchar(13) DEFAULT NULL,
  `IdCierre` varchar(13) NOT NULL,
  `IdCierreApertura` bigint(20) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `carros`
--

INSERT INTO `carros` (`IdFolio`, `IdUsuario`, `IdCliente`, `FechaEntrada`, `FechaSalida`, `MinutosReales`, `Placas`, `TipoVehiculo`, `Total`, `Cobrado`, `CostoHora`, `Cajon`, `UsuarioCerro`, `IdCierre`, `IdCierreApertura`) VALUES
(1, 'jofesoga', '1', '2015-07-02 20:04:38', '2015-07-04 00:02:57', '27:58:19', '0', 'Automovil', 280, 1, 10, NULL, 'jofesoga', '1', 0),
(3, 'jofesoga', '1', '2015-07-05 14:33:50', '2015-07-05 17:38:38', '03:04:48', '0', 'Automovil', 30, 1, 10, NULL, 'jofesoga', '3', 0),
(4, 'jofesoga', '1', '2015-07-05 17:40:41', '2015-07-05 17:57:45', '00:17:04', '0', 'Automovil', 10, 1, 10, NULL, 'jofesoga', '4', 3),
(5, 'jofesoga', '1', '2015-07-05 17:44:54', '2015-07-05 18:15:03', '00:30:09', '0', 'Automovil', 10, 1, 10, NULL, '2', '5', 0),
(6, '2', '1', '2015-07-05 18:16:00', '2015-07-05 18:36:12', '00:20:12', '0', 'Automovil', 10, 1, 10, NULL, '2', '7', 5),
(7, '2', '1', '2015-07-05 18:17:58', '2015-07-07 00:33:27', '30:15:29', '0', 'Automovil', 310, 1, 10, NULL, 'jofesoga', '7', 0),
(8, '2', '1', '2015-07-05 18:26:23', '2015-07-07 00:45:10', '30:18:47', '0', 'Automovil', 310, 1, 10, NULL, 'jofesoga', '7', 7);

--
-- Disparadores `carros`
--
DELIMITER //
CREATE TRIGGER `SaleVehiculo` BEFORE UPDATE ON `carros`
 FOR EACH ROW BEGIN
SET @FECHAENTRO=OLD.FechaEntrada;
SET @FECHASALIO=NEW.FechaSalida;
IF @FECHASALIO > @FECHAENTRO THEN
    SELECT TIMEDIFF(@FECHASALIO,@FECHAENTRO) INTO @TIEMPOTOTAL;
    SET NEW.Cobrado=1;
    SET NEW.MinutosReales= @TIEMPOTOTAL;
    SELECT LEFT(@TIEMPOTOTAL,2) INTO @HORAS;
    SELECT SUBSTRING(@TIEMPOTOTAL,4,2) INTO @MINUTOS;
    IF @MINUTOS <= 10 THEN
       SET NEW.Total= @HORAS * OLD.CostoHora;
    ELSE
       SET NEW.Total= (@HORAS + 1) * OLD.CostoHora;
    END IF;
    SELECT IdCierre FROM caja WHERE Cerrada=0 INTO @CAJA;
    SET NEW.IdCierre=@CAJA;
END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE IF NOT EXISTS `clientes` (
  `IdCliente` varchar(6) NOT NULL,
  `Nombre` text NOT NULL,
  `Direccion` text NOT NULL,
  `Telefono` varchar(13) NOT NULL,
  `Telefono Movil` varchar(13) NOT NULL,
  `email` text NOT NULL,
  `Pension` tinyint(1) NOT NULL,
  `Precio` double NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`IdCliente`, `Nombre`, `Direccion`, `Telefono`, `Telefono Movil`, `email`, `Pension`, `Precio`) VALUES
('1', 'Publico General', 'vacio', 'vacio', 'vacio', 'vacio', 0, 10);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `caja`
--
ALTER TABLE `caja`
 ADD PRIMARY KEY (`IdCierre`);

--
-- Indices de la tabla `cajeros`
--
ALTER TABLE `cajeros`
 ADD PRIMARY KEY (`IdUsuario`), ADD UNIQUE KEY `IdUsuario` (`IdUsuario`);

--
-- Indices de la tabla `carros`
--
ALTER TABLE `carros`
 ADD PRIMARY KEY (`IdFolio`), ADD KEY `IdUsuario` (`IdUsuario`), ADD KEY `IdCliente` (`IdCliente`), ADD KEY `IdFolio` (`IdFolio`), ADD KEY `UK_carros_IdCliente` (`IdCliente`), ADD KEY `UK_carros_IdUsuario` (`IdUsuario`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
 ADD PRIMARY KEY (`IdCliente`), ADD UNIQUE KEY `IdCliente` (`IdCliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `caja`
--
ALTER TABLE `caja`
MODIFY `IdCierre` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `carros`
--
ALTER TABLE `carros`
MODIFY `IdFolio` bigint(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carros`
--
ALTER TABLE `carros`
ADD CONSTRAINT `FK_carros_cajeros_IdUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `cajeros` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_carros_clientes_IdCliente` FOREIGN KEY (`IdCliente`) REFERENCES `clientes` (`IdCliente`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
