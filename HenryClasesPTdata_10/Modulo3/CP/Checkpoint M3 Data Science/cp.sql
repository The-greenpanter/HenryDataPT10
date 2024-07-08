USE new_checkpoint_m3;
-- Reservas 2078 pero no 2079

SELECT COUNT(DISTINCT uid) AS Reservas_unicas
FROM reserva
WHERE YEAR(fecha_inicio) = 2078
AND uid NOT IN (
	SELECT uid
    FROM reserva
    WHERE YEAR (fecha_inicio) = 2079);

-- Reservas con menos de una estrella

-- Reservas habitd INT -> hoteles_habitaciones - habid INT

USE new_checkpoint_m3;

SELECT 
	COUNT(DISTINCT r.resvid)AS NumReservas
FROM
    reserva r
INNER JOIN
    hoteles_habitaciones hh
ON 
    r.habid = hh.habid
WHERE hh.estrellas = 1 
AND YEAR (r.fecha_inicio) = 2099

-- Reservas 2048 pero no 2049

SELECT COUNT(DISTINCT uid) AS Reservas_unicas
FROM reserva
WHERE YEAR(fecha_inicio) = 2048
AND uid NOT IN (
	SELECT uid
    FROM reserva
    WHERE YEAR (fecha_inicio) = 2049);

-- Restaurantes por region

-- Region > rid --> restaurante_platos >rid

USE new_checkpoint_m3;

SELECT 
	COUNT(rest.rid)AS restaurantesPorRegion
FROM
    restaurante_platos rest
INNER JOIN
    region reg
ON 
    rest.rid = reg.rid
WHERE reg.Nombre = 'Antofagasta'

-- Reservas usuario UID 235

USE new_checkpoint_m3;

SELECT 
	COUNT( UID)AS numeroReservas
FROM reserva
WHERE UID = 235

-- Promedio de estrellas para la region de 'Coquimbo'


USE new_checkpoint_m3;

SELECT 
	AVG(hh.estrellas)AS promedioEstrellas
FROM
    hoteles_habitaciones hh
INNER JOIN
    region reg
ON 
    hh.rid = reg.rid
WHERE reg.Nombre = 'Coquimbo'

-- Habitacion mas cara de una estrella

USE new_checkpoint_m3;

SELECT 
	MAX(precio) AS PPmayor
FROM
    hoteles_habitaciones hh
WHERE hh.estrellas = 1

-- Reservas 2020 y 2023

SELECT COUNT(DISTINCT uid) AS Reservas_unicas
FROM reserva
WHERE YEAR(fecha_inicio) = 2020
AND uid NOT IN (
	SELECT uid
    FROM reserva
    WHERE YEAR (fecha_inicio) = 2023);


-- RESERVAS CON 4 ESTRELLAS 

USE new_checkpoint_m3;
-- Reservas 2078 pero no 2079

SELECT COUNT(DISTINCT uid) AS Reservas_unicas
FROM reserva
WHERE YEAR(fecha_inicio) = 2078
AND uid NOT IN (
	SELECT uid
    FROM reserva
    WHERE YEAR (fecha_inicio) = 2079);

-- Reservas con menos de una estrella

-- Reservas habitd INT -> hoteles_habitaciones - habid INT

USE new_checkpoint_m3;

SELECT 
	COUNT(DISTINCT r.resvid)AS NumReservas
FROM
    reserva r
INNER JOIN
    hoteles_habitaciones hh
ON 
    r.habid = hh.habidx
WHERE hh.estrellas = 1 
AND YEAR (r.fecha_inicio) = 2099;

USE new_checkpoint_m3;
-- Reservas 2048 pero no 2049

SELECT COUNT(DISTINCT uid) AS Reservas_unicas
FROM reserva
WHERE YEAR(fecha_inicio) = 2048
AND uid NOT IN (
	SELECT uid
    FROM reserva
    WHERE YEAR (fecha_inicio) = 2049);
    
-- Restaurantes por region

-- Region > rid --> restaurante_platos >rid

USE new_checkpoint_m3;

SELECT 
	COUNT(rest.rid)AS restaurantesPorRegion
FROM
    restaurante_platos rest
INNER JOIN
    region reg
ON 
    rest.rid = reg.rid
WHERE reg.Nombre = 'Antofagasta';

-- Opcion 2

USE new_checkpoint_m3;

SELECT 
    reg.Nombre AS Region,
    COUNT(rest.rid) AS restaurantesPorRegion
FROM
    restaurante_platos rest
INNER JOIN
    region reg
ON 
    rest.rid = reg.rid
WHERE reg.Nombre = 'Antofagasta'
GROUP BY reg.Nombre;


-- Reservas usuario UID 235

USE new_checkpoint_m3;

SELECT 
	COUNT( UID)AS numeroReservas
FROM reserva
WHERE UID = 235;

-- Promedio de estrellas para la region de 'Coquimbo'


USE new_checkpoint_m3;

SELECT 
	AVG(hh.estrellas)AS promedioEstrellas
FROM
    hoteles_habitaciones hh
INNER JOIN
    region reg
ON 
    hh.rid = reg.rid
WHERE reg.Nombre = 'Coquimbo';

-- Habitacion mas cara de una estrella

USE new_checkpoint_m3;

SELECT 
	precio AS PPmayor
FROM
    hoteles_habitaciones hh
WHERE hh.estrellas < 2
ORDER BY precio DESC;

-- Reservas 2020 y 2023

SELECT COUNT(DISTINCT uid) AS Reservas_unicas
FROM reserva
WHERE YEAR(fecha_inicio) = 2020
AND uid NOT IN (
	SELECT uid
    FROM reserva
    WHERE YEAR (fecha_inicio) = 2023);
    

-- RESERVAS CON 4 ESTRELLAS 

SELECT COUNT(*) AS reservasAno

FROM reserva r 

INNER JOIN
    hoteles_habitaciones hh
ON
    r.habid = hh.habid
WHERE hh.estrellas = 4 AND YEAR(fecha_inicio) =2023