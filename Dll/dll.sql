-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.37 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para tp
CREATE DATABASE IF NOT EXISTS `tp` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `tp`;

-- Volcando estructura para tabla tp.asignacion
CREATE TABLE IF NOT EXISTS `asignacion` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_empleado` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id_asignacion`,`id_empleado`,`id_rol`,`id_proyecto`,`id_cliente`),
  KEY `fk1` (`id_empleado`),
  KEY `fk2` (`id_rol`),
  KEY `fk3` (`id_proyecto`),
  KEY `fk4` (`id_cliente`),
  CONSTRAINT `asignacion_ibfk_1` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `asignacion_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`),
  CONSTRAINT `asignacion_ibfk_3` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`),
  CONSTRAINT `asignacion_ibfk_4` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla tp.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla tp.empleado
CREATE TABLE IF NOT EXISTS `empleado` (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(90) NOT NULL,
  `apellido` varchar(90) NOT NULL,
  PRIMARY KEY (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla tp.liquidacion
CREATE TABLE IF NOT EXISTS `liquidacion` (
  `id_liquidacion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_liquidacion` datetime NOT NULL,
  `proyecto_descripcion` varchar(255) NOT NULL,
  `cliente` varchar(255) NOT NULL,
  `mes` int(11) NOT NULL,
  `horas` int(11) NOT NULL,
  `cant_empleados` int(11) NOT NULL,
  `solicitante` int(11) NOT NULL,
  PRIMARY KEY (`id_liquidacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla tp.proyecto
CREATE TABLE IF NOT EXISTS `proyecto` (
  `id_proyecto` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`id_proyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla tp.rendicion_hora
CREATE TABLE IF NOT EXISTS `rendicion_hora` (
  `id_rendicion` int(11) NOT NULL AUTO_INCREMENT,
  `id_asignacion` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fecha_rendicion` date NOT NULL,
  `cant_horas` int(11) NOT NULL,
  PRIMARY KEY (`id_rendicion`),
  KEY `fk1` (`id_asignacion`),
  KEY `fk2` (`id_rol`),
  CONSTRAINT `rendicion_hora_ibfk_1` FOREIGN KEY (`id_asignacion`) REFERENCES `asignacion` (`id_asignacion`),
  CONSTRAINT `rendicion_hora_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla tp.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  `limite_horario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
