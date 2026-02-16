DROP DATABASE IF EXISTS coches;
CREATE DATABASE IF NOT EXISTS coches CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE coches;

-- drop user if exists 'user'@'localhost';

create user if not exists 'user'@'localhost' identified by '1234';

GRANT ALL PRIVILEGES on coches.* TO 'user'@'localhost';

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
    ingresos_anuales INT,
    estado_civil VARCHAR(20),
    nivel_socioeconomico VARCHAR(20),
    ocupacion VARCHAR(50),
    madre INT NULL,
    padre INT NULL
);

SET FOREIGN_KEY_CHECKS=0;

-- LOAD DATA INFILE '/var/lib/mysql-files/data_andalucia.csv' INTO TABLE personas FIELDS TERMINATED BY ','  ENCLOSED BY '"' ESCAPED BY '\\' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (id, nombre, apellido, sexo, fecha_nacimiento, provincia, municipio, nivel_estudios, situacion_laboral, ingresos_anuales, estado_civil, num_hijos, nivel_socioeconomico, ocupacion, @madre, @padre) SET madre = NULLIF(@madre, 'NULL'), padre = NULLIF(@padre, 'NULL');

alter table personas add foreign key (padre) references personas(id);
alter table personas add foreign key (madre) references personas(id);

-- Crear la tabla coches
CREATE TABLE coches (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_dueño INT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    año_fabricacion INT,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    color VARCHAR(30),
    FOREIGN KEY (id_dueño) REFERENCES personas(id)
);

SET FOREIGN_KEY_CHECKS=1;

SET FOREIGN_KEY_CHECKS=0;
INSERT INTO personas (id,nombre,apellido,sexo,fecha_nacimiento,provincia,municipio,nivel_estudios,ingresos_anuales,estado_civil,nivel_socioeconomico,ocupacion,madre,padre) VALUES
 (1091,'Margarita','Romero','M','1958-06-10','Cádiz','Jerez','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1092,'Crisostomo','Rosales','H','1950-02-15','Almería','Roquetas','Secundarios',11000,'Casado','Medio','Jubilado',NULL,NULL),
 (1093,'Natividad','Rossi','M','1954-08-23','Almería','Roquetas','Primarios',0,'Casada','Medio','Ama de Casa',NULL,NULL),
 (1094,'Demóstenes','Roza','H','1948-04-07','Huelva','Huelva','Primarios',8000,'Casado','Bajo','Jubilado',NULL,NULL),
 (1095,'Octavia','Rubio','M','1952-10-14','Huelva','Huelva','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1096,'Donaciano','Rueda','H','1956-07-29','Sevilla','Dos Hermanas','Secundarios',12500,'Casado','Medio','Jubilado',NULL,NULL),
 (1097,'Perpetua','Ruelas','M','1960-01-06','Sevilla','Dos Hermanas','Primarios',0,'Casada','Medio','Ama de Casa',NULL,NULL),
 (1098,'Doroteo','Ruiz','H','1952-11-18','Málaga','Marbella','Secundarios',14000,'Casado','Medio','Jubilado',NULL,NULL),
 (1099,'Prudencia','Salas','M','1956-05-25','Málaga','Marbella','Secundarios',0,'Casada','Medio','Ama de Casa',NULL,NULL),
 (1100,'Egidio','Salazar','H','1950-03-11','Cádiz','Cádiz','Primarios',9500,'Casado','Bajo','Jubilado',NULL,NULL),
 (1101,'Quiteria','Salcedo','M','1954-09-19','Cádiz','Cádiz','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1102,'Eligio','Salinas','H','1948-07-02','Granada','Motril','Secundarios',10500,'Casado','Bajo','Jubilado',NULL,NULL),
 (1103,'Rafaela','Saltara','M','1952-01-08','Granada','Motril','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1104,'Epifanio','Samaniego','H','1956-11-14','Jaén','Úbeda','Primarios',8500,'Casado','Bajo','Jubilado',NULL,1111),
 (1105,'Sabina','Sampedro','M','1960-06-22','Jaén','Úbeda','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1106,'Estanislao','Sánchez','H','1954-09-03','Córdoba','Lucena','Secundarios',11000,'Casado','Medio','Jubilado',NULL,NULL),
 (1107,'Tecla','Sandoval','M','1958-03-11','Córdoba','Lucena','Primarios',0,'Casada','Medio','Ama de Casa',NULL,NULL),
 (1108,'Eusebio','Santamaría','H','1950-12-27','Sevilla','Alcalá','Secundarios',12000,'Casado','Medio','Jubilado',NULL,NULL),
 (1109,'Ursulina','Santana','M','1954-04-05','Sevilla','Alcalá','Primarios',0,'Casada','Medio','Ama de Casa',NULL,NULL),
 (1110,'Eutimio','Sarmiento','H','1948-08-19','Málaga','Fuengirola','Secundarios',13500,'Casado','Medio','Jubilado',NULL,NULL),
 (1111,'Valeriana','Satauste','M','1952-02-26','Málaga','Fuengirola','Secundarios',0,'Casada','Medio','Ama de Casa',NULL,NULL),
 (1112,'Evaristo','Saucedo','H','1956-06-04','Huelva','Lepe','Primarios',8000,'Casado','Bajo','Jubilado',NULL,NULL),
 (1113,'Walburga','Saudo','M','1960-12-12','Huelva','Lepe','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1114,'Fabiano','Sauz','H','1952-04-18','Almería','El Ejido','Secundarios',10000,'Casado','Bajo','Jubilado',NULL,NULL),
 (1115,'Xenia','Sayas','M','1956-09-26','Almería','El Ejido','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1116,'Faustino','Saynos','H','1950-07-08','Cádiz','San Fernando','Secundarios',9500,'Casado','Bajo','Jubilado',NULL,NULL),
 (1117,'Yanira','Saza','M','1954-01-15','Cádiz','San Fernando','Primarios',0,'Casada','Bajo','Ama de Casa',1116,NULL),
 (1118,'Fulgencio','Scheid','H','1948-10-29','Sevilla','Coria','Secundarios',11500,'Casado','Medio','Jubilado',NULL,NULL),
 (1119,'Zenaida','Seco','M','1952-03-07','Sevilla','Coria','Primarios',0,'Casada','Medio','Ama de Casa',NULL,NULL),
 (1120,'Gerasimo','Secreto','H','1956-08-13','Sevilla','Sevilla','Secundarios',12500,'Casado','Medio','Jubilado',NULL,NULL),
 (1121,'Abigaíl','Segovia','M','1960-04-21','Sevilla','Sevilla','Primarios',0,'Casada','Medio','Ama de Casa',NULL,NULL),
 (1122,'Gildardo','Seis','H','1954-01-05','Málaga','Málaga','Primarios',9000,'Casado','Bajo','Jubilado',NULL,NULL),
 (1123,'Blanca','Seisdos','M','1958-07-11','Málaga','Málaga','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1124,'Gislerio','Selma','H','1950-11-17','Córdoba','Córdoba','Secundarios',10500,'Casado','Bajo','Jubilado',1104,NULL),
 (1125,'Cristina','Semence','M','1954-05-24','Córdoba','Córdoba','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,1105),
 (1126,'Godofredo','Semeno','H','1948-02-08','Granada','Granada','Primarios',8500,'Casado','Bajo','Jubilado',NULL,NULL),
 (1127,'Dionisia','Sencillo','M','1952-08-16','Granada','Granada','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1128,'Gómez','Senén','H','1956-04-24','Jaén','Linares','Secundarios',11500,'Casado','Bajo','Jubilado',NULL,NULL),
 (1129,'Emilia','Senís','M','1960-10-02','Jaén','Linares','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1130,'Graciano','Seno','H','1952-09-11','Cádiz','Jerez','Secundarios',10000,'Casado','Bajo','Jubilado',NULL,NULL),
 (1131,'Fabiana','Senra','M','1956-02-19','Cádiz','Jerez','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,NULL),
 (1132,'Graciliano','Senta','H','1950-06-27','Almería','Adra','Primarios',8000,'Casado','Bajo','Jubilado',NULL,NULL),
 (1133,'Gabriela','Sentana','M','1954-12-05','Almería','Adra','Primarios',0,'Casada','Bajo','Ama de Casa',NULL,1100),
 (1134,'Lucas','Marín','H','1990-05-12','Granada','Granada','Universitarios',22000,'Soltero','Alto','Profesor',NULL,NULL),
 (1135,'Laura','Gómez','M','1988-03-03','Sevilla','Sevilla','Universitarios',30000,'Casada','Alto','Ingeniero',1091,1092),
 (1136,'Miguel','Vega','H','1975-09-20','Málaga','Málaga','Universitarios',45000,'Casado','Alto','Médico',1104,1105),
 (1137,'Ana','López','M','2002-07-18','Cádiz','Cádiz','Secundarios',6000,'Soltera','Medio','Estudiante',NULL,NULL),
 (1138,'José','Pérez','H','1980-11-30','Córdoba','Córdoba','Primarios',18000,'Casado','Medio','Agricultor',1096,1097),
 (1139,'María','Torres','M','1995-02-25','Almería','El Ejido','Secundarios',20000,'Soltera','Medio','Comerciante',NULL,1093),
 (1140,'Carlos','Herrera','H','1983-12-12','Jaén','Úbeda','Primarios',28000,'Casado','Alto','Policía',1106,1113),
 (1141,'Sofía','Ruano','M','1998-04-04','Sevilla','Dos Hermanas','Primarios',15000,'Soltera','Bajo','Panadero',NULL,NULL),
 (1142,'Irene','Molina','M','1992-06-17','Granada','Motril','Universitarios',26000,'Soltera','Alto','Diseñadora',1135,1134),
 (1143,'Raúl','Santos','H','1979-10-02','Sevilla','Sevilla','Secundarios',17000,'Casado','Medio','Conductor',NULL,NULL),
 (1144,'Elena','Cruz','M','1985-01-09','Málaga','Marbella','Universitarios',38000,'Casada','Alto','Abogada',1137,1136);

SET FOREIGN_KEY_CHECKS=1;

-- Inserts de coches
SET FOREIGN_KEY_CHECKS=0;
INSERT INTO coches (id_dueño, marca, modelo, año_fabricacion, matricula, color) VALUES
(1134, 'Toyota', 'Corolla', 2022, '1234ABC', 'Blanco'),
(1134, 'BMW', '320i', 2021, '5678XYZ', 'Negro'),
(1136, 'Mercedes-Benz', 'C-Class', 2023, '2468DED', 'Gris'),
(1137, 'Volkswagen', 'Golf', 2020, '1357GHI', 'Azul'),
(1138, 'Ford', 'Focus', 2019, '9876JKL', 'Rojo'),
(1139, 'Seat', 'Ibiza', 2022, '4321MNO', 'Rojo'),
(1140, 'Renault', 'Megane', 2021, '8765PQR', 'Plateado'),
(1141, 'Fiat', '500', 2023, '2468STU', 'Verde'),
(1142, 'Audi', 'A3', 2022, '1359VWX', 'Blanco'),
(1143, 'Citroën', 'C3', 2020, '7531YZA', 'Naranja'),
(1144, 'Peugeot', '308', 2023, '9513BCD', 'Negro'),
(1091, 'Opel', 'Astra', 2018, '3579EFG', 'Gris'),
(1092, 'Hyundai', 'i20', 2019, '8642HIJ', 'Azul'),
(1093, 'Skoda', 'Fabia', 2021, '1234KLM', 'Blanco'),
(1095, 'Mazda', '3', 2022, '5678NOP', 'Rojo'),
(1096, 'Kia', 'Sportage', 2020, '2468QRS', 'Blanco'),
(1097, 'Subaru', 'Outback', 2021, '9876TUV', 'Gris'),
(1098, 'Volvo', 'XC60', 2023, '1357WXY', 'Negro'),
(1099, 'Lexus', 'NX', 2022, '5432ZAB', 'Azul'),
(1100, 'Honda', 'CR-V', 2019, '8765CDE', 'Rojo'),
(1101, 'Nissan', 'Qashqai', 2020, '2468FGH', 'Plateado'),
(1102, 'Mitsubishi', 'Outlander', 2021, '1359IJK', 'Verde'),
(1103, 'Suzuki', 'Swift', 2022, '7531LMN', 'Naranja'),
(1104, 'Dacia', 'Duster', 2018, '3579OPQ', 'Blanco'),
(1105, 'Jeep', 'Wrangler', 2023, '9513RST', 'Negro'),
(1106, 'Chevrolet', 'Cruze', 2020, '1234UVW', 'Gris'),
(1107, 'GMC', 'Terrain', 2021, '5678XYY', 'Azul'),
(1108, 'Dodge', 'Charger', 2022, '9876ABC', 'Rojo'),
(1109, 'Tesla', 'Model 3', 2023, '2468DEF', 'Blanco'),
(1110, 'Porsche', '911', 2023, '1357GHG', 'Negro'),
(1111, 'Jaguar', 'F-Pace', 2022, '5432JKK', 'Gris');
SET FOREIGN_KEY_CHECKS=1;