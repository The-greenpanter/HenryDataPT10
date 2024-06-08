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
AND YEAR (r.fecha_inicio) = 2099