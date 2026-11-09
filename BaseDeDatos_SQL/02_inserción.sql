
INSERT INTO pais (id_pais, nombre) VALUES
(1, 'Colombia'), (2, 'Corea del Sur'), (3, 'Reino Unido'), (4, 'Chile'), (5, 'Estados Unidos'), (6, 'Alemania');

INSERT INTO idioma (id_idioma, nombre) VALUES
(1, 'Inglés'), (2, 'Español');

INSERT INTO tipo_usuario (id_tipo_usuario, nombre, max_prestamos, dias_prestamo, max_renovaciones, permite_reserva) VALUES
(1, 'ESTUDIANTE', 15, 15, 2, TRUE),
(2, 'DOCENTE', 10, 30, 4, TRUE),
(3, 'ADMINISTRATIVO', 3, 10, 1, FALSE),
(4, 'INVESTIGADOR', 8, 45, 3, TRUE),
(5, 'EGRESADO', 2, 7, 0, FALSE);

INSERT INTO categoria (id_categoria, nombre, descripcion, codigo_dewey) VALUES
(1, 'Ciencias de la Computación', 'Programación, algoritmos, inteligencia artificial', '005'),
(2, 'Matemáticas', 'Álgebra, cálculo, estadística', '510'),
(3, 'Física', 'Mecánica, electromagnetismo, termodinámica', '530'),
(4, 'Literatura', 'Novela, poesía, ensayo', '800'),
(5, 'Historia', 'Historia universal y de Colombia', '900');

INSERT INTO autor (id_autor, nombres, apellidos, fecha_nacimiento) VALUES
(1, 'V.E', 'Schwab', '1927-03-06'),
(2, 'Xiran', 'Jay Zhao', '1942-01-08'),
(3, 'Rachel', 'Reid', '1912-06-23'),
(4, 'Isabel', 'Allende', '1942-08-02'),
(5, 'Alyson', 'Derrick', '1938-01-10');

INSERT INTO universidad (id_universidad, nombre, nit, direccion, ciudad, id_pais, estado, fecha_creacion) VALUES
(1, 'Universidad Industrial de Santander', '890201938-4', 'Carrera 27 Calle 9', 'Bucaramanga', 1, 'ACTIVA', '2001-03-15'),
(2, 'Universidad Nacional de Colombia', '899999063-1', 'Carrera 45 #26-85', 'Bogotá', 1, 'ACTIVA', '1867-09-22'),
(3, 'Universidad de Antioquia', '890980040-8', 'Calle 67 #53-108', 'Medellín', 1, 'ACTIVA', '1803-11-18'),
(4, 'Pontificia Universidad Javeriana', '860013948-5', 'Carrera 7 #40-62', 'Bogotá', 1, 'ACTIVA', '1623-07-13'),
(5, 'Universidad EAFIT', '890902941-5', 'Carrera 49 #7 Sur-50', 'Medellín', 1, 'ACTIVA', '1960-05-21');

INSERT INTO editorial (id_editorial, nombre, id_pais) VALUES
(1, 'Pearson Educación', 3),
(2, 'McGraw-Hill', 5),
(3, 'Springer Nature', 6),
(4, 'Editorial Norma', 1),
(5, 'O\'Reilly Media', 5);

INSERT INTO universidad_contacto (id_contacto, id_universidad, tipo_contacto, valor, es_principal) VALUES
(1, 1, 'TELEFONO', '+57 607 6344000', TRUE),
(2, 1, 'CORREO', 'info@uis.edu.co', TRUE),
(3, 1, 'WEB', 'www.uis.edu.co', FALSE),
(4, 2, 'TELEFONO', '+57 601 3165000', TRUE),
(5, 2, 'CORREO', 'atencion@unal.edu.co', TRUE);

INSERT INTO editorial_contacto (id_contacto_ed, id_editorial, tipo_contacto, valor, es_principal) VALUES
(1, 1, 'WEB', 'www.pearson.com', TRUE),
(2, 1, 'CORREO', 'contacto@pearson.com', FALSE),
(3, 2, 'WEB', 'www.mheducation.com', TRUE),
(4, 3, 'CORREO', 'service-ny@springer.com', TRUE),
(5, 4, 'TELEFONO', '+57 601 555 8899', TRUE);

INSERT INTO biblioteca (id_biblioteca, id_universidad, nombre, direccion, horario, estado) VALUES
(1, 1, 'Biblioteca Central UIS', 'Carrera 27 Calle 9, Bucaramanga', 'Lun-Vie 7:00-21:00, Sáb 8:00-17:00', 'ACTIVA'),
(2, 1, 'Biblioteca de Ingenierías', 'Calle 9 #27-50, Bucaramanga', 'Lun-Vie 7:00-19:00', 'ACTIVA'),
(3, 2, 'Biblioteca Central UNAL', 'Carrera 45 #26-85, Bogotá', 'Lun-Sáb 7:00-20:00', 'ACTIVA'),
(4, 3, 'Biblioteca Carlos Gaviria Díaz', 'Calle 67 #53-108, Medellín', 'Lun-Vie 8:00-20:00', 'ACTIVA'),
(5, 4, 'Biblioteca General Javeriana', 'Carrera 7 #40-62, Bogotá', 'Lun-Vie 7:00-22:00', 'ACTIVA');

INSERT INTO biblioteca_contacto (id_contacto_bib, id_biblioteca, tipo_contacto, valor, es_principal) VALUES
(1, 1, 'TELEFONO', '+57 607 6344000 ext 2100', TRUE),
(2, 1, 'CORREO', 'biblioteca@uis.edu.co', TRUE),
(3, 2, 'CORREO', 'biblioingenierias@uis.edu.co', TRUE),
(4, 3, 'TELEFONO', '+57 601 3165000 ext 28200', TRUE),
(5, 4, 'CORREO', 'bibliotecacentral@udea.edu.co', TRUE);

INSERT INTO usuario (id_usuario, id_universidad, id_tipo_usuario, documento, nombres, apellidos, direccion, estado, fecha_registro) VALUES
(1, 1, 1, '1098765432', 'Alessandra', 'Santos Maheras', 'Calle 45 #20-15, Bucaramanga', 'ACTIVO', '2024-02-10'),
(2, 1, 2, '91234567', 'Amira', 'Coleman Rodriguez', 'Carrera 33 #55-20, Bucaramanga', 'ACTIVO', '2023-08-05'),
(3, 2, 1, '1012345678', 'Yulian', 'Dimitriev Kirillovich', 'Calle 80 #9-75, Bogotá', 'ACTIVO', '2024-03-18'),
(4, 3, 3, '1034567890', 'Aviel', 'Vega Walker', 'Carrera 70 #30-40, Medellín', 'SUSPENDIDO', '2022-11-30'),
(5, 4, 2, '79876543', 'Malika Suraira', 'Harbor Montgomery', 'Calle 100 #11-30, Bogotá', 'ACTIVO', '2021-06-22');

INSERT INTO usuario_contacto (id_contacto_usr, id_usuario, tipo_contacto, valor, es_principal) VALUES
(1, 1, 'CORREO', 'alesandra_santos@correo.uis.edu.co', TRUE),
(2, 1, 'TELEFONO', '+57 310 555 1234', TRUE),
(3, 2, 'CORREO', 'dimitriev@uis.edu.co', TRUE),
(4, 3, 'CORREO', 'walker_aviel@unal.edu.co', TRUE),
(5, 4, 'TELEFONO', '+57 300 555 6789', FALSE);

INSERT INTO recurso (id_recurso, id_universidad, id_categoria, id_editorial, titulo, subtitulo, isbn, tipo_recurso, anio_publicacion, descripcion, numero_paginas, es_prestable, fecha_creacion) VALUES
(1, 1, 1, 5, 'The Art of Computer Programming', 'Volumen 1: Algoritmos Fundamentales', '978-0201896831', 'LIBRO', 1997, 'Clásico de algoritmos y estructuras de datos', 672, TRUE, '2024-01-15'),
(2, 1, 3, 3, 'A Brief History of Time', 'From the Big Bang to Black Holes', '978-0553380163', 'LIBRO', 1988, 'Divulgación científica sobre cosmología', 212, TRUE, '2024-01-20'),
(3, 2, 2, 2, 'Cálculo', 'Trascendentes tempranas', '978-6071503589', 'LIBRO', 2011, 'Texto de cálculo diferencial e integral', 1120, TRUE, '2024-02-05'),
(4, 2, 4, 4, 'Cien años de soledad', NULL, '978-0307474728', 'LIBRO', 1967, 'Novela realismo mágico', 471, TRUE, '2024-02-10'),
(5, 3, 5, 3, 'Historia de Colombia', 'Siglo XX', '978-9584200000', 'LIBRO', 2015, 'Historia contemporánea colombiana', 380, TRUE, '2024-03-01');

INSERT INTO recurso_autor (id_recurso, id_autor, orden) VALUES
(1, 5, 1), (2, 2, 1), (3, 5, 1), (4, 1, 1), (5, 1, 2);

INSERT INTO autor_nacionalidad (id_autor_nac, id_autor, id_pais, es_principal) VALUES
(1, 1, 1, TRUE), (2, 1, 2, FALSE), (3, 2, 3, TRUE), (4, 3, 3, TRUE), (5, 4, 4, TRUE);

INSERT INTO recurso_idioma (id_recurso_idioma, id_recurso, id_idioma, es_principal) VALUES
(1, 1, 1, TRUE), (2, 2, 1, TRUE), (3, 2, 2, FALSE), (4, 3, 2, TRUE), (5, 4, 2, TRUE);

INSERT INTO recurso_formato_digital (id_formato, id_recurso, formato, url, tamano_mb) VALUES
(1, 1, 'PDF', 'https://repositorio.uis.edu.co/recursos/tacp.pdf', 25.5),
(2, 2, 'EPUB', 'https://repositorio.uis.edu.co/recursos/abhot.epub', 3.2),
(3, 3, 'PDF', 'https://repositorio.unal.edu.co/recursos/calculo.pdf', 48.7),
(4, 4, 'MOBI', 'https://repositorio.unal.edu.co/recursos/cien-anos.mobi', 1.8),
(5, 5, 'PDF', 'https://repositorio.udea.edu.co/recursos/historia-col.pdf', 12.4);

INSERT INTO ejemplar (id_ejemplar, id_recurso, id_biblioteca, codigo_barras, ubicacion, tipo_ejemplar, estado, fecha_adquisicion, precio_reposicion, rfid, volumen, numero_edicion) VALUES
(1, 1, 1, 'UIS-CB-0001', 'Estante A-1', 'FISICO', 'DISPONIBLE', '2024-01-20', 250000.00, 'RFID-1001', NULL, NULL),
(2, 1, 1, 'UIS-CB-0002', 'Estante A-1', 'FISICO', 'PRESTADO', '2024-01-20', 250000.00, 'RFID-1002', NULL, NULL),
(3, 2, 1, 'UIS-CB-0003', 'Estante C-3', 'FISICO', 'DISPONIBLE', '2024-02-01', 90000.00, 'RFID-1003', NULL, NULL),
(4, 3, 3, 'UNAL-CB-0001', 'Sección Matemáticas', 'FISICO', 'DISPONIBLE', '2024-02-15', 180000.00, 'RFID-2001', NULL, NULL),
(5, 4, 3, 'UNAL-CB-0002', 'Sección Literatura', 'FISICO', 'RESERVADO', '2024-03-01', 75000.00, 'RFID-2002', NULL, NULL);

INSERT INTO reserva (id_reserva, id_usuario, id_recurso, id_biblioteca, fecha_reserva, fecha_expiracion, estado, posicion_cola) VALUES
(1, 1, 1, 1, '2024-10-10', '2024-10-17', 'CUMPLIDA', 1),
(2, 3, 4, 3, '2024-10-25', '2024-11-01', 'PENDIENTE', 1),
(3, 5, 2, 1, '2024-11-05', '2024-11-12', 'PENDIENTE', 1),
(4, 2, 3, 3, '2024-09-01', '2024-09-08', 'EXPIRADA', 1),
(5, 4, 5, 1, '2024-07-20', '2024-07-27', 'CANCELADA', 2);

INSERT INTO prestamo (id_prestamo, id_usuario, id_ejemplar, fecha_prestamo, fecha_vencimiento, estado, observaciones) VALUES
(1, 1, 2, '2024-10-15', '2024-10-30', 'ACTIVO', 'Préstamo de libro de algoritmos'),
(2, 2, 1, '2024-10-20', '2024-11-19', 'ACTIVO', NULL),
(3, 3, 4, '2024-09-10', '2024-09-25', 'DEVUELTO', 'Devuelto en buen estado'),
(4, 4, 5, '2024-08-05', '2024-08-12', 'VENCIDO', 'Usuario suspendido por mora'),
(5, 5, 3, '2024-11-01', '2024-12-01', 'ACTIVO', NULL);

INSERT INTO renovacion (id_renovacion, id_prestamo, fecha_renovacion, fecha_vencimiento_anterior, fecha_vencimiento_nueva, tipo, es_automatica) VALUES
(1, 1, '2024-10-28', '2024-10-30', '2024-11-14', 'MANUAL', FALSE),
(2, 2, '2024-11-16', '2024-11-19', '2024-12-04', 'AUTOMATICA', TRUE),
(3, 3, '2024-09-22', '2024-09-25', '2024-10-10', 'MANUAL', FALSE),
(4, 5, '2024-11-28', '2024-12-01', '2024-12-16', 'AUTOMATICA', TRUE),
(5, 1, '2024-11-12', '2024-11-14', '2024-11-29', 'MANUAL', FALSE);

INSERT INTO devolucion (id_devolucion, id_prestamo, fecha_devolucion, estado_ejemplar, id_biblioteca_recepcion, observaciones) VALUES
(1, 3, '2024-09-24', 'BUENO', 3, 'Devuelto sin novedades'),
(2, 4, '2024-08-15', 'BUENO', 4, 'Devuelto con retraso'),
(3, 5, '2024-12-15', 'DETERIORADO', 1, 'Páginas marcadas con resaltador'),
(4, 2, '2024-12-03', 'BUENO', 1, NULL),
(5, 1, '2024-11-28', 'BUENO', 1, 'Devolución puntual');

INSERT INTO multa (id_multa, id_prestamo, monto, motivo, fecha_generacion, fecha_pago, estado) VALUES
(1, 4, 15000.00, 'Devolución tardía de 3 días', '2024-08-16', '2024-08-20', 'PAGADA'),
(2, 2, 5000.00, 'Daño leve al ejemplar', '2024-12-04', NULL, 'PENDIENTE'),
(3, 5, 20000.00, 'Pérdida de material', '2024-12-16', NULL, 'PENDIENTE'),
(4, 3, 8000.00, 'Devolución tardía de 1 día', '2024-09-25', '2024-09-26', 'PAGADA'),
(5, 1, 0.00, 'Multa condonada por buen comportamiento', '2024-11-29', '2024-11-29', 'CONDONADA');