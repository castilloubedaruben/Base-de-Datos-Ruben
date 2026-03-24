DROP DATABASE IF EXISTS red_social;
CREATE DATABASE IF NOT EXISTS red_social CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE red_social;

CREATE USER IF NOT EXISTS 'user'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON red_social.* TO 'user'@'localhost';

-- Crear tabla de usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    nombre_completo VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    foto_perfil VARCHAR(255),
    biografía TEXT,
    ubicacion VARCHAR(100),
    sitio_web VARCHAR(255),
    cuenta_verificada BOOLEAN DEFAULT FALSE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_ultimo_acceso DATETIME,
    estado ENUM('Activa', 'Inactiva', 'Suspendida', 'Eliminada') DEFAULT 'Activa'
);

-- Crear tabla de publicaciones
CREATE TABLE publicaciones (
    id_publicacion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    descripcion TEXT,
    imagen_url VARCHAR(255),
    numero_likes INT DEFAULT 0,
    numero_comentarios INT DEFAULT 0,
    numero_compartidas INT DEFAULT 0,
    privado BOOLEAN DEFAULT FALSE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME,
    estado ENUM('Publicada', 'Borrador', 'Eliminada', 'Archivada') DEFAULT 'Publicada',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Crear tabla de seguidores
CREATE TABLE seguidores (
    id_seguidor INT NOT NULL,
    id_seguido INT NOT NULL,
    fecha_seguimiento DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('Activo', 'Bloqueado', 'Cancelado') DEFAULT 'Activo',
    PRIMARY KEY (id_seguidor, id_seguido),
    FOREIGN KEY (id_seguidor) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_seguido) REFERENCES usuarios(id_usuario),
    CONSTRAINT chk_no_autoseguir CHECK (id_seguidor != id_seguido)
);

-- Insertar datos de usuarios
INSERT INTO usuarios (nombre_usuario, nombre_completo, email, password, foto_perfil, biografía, ubicacion, sitio_web, cuenta_verificada, fecha_creacion, estado) VALUES
('alejandra_87', 'Alejandra García Martínez', 'alejandra87@email.com', 'pass123hash', 'foto_alejandra.jpg', 'Viajera y amante de la fotografía', 'Granada, España', 'www.alejandrafoto.com', TRUE, '2021-03-15 10:30:00', 'Activa'),
('carlos_dev', 'Carlos Fernández López', 'carlosldev@email.com', 'devpass456hash', 'foto_carlos.jpg', 'Desarrollador web y amante del café', 'Madrid, España', NULL, FALSE, '2022-05-20 14:45:00', 'Activa'),
('luna_blogger', 'Luna Rodríguez Sánchez', 'luna.blogger@email.com', 'blogpass789hash', 'foto_luna.jpg', 'Blogger de moda y lifestyle | Influencer', 'Barcelona, España', 'www.lunablog.es', TRUE, '2020-01-10 09:15:00', 'Activa'),
('diego_fitness', 'Diego Moreno García', 'diego.fitness@email.com', 'fitpass321hash', 'foto_diego.jpg', 'Coach de fitness y nutricionista. Transformando vidas.', 'Sevilla, España', 'www.diegofit.com', TRUE, '2021-11-05 16:20:00', 'Activa'),
('marina_art', 'Marina Ruiz González', 'marina.art@email.com', 'artpass654hash', 'foto_marina.jpg', 'Artista digital | Ilustradora | Diseñadora gráfica', 'Málaga, España', 'www.marinaart.es', FALSE, '2022-08-30 12:00:00', 'Activa'),
('juan_viajes', 'Juan López Jiménez', 'juan.viajes@email.com', 'viajepass987hash', 'foto_juan.jpg', 'Mochilero y aventurero. El mundo es mi hogar.', 'Córdoba, España', NULL, FALSE, '2021-02-14 11:30:00', 'Inactiva'),
('sofia_music', 'Sofía Martínez Domínguez', 'sofia.music@email.com', 'musicpass111hash', 'foto_sofia.jpg', 'Cantante y compositora | Música y pasión', 'Valencia, España', 'www.sofiamusic.es', TRUE, '2020-09-22 08:45:00', 'Activa'),
('pedro_cocina', 'Pedro Jiménez García', 'pedro.cocina@email.com', 'cookpass222hash', 'foto_pedro.jpg', 'Chef aficionado | Recetas caseras | Comida saludable', 'Jaén, España', NULL, FALSE, '2023-01-17 13:20:00', 'Activa'),
('clara_tech', 'Clara Ramos López', 'clara.tech@email.com', 'techpass333hash', 'foto_clara.jpg', 'Ingeniera de Software | Tech Enthusiast', 'Bilbao, España', 'www.claratech.dev', TRUE, '2021-07-03 15:10:00', 'Activa'),
('marcos_gamer', 'Marcos Vázquez Martínez', 'marcos.gamer@email.com', 'gamepass444hash', NULL, 'Gamer profesional | Streamer | Twitch', 'Alicante, España', 'www.marcosgamer.tv', FALSE, '2022-04-12 10:00:00', 'Suspendida');

-- Insertar datos de publicaciones
INSERT INTO publicaciones (id_usuario, descripcion, imagen_url, numero_likes, numero_comentarios, numero_compartidas, privado, fecha_creacion, estado) VALUES
(1, 'Atardecer en las playas de Granada 🌅 #viajes #fotografía #españa', 'pub1_alejandra.jpg', 245, 18, 12, FALSE, '2024-02-10 18:30:00', 'Publicada'),
(1, 'Nueva sesión de fotos en la Alhambra. ¡Qué preciosidad! #alhambra', 'pub2_alejandra.jpg', 512, 45, 28, FALSE, '2024-02-08 15:00:00', 'Publicada'),
(2, 'Terminado el nuevo proyecto de desarrollo web. Muy orgulloso del resultado #coding #webdev', 'pub1_carlos.jpg', 156, 22, 8, FALSE, '2024-02-09 19:45:00', 'Publicada'),
(2, 'Mi taza de café favorita para los viernes by the window ☕ #programming #coffee', 'pub2_carlos.jpg', 89, 7, 3, FALSE, '2024-02-07 11:20:00', 'Publicada'),
(3, 'Nueva colección de primavera ya disponible en el blog 👗 #moda #tendencias #primavera2024', 'pub1_luna.jpg', 890, 156, 234, FALSE, '2024-02-06 17:30:00', 'Publicada'),
(3, 'Tutorial de maquillaje para looks frescos y naturales ✨ #makeup #beauty', 'pub2_luna.jpg', 1200, 234, 456, FALSE, '2024-02-04 14:10:00', 'Publicada'),
(4, 'Sesión de entrenamiento matutina. ¡Sin esfuerzo no hay recompensa! 💪 #fitness #gym', 'pub1_diego.jpg', 678, 89, 145, FALSE, '2024-02-09 07:00:00', 'Publicada'),
(4, 'Receta de batido proteico para post-entreno: plátano, avena y proteína #nutrición', 'pub2_diego.jpg', 543, 67, 98, FALSE, '2024-02-05 18:20:00', 'Publicada'),
(5, 'Ilustración digital: Retrato de una chica con los ojos cerrados 🎨 #arte #diseño', 'pub1_marina.jpg', 432, 54, 76, FALSE, '2024-02-08 16:45:00', 'Publicada'),
(5, 'Trabajo en progreso: Portada para revista de diseño #digitalart #illustrator', 'pub2_marina.jpg', 298, 31, 42, TRUE, '2024-02-07 20:00:00', 'Publicada'),
(6, 'Camino de Santiago completado ✨ Una experiencia que cambió mi vida #viajes #faith', 'pub1_juan.jpg', 756, 112, 189, FALSE, '2023-09-15 19:30:00', 'Publicada'),
(7, 'Grabando nuevo sencillo en el estudio. Muy emocionada con este proyecto 🎤 #música', 'pub1_sofia.jpg', 654, 98, 167, FALSE, '2024-02-09 13:00:00', 'Publicada'),
(7, 'Concierto acústico este viernes en Madrid. ¡Espero veros allí! #livemusic #tour', NULL, 187, 45, 34, FALSE, '2024-02-06 12:20:00', 'Publicada'),
(8, 'Paella a la leña - Domingo en familia 🍲 #cocina #recetas #paella', 'pub1_pedro.jpg', 421, 67, 92, FALSE, '2024-02-04 19:15:00', 'Publicada'),
(9, 'Lanzando mi primer proyecto open source en GitHub 👨‍💻 #coding #opensource', 'pub1_clara.jpg', 312, 41, 58, FALSE, '2024-02-08 10:30:00', 'Publicada'),
(9, 'Consejo de programación: siempre documenta tu código 📝 #softwareEngineering', NULL, 234, 28, 45, FALSE, '2024-02-06 09:00:00', 'Publicada'),
(10, 'Directo en twitch a las 20:00 hoy. ¡Vamos a jugar algo épico! #gaming #twitch', NULL, 0, 0, 0, FALSE, '2023-12-01 15:00:00', 'Publicada');

-- Insertar datos de relaciones de seguidores
INSERT INTO seguidores (id_seguidor, id_seguido, fecha_seguimiento, estado) VALUES
(2, 1, '2024-01-15 10:30:00', 'Activo'),
(3, 1, '2023-12-20 14:15:00', 'Activo'),
(4, 1, '2024-02-05 09:45:00', 'Activo'),
(5, 1, '2024-01-10 16:20:00', 'Activo'),
(6, 1, '2023-11-30 11:00:00', 'Activo'),
(7, 1, '2024-02-01 13:30:00', 'Activo'),
(8, 1, '2024-01-25 15:10:00', 'Activo'),
(9, 1, '2023-12-10 17:45:00', 'Activo'),
(1, 3, '2024-02-03 12:00:00', 'Activo'),
(2, 3, '2024-01-20 10:15:00', 'Activo'),
(4, 3, '2023-11-15 08:30:00', 'Activo'),
(5, 3, '2024-01-30 14:45:00', 'Activo'),
(6, 3, '2024-02-07 16:20:00', 'Activo'),
(7, 3, '2024-01-05 11:30:00', 'Activo'),
(8, 3, '2024-02-02 09:15:00', 'Activo'),
(9, 3, '2024-01-28 13:45:00', 'Activo'),
(1, 4, '2024-01-12 15:00:00', 'Activo'),
(2, 4, '2024-02-08 10:30:00', 'Activo'),
(3, 4, '2024-01-18 12:15:00', 'Activo'),
(5, 4, '2024-02-06 14:45:00', 'Activo'),
(6, 4, '2024-01-22 09:20:00', 'Activo'),
(7, 4, '2023-12-15 16:30:00', 'Activo'),
(8, 4, '2024-02-04 11:00:00', 'Activo'),
(9, 4, '2024-01-25 13:45:00', 'Activo'),
(1, 5, '2024-02-01 18:00:00', 'Activo'),
(2, 5, '2024-01-28 12:30:00', 'Activo'),
(3, 5, '2024-02-05 14:15:00', 'Activo'),
(4, 5, '2024-01-30 10:45:00', 'Activo'),
(6, 5, '2024-02-03 16:20:00', 'Activo'),
(7, 5, '2024-01-15 11:30:00', 'Activo'),
(8, 5, '2024-01-20 13:00:00', 'Activo'),
(1, 7, '2024-01-18 19:30:00', 'Activo'),
(2, 7, '2024-02-09 15:45:00', 'Activo'),
(3, 7, '2024-01-25 10:15:00', 'Activo'),
(4, 7, '2024-02-02 12:30:00', 'Activo'),
(5, 7, '2024-01-20 14:00:00', 'Activo'),
(6, 7, '2024-02-06 11:15:00', 'Activo'),
(8, 7, '2024-01-28 16:45:00', 'Activo'),
(9, 7, '2024-02-01 13:20:00', 'Activo'),
(1, 9, '2024-01-30 10:00:00', 'Activo'),
(2, 9, '2024-02-04 15:30:00', 'Activo'),
(3, 9, '2024-01-22 12:45:00', 'Activo'),
(4, 9, '2024-02-07 14:15:00', 'Activo'),
(5, 9, '2024-01-28 11:20:00', 'Activo'),
(6, 9, '2024-02-05 16:00:00', 'Activo'),
(7, 9, '2024-01-15 13:45:00', 'Activo'),
(8, 9, '2024-02-03 09:30:00', 'Activo'),
(1, 2, '2024-01-20 14:30:00', 'Activo'),
(3, 2, '2024-02-05 11:15:00', 'Activo'),
(4, 2, '2024-01-28 16:00:00', 'Activo'),
(5, 2, '2024-02-02 12:30:00', 'Activo'),
(6, 2, '2024-01-25 10:45:00', 'Activo'),
(7, 2, '2024-02-08 13:20:00', 'Activo'),
(8, 2, '2024-01-30 15:15:00', 'Activo');

-- EJERCICIOS DE JOIN

-- 1. LEFT JOIN - Todos los usuarios con sus publicaciones (si existen)
SELECT usuarios.nombre_usuario, publicaciones.* from usuarios LEFT JOIN publicaciones on usuarios.id_usuario=publicaciones.id_usuario ORDER BY usuarios.id_usuario;

-- 2. RIGHT JOIN - Todas las publicaciones con datos del usuario
SELECT publicaciones.descripcion, usuarios.* from usuarios LEFT JOIN publicaciones on usuarios.id_usuario=publicaciones.id_usuario ORDER BY usuarios.id_usuario;

-- 3. FULL JOIN - Todos los registros de ambas tablas


-- 4. Usuarios sin publicaciones
SELECT usuarios.* FROM usuarios LEFT JOIN publicaciones ON usuarios.id_usuario = publicaciones.id_usuario WHERE publicaciones.id_publicacion is null;
-- 5. Publicaciones sin usuario asociado (datos orfanos)
SELECT publicaciones.* from publicaciones JOIN usuarios on usuarios.id_usuario=publicaciones.id_usuario WHERE usuarios.id_usuario=NULL;

-- 6. Publicaciones más populares con datos del creador
SELECT publicaciones.numero_likes, usuarios.* FROM publicaciones JOIN usuarios ON usuarios.id_usuario=publicaciones.id_usuario ORDER BY publicaciones.numero_likes DESC;

-- 7. Usuarios activos y su actividad en publicaciones


-- EJERCICIOS CON TABLA DE SEGUIDORES

-- 9. LEFT JOIN - Usuarios y sus seguidores
SELECT usuarios.*, seguidores.* FROM usuarios LEFT JOIN seguidores on usuarios.id_usuario=seguidores.id_seguido;

-- 10. RIGHT JOIN - Quién sigue a cada usuario (todos los seguimientos activos)
SELECT usuarios.nombre_usuario, seguidores.id_seguidor FROM usuarios JOIN seguidores ON usuarios.id_usuario=seguidores.id_seguido;

-- 12. Usuarios sin seguidores (LEFT JOIN)
select usuarios.nombre_usuario, COUNT(seguidores.id_seguidor) as total_seguidores FROM usuarios JOIN seguidores ON usuarios.id_usuario=seguidores.id_seguido GROUP BY usuarios.nombre_usuario HAVING COUNT(seguidores.id_seguidor) = 0 ;

-- 13. Top influencers (usuarios más seguidos)
select usuarios.nombre_usuario, COUNT(seguidores.id_seguidor) as total_seguidores FROM usuarios JOIN seguidores ON usuarios.id_usuario=seguidores.id_seguido GROUP BY usuarios.nombre_usuario ORDER BY total_seguidores desc ;

-- 14. Matriz de seguimientos bidireccionales (mutua)


-- 15. Estadísticas completas de usuario (publicaciones + seguidores + seguidos)
