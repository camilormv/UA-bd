DROP TABLE IF EXISTS pacientes_detalle;
DROP TABLE IF EXISTS examenes;
DROP TABLE IF EXISTS medicos;
DROP TABLE IF EXISTS pacientes_general;
DROP TABLE IF EXISTS camas;
DROP TABLE IF EXISTS habitaciones;

CREATE TABLE habitaciones (
    id_habitacion VARCHAR(10) PRIMARY KEY,
    nombre_habitacion VARCHAR(50),
    piso VARCHAR(20)
);

CREATE TABLE camas (
    id_cama VARCHAR(10) PRIMARY KEY,
    id_habitacion VARCHAR(10) REFERENCES habitaciones(id_habitacion),
    estado VARCHAR(20)
);

CREATE TABLE pacientes_general (
    id_paciente VARCHAR(15) PRIMARY KEY,
    Nombre TEXT,
    Sexo VARCHAR(3),
    Dirección TEXT,
    Ciudad_Comuna TEXT
);

CREATE TABLE medicos (
    id_medico VARCHAR(15) PRIMARY KEY,
    Nombre TEXT,
    Sexo VARCHAR(3),
    Especialidad TEXT
);

CREATE TABLE examenes (
    id_examen VARCHAR(10) PRIMARY KEY,
    id_paciente VARCHAR(15) REFERENCES pacientes_general(id_paciente),
    tipo_examen VARCHAR(50),
    resultado VARCHAR(20),
    fecha DATE
);

CREATE TABLE pacientes_detalle (
    id_paciente VARCHAR(15) REFERENCES pacientes_general(id_paciente),
    Diagnostico TEXT,
    numero_habitacion VARCHAR(10) REFERENCES habitaciones(id_habitacion),
    medico_tratante VARCHAR(15) REFERENCES medicos(id_medico),
    id_cama VARCHAR(10) REFERENCES camas(id_cama),
    id_examen VARCHAR(10) REFERENCES examenes(id_examen)
);

-- Insertar habitaciones
INSERT INTO habitaciones VALUES ('101001', 'habitacion_101001', 'piso_1');
INSERT INTO habitaciones VALUES ('101002', 'habitacion_101002', 'piso_1');
INSERT INTO habitaciones VALUES ('101003', 'habitacion_101003', 'piso_1');
INSERT INTO habitaciones VALUES ('101004', 'habitacion_101004', 'piso_2');
INSERT INTO habitaciones VALUES ('101005', 'habitacion_101005', 'piso_2');
INSERT INTO habitaciones VALUES ('101006', 'habitacion_101006', 'piso_2');
INSERT INTO habitaciones VALUES ('101007', 'habitacion_101007', 'piso_3');
INSERT INTO habitaciones VALUES ('101008', 'habitacion_101008', 'piso_3');
INSERT INTO habitaciones VALUES ('101009', 'habitacion_101009', 'piso_3');
INSERT INTO habitaciones VALUES ('101010', 'habitacion_101010', 'piso_4');

-- Insertar camas
INSERT INTO camas VALUES ('C0001', '101009', 'Mantenimiento');
INSERT INTO camas VALUES ('C0002', '101001', 'Ocupada');
INSERT INTO camas VALUES ('C0003', '101006', 'Ocupada');
INSERT INTO camas VALUES ('C0004', '101009', 'Disponible');
INSERT INTO camas VALUES ('C0005', '101001', 'Ocupada');
INSERT INTO camas VALUES ('C0006', '101001', 'Ocupada');
INSERT INTO camas VALUES ('C0007', '101010', 'Disponible');
INSERT INTO camas VALUES ('C0008', '101002', 'Ocupada');
INSERT INTO camas VALUES ('C0009', '101010', 'Disponible');
INSERT INTO camas VALUES ('C0010', '101006', 'Mantenimiento');
INSERT INTO camas VALUES ('C0011', '101002', 'Mantenimiento');
INSERT INTO camas VALUES ('C0012', '101009', 'Disponible');
INSERT INTO camas VALUES ('C0013', '101003', 'Mantenimiento');
INSERT INTO camas VALUES ('C0014', '101001', 'Mantenimiento');
INSERT INTO camas VALUES ('C0015', '101010', 'Mantenimiento');
INSERT INTO camas VALUES ('C0016', '101009', 'Disponible');
INSERT INTO camas VALUES ('C0017', '101006', 'Disponible');
INSERT INTO camas VALUES ('C0018', '101009', 'Ocupada');
INSERT INTO camas VALUES ('C0019', '101004', 'Disponible');
INSERT INTO camas VALUES ('C0020', '101002', 'Mantenimiento');

-- Insertar pacientes_general
INSERT INTO pacientes_general VALUES ('5701779-1', 'Gonzalez Gonzalez Maria Teresa Leontina Del Carmen', 'MUJ', 'Putre 0 362 Pb Prosperidad', 'Curico');
INSERT INTO pacientes_general VALUES ('19995187-4', 'Gonzalez Gonzalez Miguel Angel Gabriel Alberto', 'VAR', 'Av.las Rocas 74', 'Santo Domingo');
INSERT INTO pacientes_general VALUES ('17475679-1', 'Gonzalez Gonzalez Nicole Estefania Teresita De Jesus', 'MUJ', 'Pasaje Tapera 445 Las Nieves', 'Coyhaique');
INSERT INTO pacientes_general VALUES ('5203909-6', 'Gonzalez Gonzalez Sara Isabel Del Carmen Micaela', 'MUJ', 'Las Cigueñas 3717', 'Macul');
INSERT INTO pacientes_general VALUES ('15603250-6', 'Gonzalez Gonzalez Servando Francisco Javier Eduardo', 'VAR', 'Eduardo Matte 1653', 'Parque O''higgins');
INSERT INTO pacientes_general VALUES ('17083096-2', 'Perez De Arce Perez Pia Consuelo Del Carmen', 'MUJ', 'Pedro H.ling 847', 'Plaza ñuñoa');
INSERT INTO pacientes_general VALUES ('4004562-7', 'Perez De Arce Perez Yolanda Ariela', 'MUJ', 'Peru 539', 'Valdivia');
INSERT INTO pacientes_general VALUES ('10369669-0', 'Perez De Tudela Perez Dean Giuliano', 'VAR', 'Alonso De Escudero 753 Pb El Olivo B', 'San Bernardo');
INSERT INTO pacientes_general VALUES ('4660993-K', 'Perez Perez Alfredo Haroldo Del Transito', 'VAR', 'Pje Panguipulli 8127 V/ohiggins', 'Bellavista');
INSERT INTO pacientes_general VALUES ('5093926-K', 'Perez Perez Alice Rosa Oriana', 'MUJ', 'Pj Parinacota 1975 Pob Camilo Henriquez', 'Arica');

-- Insertar medicos
INSERT INTO medicos VALUES ('8050976-6', 'Torres Torres Yorka Guacolda Del Buen Consejo', 'MUJ', 'Medicina Interna');
INSERT INTO medicos VALUES ('20353187-7', 'Torres Torres Abner Tomas Exequiel', 'VAR', 'Pediatría');
INSERT INTO medicos VALUES ('21419633-6', 'Torres Torres Alexander Ariel Timo', 'VAR', 'Cirugía General');
INSERT INTO medicos VALUES ('16084382-9', 'Torres Torres Alfredo Miguel Angel', 'VAR', 'Ginecología y Obstetricia');
INSERT INTO medicos VALUES ('16976065-9', 'Torres Torres Angela Esparta Jossabeth', 'MUJ', 'Psiquiatría');
INSERT INTO medicos VALUES ('18665639-3', 'Garcia Garcia Alba Laureana Aracely', 'MUJ', 'Cardiología');
INSERT INTO medicos VALUES ('17287413-4', 'Garcia Garcia Alejandro Juan Alexis', 'VAR', 'Dermatología');
INSERT INTO medicos VALUES ('4302025-0', 'Garcia Garcia Antonio Segundo Panfilo', 'VAR', 'Radiología');
INSERT INTO medicos VALUES ('5038526-4', 'Garcia Garcia Aurelia Maria Del Carmen', 'MUJ', 'Anestesiología');
INSERT INTO medicos VALUES ('19001977-2', 'Garcia Garcia Ayleen Suiland Marcela', 'MUJ', 'Medicina Familiar');

-- Insertar examenes
INSERT INTO examenes VALUES ('E0001', '17475679-1', 'Resonancia', 'Pendiente', '2024-08-13');
INSERT INTO examenes VALUES ('E0002', '5093926-K', 'Hemograma', 'Pendiente', '2023-10-18');
INSERT INTO examenes VALUES ('E0003', '10369669-0', 'Tomografía', 'Pendiente', '2023-01-31');
INSERT INTO examenes VALUES ('E0004', '10369669-0', 'Tomografía', 'Normal', '2024-10-15');
INSERT INTO examenes VALUES ('E0005', '4004562-7', 'Hemograma', 'Pendiente', '2024-11-28');
INSERT INTO examenes VALUES ('E0006', '10369669-0', 'Hemograma', 'Pendiente', '2023-03-15');
INSERT INTO examenes VALUES ('E0007', '19995187-4', 'Hemograma', 'Anormal', '2023-09-18');
INSERT INTO examenes VALUES ('E0008', '17475679-1', 'Resonancia', 'Pendiente', '2023-04-23');
INSERT INTO examenes VALUES ('E0009', '19995187-4', 'Resonancia', 'Anormal', '2024-01-16');
INSERT INTO examenes VALUES ('E0010', '17475679-1', 'Tomografía', 'Anormal', '2023-06-02');

-- Insertar pacientes_detalle
INSERT INTO pacientes_detalle VALUES ('19995187-4', 'Gripe', '101007', '16976065-9', 'C0012', 'E0036');
INSERT INTO pacientes_detalle VALUES ('17475679-1', 'Apendicitis', '101002', '18665639-3', 'C0011', 'E0062');
INSERT INTO pacientes_detalle VALUES ('15603250-6', 'Fractura', '101002', '18665639-3', 'C0003', 'E0017');
INSERT INTO pacientes_detalle VALUES ('17475679-1', 'Apendicitis', '101004', '16084382-9', 'C0007', 'E0096');
INSERT INTO pacientes_detalle VALUES ('4004562-7', 'Covid-19', '101003', '18665639-3', 'C0004', 'E0039');
INSERT INTO pacientes_detalle VALUES ('17475679-1', 'Covid-19', '101001', '21419633-6', 'C0005', 'E0088');
INSERT INTO pacientes_detalle VALUES ('4004562-7', 'Fractura', '101005', '16976065-9', 'C0010', 'E0069');
INSERT INTO pacientes_detalle VALUES ('5203909-6', 'Fractura', '101007', '20353187-7', 'C0005', 'E0042');
INSERT INTO pacientes_detalle VALUES ('15603250-6', 'Fractura', '101009', '16084382-9', 'C0004', 'E0040');
INSERT INTO pacientes_detalle VALUES ('19995187-4', 'Gripe', '101003', '21419633-6', 'C0017', 'E0058');