DROP DATABASE IF EXISTS futbol;
CREATE DATABASE IF NOT EXISTS futbol CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE futbol;

CREATE USER IF NOT EXISTS 'user'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON futbol.* TO 'user'@'localhost';

-- Crear tabla de equipos
CREATE TABLE equipos (
    id_equipo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    ciudad VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    capacidad INT,
    estadio VARCHAR(100),
    year_fundacion INT,
    presupuesto_anual DECIMAL(15, 2),
    division ENUM('La Liga', 'Segunda División', 'Segunda B') NOT NULL,
    web VARCHAR(100)
);

-- Crear tabla de jugadores
CREATE TABLE jugadores (
    id_jugador INT PRIMARY KEY AUTO_INCREMENT,
    id_equipo INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    nacionalidad VARCHAR(50) NOT NULL,
    posicion ENUM('Portero', 'Defensa', 'Centrocampista', 'Delantero') NOT NULL,
    numero_camiseta INT,
    altura_cm INT,
    peso_kg INT,
    pie_dominante ENUM('Derecha', 'Izquierda', 'Ambidextro'),
    salario_anual DECIMAL(12, 2),
    fecha_contrato DATE,
    FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo)
);

-- Insertar datos de equipos
INSERT INTO equipos (nombre, ciudad, provincia, capacidad, estadio, year_fundacion, presupuesto_anual, division, web) VALUES
('Real Madrid CF', 'Madrid', 'Madrid', 80000, 'Santiago Bernabéu', 1902, 600000000.00, 'La Liga', 'www.realmadrid.com'),
('FC Barcelona', 'Barcelona', 'Cataluña', 99000, 'Camp Nou', 1899, 580000000.00, 'La Liga', 'www.fcbarcelona.com'),
('Sevilla FC', 'Sevilla', 'Sevilla', 43883, 'Ramón Sánchez-Pizjuán', 1905, 120000000.00, 'La Liga', 'www.sevillafc.es'),
('Atlético Madrid', 'Madrid', 'Madrid', 70000, 'Metropolitano', 1903, 350000000.00, 'La Liga', 'www.atleticodemadrid.com'),
('Real Betis', 'Sevilla', 'Sevilla', 60000, 'Benito Villamarín', 1907, 80000000.00, 'La Liga', 'www.realbetis.es'),
('Granada CF', 'Granada', 'Granada', 23000, 'Nuevo Los Cármenes', 1931, 30000000.00, 'Segunda División', 'www.granadacf.es'),
('Córdoba CF', 'Córdoba', 'Córdoba', 14500, 'El Arcángel', 1954, 15000000.00, 'Segunda División', 'www.cordobacf.com');

-- Insertar datos de jugadores
INSERT INTO jugadores (id_equipo, nombre, apellidos, fecha_nacimiento, nacionalidad, posicion, numero_camiseta, altura_cm, peso_kg, pie_dominante, salario_anual, fecha_contrato) VALUES
(1, 'Luca', 'Modric', '1985-09-09', 'Croacia', 'Centrocampista', 10, 180, 76, 'Derecha', 15000000.00, '2023-07-01'),
(1, 'Vinícius', 'Junior', '2000-07-12', 'Brasil', 'Delantero', 20, 176, 73, 'Izquierda', 12000000.00, '2023-06-15'),
(1, 'Andriy', 'Lunin', '1999-02-11', 'Ucrania', 'Portero', 1, 186, 82, 'Derecha', 5000000.00, '2023-08-01'),
(2, 'Robert', 'Lewandowski', '1988-08-21', 'Polonia', 'Delantero', 9, 184, 81, 'Derecha', 16000000.00, '2023-07-01'),
(2, 'Pedri', 'González', '2002-11-25', 'España', 'Centrocampista', 26, 174, 65, 'Izquierda', 6000000.00, '2023-06-01'),
(3, 'Néstor', 'Fernández', '1990-03-15', 'España', 'Defensa', 3, 182, 78, 'Derecha', 2500000.00, '2023-07-01'),
(3, 'Isco', 'Alarcón', '1992-04-21', 'España', 'Centrocampista', 22, 176, 72, 'Izquierda', 3500000.00, '2023-08-01'),
(4, 'Antoine', 'Griezmann', '1991-03-21', 'Francia', 'Delantero', 7, 176, 73, 'Izquierda', 10000000.00, '2023-07-01'),
(5, 'Nabil', 'Fekir', '1994-07-18', 'Francia', 'Centrocampista', 8, 175, 74, 'Izquierda', 4000000.00, '2023-06-15'),
(6, 'Rioja', 'Ángela', '1999-05-10', 'España', 'Delantero', 10, 177, 71, 'Derecha', 800000.00, '2023-09-01'),
(6, 'Rodríguez', 'Manel', '2000-08-22', 'España', 'Portero', 1, 185, 80, 'Derecha', 400000.00, '2023-08-15'),
(7, 'Flores', 'Juan Manuel', '1995-12-03', 'España', 'Defensa', 4, 181, 77, 'Derecha', 350000.00, '2023-07-10'),
(2, 'Gavi', 'Pablo Páez', '2004-08-05', 'España', 'Centrocampista', 6, 173, 63, 'Derecha', 4000000.00, '2023-06-01');

-- EJERCICIOS DE JOIN

-- 1. LEFT JOIN - Todos los equipos con sus jugadores (si existen)
SELECT equipos.nombre, jugadores.nombre from equipos LEFT JOIN jugadores on equipos.id_equipo=jugadores.id_equipo ORDER BY equipos.id_equipo;

-- 2. RIGHT JOIN - Todos los jugadores con datos de su equipo
SELECT jugadores.nombre, equipos.* from equipos LEFT JOIN jugadores on equipos.id_equipo=jugadores.id_equipo ORDER BY equipos.id_equipo;

-- 4. Salario promedio por equipo
SELECT equipos.nombre, AVG(jugadores.salario_anual) from equipos JOIN jugadores on equipos.id_equipo=jugadores.id_equipo GROUP BY equipos.nombre; 

-- 5. Equipos sin jugadores registrados
SELECT equipos.nombre, jugadores.nombre from equipos LEFT JOIN jugadores on equipos.id_equipo=jugadores.id_equipo WHERE jugadores.id_equipo=NULL;

-- 6. Jugadores por posición en cada equipo
SELECT equipos.nombre, jugadores.posicion from equipos LEFT JOIN jugadores on equipos.id_equipo=jugadores.id_equipo ORDER BY equipos.id_equipo;

-- 7. Comparativa de presupuestos vs gasto en jugadores
select equipos.nombre ,equipos.presupuesto_anual, SUM(jugadores.salario_anual) as suma_total_salarios from equipos LEFT JOIN jugadores on equipos.id_equipo=jugadores.id_equipo GROUP BY equipos.id_equipo;
