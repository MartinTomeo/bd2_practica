USE tp;
-- Se debe ingresar el ID del empleado (para validar que sea project manager). Además de que cliente y proyecto se quiere la liquidación.
DELIMITER $$
CREATE PROCEDURE ajusteLiquidacion(
IN empleado_id INTEGER,
IN cliente_razon_social VARCHAR(255),
IN proyecto_descripcion VARCHAR(255),
IN mes INTEGER,
IN anyo INTEGER)
BEGIN

-- Verifica que exista una liquidacion del mes previa, para ajustar:
SELECT 0 INTO @validacion;
SELECT DISTINCT 1 INTO @validacion
FROM liquidacion AS l
WHERE l.proyecto_descripcion = proyecto_descripcion AND l.cliente = cliente_razon_social AND l.mes = mes;

-- Obtiene rol del empleado:
SELECT "" INTO @puesto;
SELECT DISTINCT r.descripcion INTO @puesto
FROM rol AS r
INNER JOIN asignacion AS a ON a.id_rol = r.id_rol AND a.id_empleado = empleado_id
WHERE r.descripcion = "Project Manager";

-- Obtiene razon social del cliente:
SELECT "" INTO @cliente;
SELECT DISTINCT c.razon_social INTO @cliente
FROM cliente AS c
WHERE c.razon_social  = cliente_razon_social;

-- Obtiene descripcion del proyecto:
SELECT "" INTO @proyecto_descripcion;
SELECT DISTINCT p.descripcion INTO @proyecto_descripcion
FROM proyecto AS p
WHERE p.descripcion = proyecto_descripcion;

-- Obtiene id del proyecto
SELECT 0 INTO @id_proyecto;
SELECT DISTINCT p.id_proyecto INTO @id_proyecto
FROM proyecto AS p
WHERE p.descripcion = proyecto_descripcion;

-- Cantidad de empleados:
SELECT 0 INTO @cant_empleados;
SELECT COUNT(DISTINCT a.id_empleado) INTO @cant_empleados
FROM asignacion AS a
WHERE a.id_proyecto = @id_proyecto;

-- Cantidad de horas liquidadas:
SELECT 0 INTO @horas;
SELECT SUM(rh.cant_horas) INTO @horas
FROM asignacion AS a
INNER JOIN rendicion_hora AS rh ON rh.id_asignacion = a.id_asignacion
WHERE a.id_proyecto = @id_proyecto AND MONTH(rh.fecha_rendicion) = mes AND YEAR(rh.fecha_rendicion) = anyo;

-- Horas no liquidadas:
SELECT 0 INTO @horasLiquidadas;
SELECT SUM(l.horas) INTO @horasLiquidadas
FROM liquidacion AS l
WHERE l.proyecto_descripcion = proyecto_descripcion AND l.mes = mes;
SET @horas = @horas - @horasLiquidadas;

-- Valida rol / cliente / proyecto del empleado:
IF @puesto = "Project Manager" AND  @cliente !="" AND @proyecto_descripcion != ""  AND @horas>0 AND @validacion=1 THEN
-- Datos validos:
INSERT INTO liquidacion (fecha_liquidacion, proyecto_descripcion, cliente, mes, horas, cant_empleados, solicitante)
VALUES (now(), @proyecto_descripcion, @cliente, mes, @horas, @cant_empleados, empleado_id);
ELSE
-- Datos no validos:
SELECT "Los datos ingresados no son correctos.";
END IF;

END
$$

-- ----------------------------------- EJEMPLO ------------------------------------------
-- CALL ajusteLiquidacion(1, "Armando Manchini S.R.L.", "Proyecto 1", 9, 2022);