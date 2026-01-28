# 📘 MySQL y Consultas Simples
[Tabla Resumen Comandos](#tabla-resumen-de-comandos)

## 🔹 1. Consultas Básicas con SELECT

**Permite obtener datos de una tabla.**

```sql
SELECT columna1, columna2 FROM tabla;
SELECT * FROM tabla;
SELECT id, nombre FROM empleados;
```
## 🔹 2. Filtrado con WHERE y DISTINCT
📌 WHERE

**Filtra registros según una condición.**

```sql
SELECT * FROM empleados WHERE salario > 4000;
```
📌 DISTINCT

**Elimina valores duplicados.**

```sql
SELECT DISTINCT departamento FROM empleados;
```
**Combinación**
```sql
SELECT DISTINCT departamento 
FROM empleados 
WHERE salario > 3000 AND ciudad = 'Madrid';
```
## 🔹 3. Operadores
| Operador | Significado   |
| -------- | ------------- |
| =        | Igual         |
| !=, <>   | Distinto      |
| >        | Mayor         |
| <        | Menor         |
| >=       | Mayor o igual |
| <=       | Menor o igual |

```sql
SELECT * FROM clientes WHERE ciudad = 'Madrid';
SELECT * FROM clientes WHERE ciudad <= 'Madrid';
```
**✔ Operadores lógicos**

- AND → Ambas condiciones.
- OR → Una u otra.
- NOT → Niega la condición.

```sql
SELECT * FROM empleados 
WHERE salario > 3000 AND edad < 40;
```
## 🔹 4. Búsqueda por patrón y rangos
🔎 LIKE

**Busca coincidencias parciales.**

```sql
SELECT * FROM empleados WHERE nombre LIKE 'M%'; -- empieza por M
SELECT * FROM clientes WHERE apellido LIKE '%ez'; -- termina por ez
SELECT * FROM empleados WHERE nombre LIKE '%an%'; -- contiene an
SELECT * FROM empleados WHERE nombre NOT LIKE '%an%'; -- NO contiene an
SELECT * FROM empleados WHERE nombre LIKE '___o'; -- 4 huecos el ultimo es una o
```
📋 IN

**Busca dentro de una lista.**
```sql
SELECT * FROM empleados WHERE id IN (1,3,5);
```
📏 BETWEEN

**Filtra por rango.**
```sql
SELECT * FROM empleados 
WHERE salario BETWEEN 2500 AND 5000;
```
## 🔹 5. Valores NULL

```sql
SELECT * FROM empleados WHERE telefono IS NULL;
SELECT * FROM empleados WHERE telefono IS NOT NULL;
```
## 🔹 6. Ordenación con ORDER BY
**Ordena resultados.**
```sql
SELECT * FROM empleados ORDER BY salario DESC;
```
**Ordenación múltiple:**
```sql
SELECT * FROM empleados 
ORDER BY departamento ASC, salario DESC;
```
## 🔹 7. Limitación de Resultados con LIMIT
**Restringe la cantidad de filas.**
```sql
SELECT * FROM empleados 
ORDER BY salario DESC 
LIMIT 5;
```
## 🔹 8. Funciones de Agregación
| Función | Uso              |
| ------- | ---------------- |
| COUNT() | Contar registros |
| SUM()   | Sumar valores    |
| AVG()   | Promedio         |
| MAX()   | Máximo           |
| MIN()   | Mínimo           |

```sql
SELECT MAX(salario) FROM empleados;
SELECT AVG(salario) FROM empleados;
```

## 🔹 9. GROUP BY y HAVING
**Agrupa registros y filtra grupos.**
```sql
SELECT departamento, COUNT(*) 
FROM empleados 
GROUP BY departamento;
```
**Con HAVING:**
```sql
SELECT edad, AVG(salario) AS promedio
FROM empleados
GROUP BY edad
HAVING AVG(salario) > 3000;
```
## 🔹 10. Funciones de Texto
| Función       | Descripción                |
| ------------- | -------------------------- |
| CONCAT()      | Une textos                 |
| SUBSTRING()   | Extrae parte de una cadena |
| CHAR_LENGTH() | Cuenta caracteres          |
| REPLACE()     | Reemplaza texto            |
| TRIM()        | Elimina espacios           |

```sql
SELECT CONCAT(nombre,' ',apellido) FROM empleados;
SELECT SUBSTRING(nombre,1,3) FROM empleados;
SELECT REPLACE(nombre, 'Juan', 'Carlos') FROM empleados;
```
## 🔹 11. Funciones Numéricas

| Función | Descripción           |
| ------- | --------------------- |
| ROUND() | Redondea              |
| FLOOR() | Redondea hacia abajo  |
| CEIL()  | Redondea hacia arriba |
| RAND()  | Número aleatorio      |

```sql
SELECT ROUND(salario,2) FROM empleados;
SELECT FLOOR(1 + (RAND()*100));
```
## 🔹 12. Funciones de Fecha

| Función       | Descripción             |
| ------------- | ----------------------- |
| NOW()         | Fecha y hora actual     |
| DATE_FORMAT() | Formato de fecha        |
| DATEDIFF()    | Diferencia entre fechas |
| EXTRACT()     | Extraer partes de fecha |

```sql
SELECT NOW();
SELECT DATEDIFF(NOW(), fecha_ingreso) FROM empleados;
SELECT EXTRACT(YEAR FROM fecha_ingreso) FROM empleados;
SELECT DATE_FORMAT(campo a cambiar, '%h:%i:%s %p'); -- para cambiar a formato 12horas
```
## 🔹 13. Subconsultas

**Subconsultas Escalares: Devuelven un único valor.**
```sql
SELECT nombre
FROM empleados
WHERE salario > (SELECT AVG(salario) FROM empleados);
``` 

**Subconsultas de Columna: Devuelven una columna con múltiples valores**
```sql
SELECT nombre
FROM empleados
WHERE departamento IN (SELECT departamento FROM departamentos);
```

**Subconsultas de Tabla: Devuelven una tabla completa.**
```sql
SELECT *
FROM (SELECT nombre, salario FROM empleados WHERE salario > 4000) AS subconsulta;
```

**¿Dónde se Usan las Subconsultas?**

En WHERE:
```sql
SELECT nombre
FROM empleados
WHERE salario = (SELECT MAX(salario) FROM empleados);
```

En FROM:
```sql
SELECT sub.departamento, sub.salario_promedio
FROM (SELECT departamento, AVG(salario) AS salario_promedio FROM empleados GROUP BY departamento) AS sub;
```

En HAVING:
```sql
SELECT departamento, SUM(salario) AS total_salarios
FROM empleados
GROUP BY departamento
HAVING SUM(salario) > (SELECT AVG(salario) FROM empleados);
```

# Tabla Resumen de Comandos

| Comando / Función | Uso Principal        | Ejemplo                                 |
| ----------------- | -------------------- | --------------------------------------- |
| SELECT            | Consultar datos      | `SELECT * FROM empleados;`              |
| DISTINCT          | Eliminar duplicados  | `SELECT DISTINCT ciudad FROM clientes;` |
| WHERE             | Filtrar registros    | `WHERE salario > 3000`                  |
| AND / OR / NOT    | Condiciones lógicas  | `WHERE edad > 30 AND salario > 2000`    |
| LIKE              | Búsqueda por patrón  | `LIKE 'M%'`                             |
| IN                | Lista de valores     | `IN (1,2,3)`                            |
| BETWEEN           | Rango                | `BETWEEN 10 AND 50`                     |
| IS NULL           | Buscar nulos         | `IS NULL`                               |
| ORDER BY          | Ordenar resultados   | `ORDER BY salario DESC`                 |
| LIMIT             | Limitar filas        | `LIMIT 5`                               |
| COUNT             | Contar registros     | `COUNT(*)`                              |
| SUM               | Sumar valores        | `SUM(salario)`                          |
| AVG               | Promedio             | `AVG(salario)`                          |
| MAX / MIN         | Máximo / mínimo      | `MAX(salario)`                          |
| GROUP BY          | Agrupar              | `GROUP BY departamento`                 |
| HAVING            | Filtrar grupos       | `HAVING COUNT(*) > 3`                   |
| CONCAT            | Unir texto           | `CONCAT(nombre,apellido)`               |
| SUBSTRING         | Extraer texto        | `SUBSTRING(nombre,1,3)`                 |
| ROUND             | Redondear            | `ROUND(3.456,2)`                        |
| NOW               | Fecha actual         | `NOW()`                                 |
| DATEDIFF          | Diferencia de fechas | `DATEDIFF(fecha1,fecha2)`               |
| Subconsulta       | Consulta anidada     | `WHERE salario > (SELECT AVG...)`       |

