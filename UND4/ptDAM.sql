
-- (floor(datediff(now(),fecha_nacimiento)/365)) Esto calcula la edad de una persona

-- 1 dime el nombre y apellido de los cinco malagueños (provincia) de más edad
SELECT nombre,apellido,(extract(year from now())-extract(year from fecha_nacimiento)) AS edad FROM personas WHERE provincia = 'malaga' ORDER BY fecha_nacimiento ASC LIMIT 5;

-- 2 dime el maximo de ingresos anuales que tiene una persona con estudios primarios.
    select max(ingresos_anuales) from personas where nivel_estudios = "primarios";
-- 3  dime la edad media de las personas cuya ocupación comience por la letra A
select avg(floor(datediff(now(),fecha_nacimiento)/365)) as edad_media from personas where ocupacion like 'a%';

-- 4  Dime las 3 primeras letras del estado civil de las personas de Dos Hermanas (pueblo, no que tengan hermanas).
select substring(estado_civil,1,3) from personas where municipio = "Dos hermanas";

-- 5  Cuenta el numero de personas que son padre siendo mujer o madre siendo hombre


-- 6  Dime la moda del estado civil
select max(conteo) from (select estado_civil,count(estado_civil) as conteo from personas group by estado_civil) a;

-- 7  Dime cuantos municipios diferentes de la provincia de Cádiz aparecen en la base de datos. 
select municipio from personas where provincia = "Cádiz" group by municipio;

select count(*) from (select municipio from personas where provincia = "Cádiz" group by municipio) a; -- esto me da cuantos, en numero no cada uno de los municipios


-- 8  Dime la media de ingresos_anuales agrupada por estado_civil.
select estado_civil,avg(ingresos_anuales) as media_ingresos from personas group by estado_civil;

-- 9  Dime los abuelos de la persona con id 1144

-- 10 Dime los nietos de la persona con id 1093

-- 11 Dime la media de numero de hijos por mujer.

-- 12 Dime los 5 granadinos (provincia) que más cobran ordenados por la longitud en letras de su ocupacion. 

-- 13 Dime la provincia con menos ingresos anuales de media.
    select provincia,round(avg(ingresos_anuales),2) as media_ingresos from personas group by provincia order by round(avg(ingresos_anuales),2) asc limit 1;

-- 14 Dime la provincia que tiene a los jubilados con menores ingresos anuales de media.
    select provincia,ocupacion,round(avg(ingresos_anuales),2) as media_ingresos from personas where ocupacion = "jubilado" group by provincia order by round(avg(ingresos_anuales),2) asc limit 1;

-- 15 Dime el municipio con mas ingresos anuales sin contar a las personas que no cobran nada.
select max(ingresos_totales) as top_ingresos from (select sum(ingresos_anuales) as ingresos_totales from personas where ingresos_anuales > 0 group by municipio order by sum(ingresos_anuales) desc) a ;

-- 16 dime la media de edad de las personas con algun hijo con nombre empezando por la L.

-- 17 Dime la edad media de las personas que sean hermanas (de padre o de madre) de las personas de Málaga municipio.

-- 18 Dime la media de salarios anuales agrupados por el dia del mes en el que nacieron.

-- 19 Muestra la fecha de nacimiento en dia, mes y año de los jubilados que viven en Córdoba.

-- 20 Muestra la cantidad de personas que nacieron en cada década del siglo XX.
SELECT FLOOR(YEAR(fecha_nacimiento) / 10) * 10 AS decada, COUNT(*) AS cantidad_personas FROM personas WHERE fecha_nacimiento BETWEEN '1901-01-01' AND '2000-12-31' GROUP BY decada ORDER BY decada;

-- 21. Muestra las 3 provincias con más edad media entre las personas casadas.

-- 22. Muestra el municipio (o municipios) con más personas paradas.

-- 23. Muestra cada municipio junto con el valor máximo de ingresos_anuales de entre las personas que son padres.