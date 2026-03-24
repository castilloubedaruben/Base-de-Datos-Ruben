DROP DATABASE IF EXISTS tributaria;
CREATE DATABASE IF NOT EXISTS tributaria CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tributaria;

CREATE USER IF NOT EXISTS 'user'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON tributaria.* TO 'user'@'localhost';

-- Crear tabla de contribuyentes
CREATE TABLE contribuyentes (
    id_contribuyente INT PRIMARY KEY AUTO_INCREMENT,
    nif VARCHAR(9) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(15),
    direccion VARCHAR(150) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(5),
    fecha_alta DATE NOT NULL,
    tipo_contribuyente ENUM('Persona Física', 'Empresa', 'Autónomo') NOT NULL
);

-- Crear tabla de declaraciones
CREATE TABLE declaraciones (
    id_declaracion INT PRIMARY KEY AUTO_INCREMENT,
    id_contribuyente INT NOT NULL,
    anio_fiscal INT NOT NULL,
    tipo_declaracion VARCHAR(50) NOT NULL,
    base_imponible DECIMAL(12, 2) NOT NULL,
    impuesto_debido DECIMAL(12, 2) NOT NULL,
    impuesto_pagado DECIMAL(12, 2),
    diferencia DECIMAL(12, 2),
    estado ENUM('Pendiente', 'Presentada', 'Aceptada', 'En Revisión') NOT NULL,
    fecha_presentacion DATE,
    fecha_revision DATE,
    observaciones TEXT,
    FOREIGN KEY (id_contribuyente) REFERENCES contribuyentes(id_contribuyente),
    UNIQUE KEY uq_contribuyente_anio (id_contribuyente, anio_fiscal)
);

-- Insertar datos de contribuyentes
INSERT INTO contribuyentes (nif, nombre, apellidos, email, telefono, direccion, ciudad, provincia, codigo_postal, fecha_alta, tipo_contribuyente) VALUES
(12345678, 'Juan', 'García López', 'juan.garcia@email.com', '658123456', 'Calle Principal 10', 'Granada', 'Granada', '18001', '2022-01-15', 'Persona Física'),
(87654321, 'María', 'Rodríguez Martínez', 'maria.rodriguez@email.com', '657654321', 'Avenida Central 25', 'Sevilla', 'Sevilla', '41001', '2021-06-20', 'Autónomo'),
(11223344, 'TechStart SL', 'García López', 'info@techstart.com', '955123456', 'Parque Tecnológico 5', 'Córdoba', 'Córdoba', '14005', '2020-03-10', 'Empresa'),
(55667788, 'Carlos', 'Fernández González', 'carlos.fdez@email.com', '652111222', 'Calle Mayor 15', 'Málaga', 'Málaga', '29005', '2023-02-28', 'Persona Física'),
(99887766, 'SoluccionesExp SL', 'Martínez Ruiz', 'contacto@solexp.es', '958456789', 'Calle del Comercio 33', 'Granada', 'Granada', '18014', '2019-11-05', 'Empresa'),
(44556677, 'Ana', 'Sánchez Díaz', 'ana.sanchez@email.com', '654789123', 'Plaza Mayor 8', 'Jaén', 'Jaén', '23001', '2022-09-12', 'Autónomo');

-- Insertar datos de declaraciones
INSERT INTO declaraciones (id_contribuyente, anio_fiscal, tipo_declaracion, base_imponible, impuesto_debido, impuesto_pagado, diferencia, estado, fecha_presentacion, fecha_revision, observaciones) VALUES
(1, 2023, 'IRPF', 35000.00, 8400.00, 8500.00, 100.00, 'Aceptada', '2024-04-15', '2024-06-10', 'Declaración correcta'),
(1, 2022, 'IRPF', 32000.00, 7680.00, 7500.00, -180.00, 'Aceptada', '2023-04-20', '2023-06-15', NULL),
(2, 2023, 'Estimación Objetiva', 45000.00, 10800.00, 10800.00, 0.00, 'Aceptada', '2024-03-25', '2024-05-30', NULL),
(3, 2023, 'Sociedades', 150000.00, 30000.00, 30000.00, 0.00, 'En Revisión', '2024-02-10', NULL, 'Pendiente revisión de gastos'),
(4, 2023, 'IRPF', 28000.00, 6720.00, 6800.00, 80.00, 'Aceptada', '2024-04-10', '2024-06-20', NULL),
(5, 2023, 'Sociedades', 500000.00, 100000.00, 100000.00, 0.00, 'Presentada', '2024-01-30', NULL, NULL),
(6, 2023, 'Estimación Objetiva', 55000.00, 13200.00, 13000.00, -200.00, 'Pendiente', NULL, NULL, 'Falta envío de documentos'),
(2, 2022, 'Estimación Objetiva', 40000.00, 9600.00, 9600.00, 0.00, 'Aceptada', '2023-03-20', '2023-05-25', NULL);

-- EJERCICIOS DE JOIN

-- 1. LEFT JOIN - Todos los contribuyentes con sus declaraciones (si existen)
SELECT c.nif, c.nombre, d.* FROM contribuyentes c LEFT JOIN declaraciones d ON c.id_contribuyente=d.id_contribuyente;

-- 2. RIGHT JOIN - Todas las declaraciones con los datos del contribuyente
SELECT d.id_declaracion, c.* FROM contribuyentes c LEFT JOIN declaraciones d ON c.id_contribuyente=d.id_contribuyente;

-- 4. Contar declaraciones por contribuyente
SELECT contribuyentes.nombre, COUNT(declaraciones.id_contribuyente) FROM contribuyentes JOIN declaraciones ON contribuyentes.id_contribuyente=declaraciones.id_contribuyente GROUP BY contribuyentes.nombre;

-- 5. Obtener contribuyentes sin declaraciones
SELECT contribuyentes.nombre, COUNT(declaraciones.id_contribuyente) FROM contribuyentes JOIN declaraciones ON contribuyentes.id_contribuyente=declaraciones.id_contribuyente GROUP BY contribuyentes.nombre HAVING COUNT(declaraciones.id_contribuyente)=0;

-- 6. Diferencias a pagar o devolver por contribuyente
