
call cargarDatos(); -- Cargamos datos en la base de datos creada.

call cargaHoras(1, 1, '2022-08-01', 23, 1); -- Cargamos Id. proyecto, , Id. rol, fecha de comienzo de la carga horaria, 
											-- cantidad de días y cantidad de horas, en la tabla rendicion_horas.

select * from rendicion_hora;

call liquidacionMensual(1, "Armando Manchini S.R.L.", "Proyecto 1", 8, 2022); -- Cargamos Id. empleado, razón social, proyecto, mes y año,
																				-- en la tabla liquidación.
select * from liquidacion;

call cargaHoras(1, 1, '2022-08-01', 5, 3); -- Cargamos Id. proyecto, , Id. rol, fecha de comienzo de la carga horaria, 
											-- cantidad de días y cantidad de horas, un ajuste de horas cargadas, en la tabla rendicion_horas.

select * from rendicion_hora;

call ajusteLiquidacion(1, "Armando Manchini S.R.L.", "Proyecto 1", 8, 2022); -- Cargamos Id. empleado, razón social, proyecto, mes y año,
																				-- genero una fila en la tabla liquidación, que representa 
                                                                                -- el ajuste de las horas previamente cargadas.
select * from liquidacion;


