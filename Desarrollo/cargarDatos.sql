DELIMITER $$
create procedure cargarDatos() 
begin

-- ----------------------------------- CREACIÓN DE EMPLEADOS ------------------------------------------

declare i int default 0;
declare contRol int default 0;
declare contProyecto int default 1;
declare contCliente int default 1;
declare numInsert int default 1;

create temporary table nombre_empleado (
	nombre varchar(90)
);

create temporary table apellido_empleado (
	apellido varchar(90)
);

insert into nombre_empleado (nombre) values ('Martín');
insert into nombre_empleado (nombre) values ('Mariano');
insert into nombre_empleado (nombre) values ('Gabriel');
insert into nombre_empleado (nombre) values ('Tomás');
insert into nombre_empleado (nombre) values ('Pedro');
insert into nombre_empleado (nombre) values ('Juan');
insert into nombre_empleado (nombre) values ('Delfina');
insert into nombre_empleado (nombre) values ('Martina');
insert into nombre_empleado (nombre) values ('Camila');
insert into nombre_empleado (nombre) values ('Carolina');

insert into apellido_empleado (apellido) values ('Pérez');
insert into apellido_empleado (apellido) values ('Pratt');
insert into apellido_empleado (apellido) values ('Rodríguez');
insert into apellido_empleado (apellido) values ('Antola');
insert into apellido_empleado (apellido) values ('Barreto');
insert into apellido_empleado (apellido) values ('Paredes');
insert into apellido_empleado (apellido) values ('López');
insert into apellido_empleado (apellido) values ('Rabufetti');
insert into apellido_empleado (apellido) values ('Gandolfi');
insert into apellido_empleado (apellido) values ('Sambucetti');
insert into apellido_empleado (apellido) values ('López');
insert into apellido_empleado (apellido) values ('Tarufeti');

insert into empleado (nombre, apellido) 
select ne.nombre, ae.apellido
from nombre_empleado ne, apellido_empleado ae;

drop table nombre_empleado, apellido_empleado;

-- ----------------------------------- CREACIÓN DE ROLES ------------------------------------------

insert into rol (descripcion, limite_horario) values ('Project Manager', 40);
insert into rol (descripcion, limite_horario) values ('Frontend', 35);
insert into rol (descripcion, limite_horario) values ('Backend', 35);
insert into rol (descripcion, limite_horario) values ('Tester', 20);
insert into rol (descripcion, limite_horario) values ('Administrador', 40);
insert into rol (descripcion, limite_horario) values ('DevOps', 35);
insert into rol (descripcion, limite_horario) values ('QA', 28);
insert into rol (descripcion, limite_horario) values ('Desarrollador SQL', 30);
insert into rol (descripcion, limite_horario) values ('Mantenimiento', 25);
insert into rol (descripcion, limite_horario) values ('UX-UI', 35);

-- ----------------------------------- CREACIÓN DE CLIENTES ------------------------------------------

create temporary table nombre_empresa (
	nombre varchar(90)
);

create temporary table nombre_agregado (
	nombre varchar(90)
);

create temporary table tipo_societario (
	tipo varchar(6)
);

insert into nombre_empresa (nombre) values ('Armando');
insert into nombre_empresa (nombre) values ('Juarez');
insert into nombre_empresa (nombre) values ('Taborda');


insert into nombre_agregado (nombre) values ('Manchini');
insert into nombre_agregado (nombre) values ('Barreiro');

insert into tipo_societario (tipo) values ('S.A.');
insert into tipo_societario (tipo) values ('S.R.L.');

insert into cliente (razon_social) 
select concat(n1.nombre, ' ', na.nombre, ' ', ts.tipo)
from nombre_empresa n1, nombre_agregado na, tipo_societario ts;

drop table nombre_empresa, nombre_agregado, tipo_societario;

-- ----------------------------------- CREACIÓN DE PROYECTOS ------------------------------------------

set i = 0;

while i < 12 do
        set i =  i + 1;
		insert into proyecto (descripcion) values ( concat('Proyecto' , ' ', i) );
end while;

-- ----------------------------------- CREACIÓN DE ASIGNACIONES ------------------------------------------

set i = 0;

while i < 120 do

		set i = i + 1;
        set contRol = contRol + 1;
        
        if contRol > 10 then
			set contRol = 1;
        end if;
        
		insert into asignacion (id_empleado, id_rol, id_proyecto, id_cliente)
			values(i, contRol, contProyecto, contCliente);
		
        set numInsert = numInsert + 1;
        
		if numInsert > 10 then
			set numInsert = 1;
            set contProyecto = contProyecto + 1;
			set contCliente = contCliente + 1;
        end if;
end while;
end
$$

-- call cargarDatos();
 
