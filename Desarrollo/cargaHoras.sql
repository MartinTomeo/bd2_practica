DELIMITER $$
create procedure cargaHoras(
	in asignacion int,
    in rol int,
	in fecha_inicio date,
    in cant_dias int,
    in cant_horas int
)
begin
	declare i int default 0;
    declare fecha_agregar date;
    declare diaSemana int;
    declare insertDias int default 0;
    declare rolAsignado int default 0;
    declare horasTrabajadas int default 0;
    declare maximoHoras int default 0;
    
    select a.id_rol into rolAsignado from asignacion a where a.id_asignacion = asignacion; 
    
    select limite_horario into maximoHoras from rol where id_rol = rol;
    
	select sum(rh.cant_horas) into horasTrabajadas from rendicion_hora rh 
		where month(rh.fecha_rendicion) = month(fecha_inicio) and rh.id_asignacion = asignacion;
        
	set horasTrabajadas = ifnull(horasTrabajadas, 0);
            
	if rolAsignado <> rol then
    
		 select 'Datos ingresados incorrectos. Ingrese correctamente su rol' as mensaje;
    
    elseif cant_dias = 0 or cant_horas = 0 then	 
		
        select 'Datos ingresados incorrectos. Cantidad de horas y días trabajados' as mensaje;
    
    elseif NOT(horasTrabajadas >= maximoHoras) then
    
		miCiclo: while insertDias < cant_dias do
        
            select DATE_ADD(fecha_inicio, INTERVAL i DAY) into fecha_agregar;
            select DAYOFWEEK(fecha_agregar) into diaSemana;
            select limite_horario into maximoHoras from rol where id_rol = rol;
            select sum(rh.cant_horas) into horasTrabajadas from rendicion_hora rh 
				where month(rh.fecha_rendicion) = month(fecha_inicio) and rh.id_asignacion = asignacion;
			set horasTrabajadas = ifnull(horasTrabajadas, 0);
			set i =  i + 1;
            
           if horasTrabajadas >= maximoHoras then
				leave miCiclo;
            end if;
            
            if diaSemana <> 1 AND diaSemana <> 7 then
            
				if (horasTrabajadas + cant_horas ) > maximoHoras then
					set cant_horas = maximoHoras - horasTrabajadas;
				end if;

				insert into rendicion_hora (id_asignacion, id_rol, fecha_rendicion, cant_horas) 
					values(asignacion, rol, fecha_agregar, cant_horas);
                    
				set insertDias = insertDias + 1;
			end if;
            
		end while;

	end if;
end
$$