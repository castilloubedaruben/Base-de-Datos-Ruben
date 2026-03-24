# GLOSARIO COMPLETO MYSQL (EXAMEN)

## 1. CREACIÓN Y GESTIÓN DE USUARIOS
🔸 CREATE USER

**Crea un usuario en MySQL.**
```sql
CREATE USER 'usuario'@'host' IDENTIFIED BY 'password';
```
📌 Ejemplos de tus apuntes:

```sql
CREATE USER "sakila_admin"@"localhost" IDENTIFIED BY "AdminPass123";
CREATE USER "sakila_user"@"%" IDENTIFIED BY "UserPass456";
```
 **CLAVES IMPORTANTES:**
```sql
'localhost' → solo en tu PC
'%' → desde cualquier IP
'192.168.1.%' → red concreta
```
🔸 SELECT USER, HOST

**Ver usuarios del sistema**
```sql
SELECT User, Host FROM mysql.user;
```
🔸 ALTER USER

 **Cambiar contraseña o configuración**
```sql
ALTER USER 'usuario'@'host' IDENTIFIED BY 'nueva_password';
```
📌 Ejemplo:
```sql
ALTER USER "sakila_admin"@"localhost" IDENTIFIED BY "NewSecurePass789";
```
🔸 PASSWORD EXPIRE

👉 **Obliga a cambiar contraseña**
```sql
ALTER USER 'usuario'@'host' PASSWORD EXPIRE;
```
🔸 DROP USER

**Elimina un usuario**
```sql
DROP USER 'usuario'@'host';
```
📌 Ejemplo:
```sql
DROP USER sakila_user;
```
## 2. PRIVILEGIOS (PERMISOS)
🔸 GRANT 

**Dar permisos**

```sql
GRANT privilegios ON base.tabla TO 'usuario'@'host';
```
📌 Ejemplos:
```sql
GRANT ALL ON sakila.* TO "sakila_admin"@"localhost";
GRANT SELECT, INSERT ON sakila.film TO sakila_user;
```

**TIPOS DE PRIVILEGIOS:**

SELECT → leer
INSERT → insertar
UPDATE → modificar
DELETE → borrar
ALL → todo

🔸 REVOKE

**Quitar permisos**
```sql
REVOKE INSERT ON sakila.film FROM sakila_user;
```
🔸 SHOW GRANTS

**Ver permisos de un usuario**
```sql
SHOW GRANTS FOR 'usuario'@'host';
```
🔸 FLUSH PRIVILEGES

 **Aplicar cambios**

FLUSH PRIVILEGES;

📌 IMPORTANTE: sin esto, los cambios pueden no aplicarse.

## 3. ROLES (MUY IMPORTANTE EN EXAMEN)
🔸 CREATE ROLE

**Crear rol**
```sql
CREATE ROLE nombre_rol;
```
🔸 GRANT (a rol)

**Dar permisos al rol**
```sql
GRANT SELECT, INSERT ON db.tabla TO rol;
```
🔸 GRANT (rol a usuario)

**Asignar rol**
```sql
GRANT rol TO usuario;
```
🔸 SET DEFAULT ROLE

**Activar rol automáticamente**
```sql
SET DEFAULT ROLE rol TO usuario;
```
📌 DIFERENCIA CLAVE (MUY PREGUNTABLE):

- GRANT rol → lo tiene pero NO activo

- SET DEFAULT ROLE → activo siempre

🔸 CURRENT_USER / CURRENT_ROLE
```sql
SELECT CURRENT_USER(), CURRENT_ROLE();
```

**Saber quién eres y qué rol tienes activo**

## 4. ÍNDICES (RENDIMIENTO)
🔸 CREATE INDEX
```sql
CREATE INDEX nombre_indice ON tabla(columna);
```
📌 Ejemplo:
```sql
CREATE INDEX idx_first_name ON customer(first_name);
```
🔸 ÍNDICE COMPUESTO
```sql
CREATE INDEX idx ON tabla(col1, col2);
```
🔸 UNIQUE INDEX
```sql
CREATE UNIQUE INDEX idx ON tabla(columna);
```

👉 No permite duplicados

🔸 SHOW INDEX
```sql
SHOW INDEX FROM tabla;
```
🔸 DROP INDEX
```sql
DROP INDEX idx ON tabla;
```
## 5. CREACIÓN DE BASES Y TABLAS
🔸 CREATE DATABASE
```sql
CREATE DATABASE nombre;
USE nombre;
```

📌 Ejemplo real:
```sql
CREATE DATABASE if not exists billar;
USE billar;
```

🔸 CREATE TABLE
```sql
CREATE TABLE tabla (
    id INT AUTO_INCREMENT PRIMARY KEY,
    campo VARCHAR(50)
);
```
🔸 FOREIGN KEY
```sql
FOREIGN KEY (columna) REFERENCES tabla(columna)
```

📌 Ejemplo:
```sql
ALTER TABLE jugador ADD CONSTRAINT fk_jugador_torneo 
FOREIGN KEY (torneo_id) REFERENCES torneo(id);
```

🔸 UNIQUE
UNIQUE (columna)

👉 No permite duplicados

🔸 CHECK
CHECK (condición)

📌 Ejemplo:
```sql
CHECK (fecha > '2025-12-31')
```

## 6. ALTER TABLE (MUY IMPORTANTE)
🔸 ADD COLUMN
```sql
ALTER TABLE tabla ADD columna tipo;
```
🔸 DROP COLUMN
```sql
ALTER TABLE tabla DROP COLUMN columna;
```

📌 Ejemplo:
```sql
ALTER TABLE taco DROP COLUMN material;
```
🔸 MODIFY COLUMN
```sql
ALTER TABLE tabla MODIFY columna tipo;
```
🔸 CHANGE COLUMN
```sql
ALTER TABLE tabla CHANGE old new tipo;
```
📌 Ejemplo:

```sql
ALTER TABLE mesa CHANGE COLUMN numero identificador_mesa INT;
```

🔸 ADD CONSTRAINT

👉 Añadir restricciones

## 7. INSERT
```sql
INSERT INTO tabla (col1, col2) VALUES (valor1, valor2);
```

📌 Ejemplo:
```sql
INSERT INTO jugador (nombre) VALUES ('Carlos');
```

## 8. UPDATE (MUY IMPORTANTE)

🔸 Básico
```sql
UPDATE tabla SET columna = valor WHERE condición;
```
🔸 Con subconsulta
```sql
UPDATE jugador 
SET torneo_id = (SELECT id FROM torneo WHERE nombre = 'Torneo de Verano')
WHERE nombre = 'Carlos';
```

🔸 Con condiciones
```sql
WHERE columna IS NULL
WHERE MONTH(fecha) BETWEEN 7 AND 11
```

📌 Ejemplo real:
```sql
UPDATE jugador 
SET torneo_id = 1
WHERE torneo_id IN (SELECT id FROM torneo WHERE MONTH(fecha) BETWEEN 7 AND 11);
```

🔸 RAND()

```sql
ORDER BY RAND() LIMIT 1
```

👉 Seleccionar aleatorio

## 9. CONCEPTOS CLAVE QUE PUEDEN CAER
⚡ HOST en usuarios
- 'localhost' → solo local
- '%' → cualquier IP
  
⚡ DIFERENCIA GRANT vs ROLE
- GRANT → permiso directo
- ROLE → conjunto de permisos reutilizable

⚡ ÍNDICES
- Mejoran velocidad
- Se usan en búsquedas y JOINs

⚡ FOREIGN KEY
- Mantiene integridad
- Relaciona tablas

⚡ CHECK / UNIQUE
- Validación de datos


## CONSEJOS PARA EL EXAMEN (IMPORTANTE)

✅ Si te piden:

- Usuario → CREATE USER
- Permisos → GRANT / REVOKE
- Roles → CREATE ROLE
- Optimización → INDEX
- Modificar tabla → ALTER TABLE
- Relacionar tablas → FOREIGN KEY