-- Nivel 1: JOIN Básicos

-- 1. Muéstrame las Personas y sus coches (solo los que tengan algun coche)
select * from personas inner join coches coche on personas.id=coche.id_dueño;
-- 2. Coches con información de dueños como su nombre y su provincia
select nombre, provincia, coche.* from personas inner join coches coche on personas.id=coche.id_dueño;
-- 3. Personas que tienen coches y su estado civil
select estado_civil, coche.* from personas inner join coches coche on personas.id=coche.id_dueño;

-- 4. Coches de personas ricas (niv socioeconomico alto)
select coches.*, personas.nivel_socioeconomico from coches  inner join personas on personas.nivel_socioeconomico = "alto";
-- 5. Ocupaciones (distintas) de dueños de coches mayores de 30 años
select personas.ocupacion, coches.* from personas inner join coches on extract(year from now())-extract(year from fecha_nacimiento) > 30;
-- Nivel 2: LEFT JOIN

-- 6. Todas las personas y sus coches (incluyendo sin coches)
select * from personas left join coches on personas.id=coches.id_dueño;
-- 7. Personas sin coches registrados
select personas.* from personas LEFT JOIN coches on coches.marca= NULL;
-- 8. Provincias con y sin representación de coches

-- 9. Nivel de estudios de las personas sin coche
select personas.nivel_estudios from personas LEFT JOIN coches on coches.marca= NULL;
-- 10. Personas jubiladas con sus vehículos
select personas.nombre, personas.ocupacion, coches.* from coches LEFT JOIN personas on personas.ocupacion="jubilado";

-- Nivel 3: JOINS con Agregaciones

-- 11. Número de coches por persona
SELECT personas.nombre, COUNT(*) as numero_coches_persona from personas INNER JOIN coches on coches.id_dueño=personas.id GROUP BY personas.id;
-- 12. Marca más común entre personas de cada provincia

-- 13. Promedio de edad de dueños por marca de coche

-- 14. Total de ingresos de dueños por color de coche

-- 15. Municipios con más coches


-- Nivel 4: JOINS Complejos

-- 16. Padres e hijos y sus coches

-- 17. Parejas con algún hijo y sus coches

-- 18. Personas de la misma familia con más de dos coches