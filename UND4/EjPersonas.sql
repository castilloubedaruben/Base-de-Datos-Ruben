DROP DATABASE IF EXISTS andalucia_db;
CREATE DATABASE IF NOT EXISTS andalucia_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE andalucia_db;

-- Crear la tabla personas con estructura adecuada
CREATE TABLE personas (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    sexo ENUM('M', 'H') NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    provincia VARCHAR(100) NOT NULL,
    municipio VARCHAR(150) NOT NULL,
    nivel_estudios VARCHAR(50),
    situacion_laboral VARCHAR(50),
    ingresos_anuales INT,
    estado_civil VARCHAR(20),
    num_hijos INT,
    nivel_socioeconomico VARCHAR(20),
    ocupacion VARCHAR(50)
);

alter table personas add column madre INT;
alter table personas add column padre INT;
alter table personas add foreign key (padre) references personas(id);
alter table personas add foreign key (madre) references personas(id);

SET FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=1;

-- Ejercicios tabla personas

-- 1. Muestra la media de salario agrupada por ocupación
    select avg(ingresos_anuales),ocupacion from personas group by ocupacion;
-- 2. Muestra la media de salarios en cada provincia
    select avg(ingresos_anuales),provincia from personas group by provincia;
-- 3. Muestra la media de edad de cada nivel socioeconómico
select nivel_socioeconomico,avg(extract(year from now())-extract(year from fecha_nacimiento)) as edad_media from personas group by nivel_socioeconomico;
-- 4. Dime la edad de las personas de menos de 60 años ordenadas por situación laboral.
select situacion_laboral,avg(extract(year from now())-extract(year from fecha_nacimiento)) as edad_media from personas group by situacion_laboral having edad_media < 60;
-- 5. Muestra el nombre de la persona parada de más edad.
    select nombre from personas where (extract(year from now())-extract(year from fecha_nacimiento)) = (select max(extract(year from now())-extract(year from fecha_nacimiento)) as edad_maxima from personas where situacion_laboral = "estudiante");
-- 6. Dime la provincia con la máxima edad media.
    select provincia from personas where (extract(year from now())-extract(year from fecha_nacimiento)) = (select avg(extract(year from now())-extract(year from fecha_nacimiento)) as edad_media from personas group by provincia);
-- 7. Dime los hijos del ciudadano con id 1190

-- 8.  Muestra los nietos del ciudadano con id = 1190

-- 9.  Muestra la madre con más hijos

-- 10. Muestra la media de hijos por hombre

-- 11. Dime la media de hijos de personas con menos de 30 años.

-- 12. Muestra el valor de numero de hijos que más se repite entre las mujeres.

-- 13. Dime la media de edad de las mujeres sin hijos de Sevilla provincia

-- 14. Dime la media de las modas del campo edad.

-- 15. Dime la provincia con menor edad media de las personas estudiantes.

-- 16. Órdename los municipios por numero total de hijos en cada uno.

-- 17. ordena las provincias por mayor número medio de hijos por mujer (tasa de natalidad)

-- 18. Dime los municipios que no superan la tasa de reemplazo (más de 2 hijos por mujer) pero tienen un salario medio mayor a 3000 euros al mes

-- 19. Dime la provincia con la moda de edad más alta.

-- 20. Dime los 5 sevillanos (municipio) de más edad ordenados por la longitud de su apellido.

-- 21. Dime el municicpio con menos tasa de natalidad (num_hijos por mujer) de entre los municipios de Huelva con salario medio menor de 20000 euros anuales

