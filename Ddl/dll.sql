CREATE DATABASE TP;
USE TP;

CREATE TABLE empleado(
	id_empleado INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	nombre VARCHAR(90) NOT NULL,
	apellido VARCHAR(90) NOT NULL
);

CREATE TABLE rol(
	id_rol INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	descripcion VARCHAR (255) NOT NULL,
	limite_horario INTEGER
);

CREATE TABLE cliente(
	id_cliente INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	razon_social VARCHAR(255) NOT NULL
);

CREATE TABLE proyecto(
	id_proyecto INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE asignacion(
	id_asignacion INTEGER AUTO_INCREMENT NOT NULL,
	id_empleado INTEGER NOT NULL,
	id_rol INTEGER NOT NULL,
	id_proyecto INTEGER NOT NULL,
	id_cliente INTEGER NOT NULL,
	CONSTRAINT PRIMARY KEY pk1(id_asignacion, id_empleado, id_rol, id_proyecto, id_cliente),
	CONSTRAINT FOREIGN KEY fk1(id_empleado) REFERENCES empleado(id_empleado),
	CONSTRAINT FOREIGN KEY fk2(id_rol) REFERENCES rol(id_rol),
	CONSTRAINT FOREIGN KEY fk3(id_proyecto) REFERENCES proyecto(id_proyecto),
	CONSTRAINT FOREIGN KEY fk4(id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE rendicion_hora(
	id_rendicion INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	id_asignacion INTEGER NOT NULL,
	id_rol INTEGER NOT NULL,
	fecha_rendicion DATE NOT NULL,
	cant_horas INTEGER NOT NULL,
	CONSTRAINT FOREIGN KEY fk1(id_asignacion) REFERENCES asignacion(id_asignacion),
	CONSTRAINT FOREIGN KEY fk2(id_rol) REFERENCES rol(id_rol)
);

CREATE TABLE liquidacion(
	id_liquidacion INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	fecha_liquidacion DATETIME NOT NULL,
	proyecto_descripcion VARCHAR(255) NOT NULL,
	cliente VARCHAR(255) NOT NULL,
	mes INTEGER NOT NULL,
	horas INTEGER NOT NULL,
	cant_empleados INTEGER NOT NULL,
	solicitante INTEGER NOT NULL
);