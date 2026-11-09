USE bslbquoefbaokdx4cshz;


CREATE TABLE pais (
    id_pais INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE idioma (
    id_idioma INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    codigo_dewey VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE editorial (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    id_pais INT,
    CONSTRAINT fk_editorial_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(150) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    fecha_nacimiento DATE
) ENGINE=InnoDB;

CREATE TABLE tipo_usuario (
    id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    max_prestamos INT NOT NULL DEFAULT 0,
    dias_prestamo INT NOT NULL DEFAULT 0,
    max_renovaciones INT NOT NULL DEFAULT 0,
    permite_reserva BOOLEAN NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;


CREATE TABLE universidad (
    id_universidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    nit VARCHAR(50) UNIQUE,
    direccion VARCHAR(200),
    ciudad VARCHAR(100),
    id_pais INT,
    estado VARCHAR(50) DEFAULT 'Activa',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_universidad_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE universidad_contacto (
    id_contacto INT AUTO_INCREMENT PRIMARY KEY,
    id_universidad INT NOT NULL,
    tipo_contacto VARCHAR(50) NOT NULL,
    valor VARCHAR(150) NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_univ_contacto_univ FOREIGN KEY (id_universidad) REFERENCES universidad(id_universidad) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE editorial_contacto (
    id_contacto_ed INT AUTO_INCREMENT PRIMARY KEY,
    id_editorial INT NOT NULL,
    tipo_contacto VARCHAR(50) NOT NULL,
    valor VARCHAR(150) NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_edit_contacto_edit FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE biblioteca (
    id_biblioteca INT AUTO_INCREMENT PRIMARY KEY,
    id_universidad INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    direccion VARCHAR(200),
    horario VARCHAR(100),
    estado VARCHAR(50) DEFAULT 'Activa',
    CONSTRAINT fk_biblioteca_univ FOREIGN KEY (id_universidad) REFERENCES universidad(id_universidad) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_universidad INT NOT NULL,
    id_tipo_usuario INT NOT NULL,
    documento VARCHAR(50) UNIQUE NOT NULL,
    nombres VARCHAR(150) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    direccion VARCHAR(200),
    estado VARCHAR(50) DEFAULT 'Activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_usuario_univ FOREIGN KEY (id_universidad) REFERENCES universidad(id_universidad) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_tipo FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario(id_tipo_usuario) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE recurso (
    id_recurso INT AUTO_INCREMENT PRIMARY KEY,
    id_universidad INT NOT NULL,
    id_categoria INT NOT NULL,
    id_editorial INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    subtitulo VARCHAR(255),
    isbn VARCHAR(50),
    tipo_recurso VARCHAR(50) NOT NULL,
    anio_publicacion INT,
    descripcion TEXT,
    numero_paginas INT,
    es_prestable BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_recurso_univ FOREIGN KEY (id_universidad) REFERENCES universidad(id_universidad) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_recurso_cat FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_recurso_edit FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE biblioteca_contacto (
    id_contacto_bib INT AUTO_INCREMENT PRIMARY KEY,
    id_biblioteca INT NOT NULL,
    tipo_contacto VARCHAR(50) NOT NULL,
    valor VARCHAR(150) NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_bib_contacto_bib FOREIGN KEY (id_biblioteca) REFERENCES biblioteca(id_biblioteca) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE usuario_contacto (
    id_contacto_usr INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo_contacto VARCHAR(50) NOT NULL,
    valor VARCHAR(150) NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_usr_contacto_usr FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE ejemplar (
    id_ejemplar INT AUTO_INCREMENT PRIMARY KEY,
    id_recurso INT NOT NULL,
    id_biblioteca INT NOT NULL,
    codigo_barras VARCHAR(100) UNIQUE NOT NULL,
    ubicacion VARCHAR(100),
    tipo_ejemplar VARCHAR(50),
    estado VARCHAR(50) DEFAULT 'Disponible',
    fecha_adquisicion DATE,
    precio_reposicion DECIMAL(10,2),
    rfid VARCHAR(100),
    volumen VARCHAR(50),
    numero_edicion VARCHAR(50),
    CONSTRAINT fk_ejemplar_recurso FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ejemplar_bib FOREIGN KEY (id_biblioteca) REFERENCES biblioteca(id_biblioteca) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_recurso INT NOT NULL,
    id_biblioteca INT NOT NULL,
    fecha_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion TIMESTAMP,
    estado VARCHAR(50) DEFAULT 'Activa',
    posicion_cola INT,
    CONSTRAINT fk_reserva_usr FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_recurso FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_bib FOREIGN KEY (id_biblioteca) REFERENCES biblioteca(id_biblioteca) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE recurso_idioma (
    id_recurso_idioma INT AUTO_INCREMENT PRIMARY KEY,
    id_recurso INT NOT NULL,
    id_idioma INT NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_rec_idioma_rec FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rec_idioma_idioma FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE recurso_formato_digital (
    id_formato INT AUTO_INCREMENT PRIMARY KEY,
    id_recurso INT NOT NULL,
    formato VARCHAR(50) NOT NULL,
    url TEXT,
    tamano_mb DECIMAL(10,2),
    CONSTRAINT fk_rec_formato_rec FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE recurso_autor (
    id_recurso INT NOT NULL,
    id_autor INT NOT NULL,
    orden INT DEFAULT 1,
    PRIMARY KEY (id_recurso, id_autor),
    CONSTRAINT fk_rec_autor_rec FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rec_autor_autor FOREIGN KEY (id_autor) REFERENCES autor(id_autor) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE autor_nacionalidad (
    id_autor_nac INT AUTO_INCREMENT PRIMARY KEY,
    id_autor INT NOT NULL,
    id_pais INT NOT NULL,
    es_principal BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_autor_nac_autor FOREIGN KEY (id_autor) REFERENCES autor(id_autor) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_autor_nac_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE prestamo (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_ejemplar INT NOT NULL,
    fecha_prestamo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento TIMESTAMP NOT NULL,
    estado VARCHAR(50) DEFAULT 'Activo',
    observaciones TEXT,
    CONSTRAINT fk_prestamo_usr FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_prestamo_ejemplar FOREIGN KEY (id_ejemplar) REFERENCES ejemplar(id_ejemplar) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE devolucion (
    id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
    id_prestamo INT UNIQUE NOT NULL,
    fecha_devolucion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado_ejemplar VARCHAR(50),
    id_biblioteca_recepcion INT NOT NULL,
    observaciones TEXT,
    CONSTRAINT fk_devolucion_prestamo FOREIGN KEY (id_prestamo) REFERENCES prestamo(id_prestamo) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_devolucion_bib FOREIGN KEY (id_biblioteca_recepcion) REFERENCES biblioteca(id_biblioteca) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE renovacion (
    id_renovacion INT AUTO_INCREMENT PRIMARY KEY,
    id_prestamo INT NOT NULL,
    fecha_renovacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento_anterior TIMESTAMP NOT NULL,
    fecha_vencimiento_nueva TIMESTAMP NOT NULL,
    tipo VARCHAR(50),
    es_automatica BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_renovacion_prestamo FOREIGN KEY (id_prestamo) REFERENCES prestamo(id_prestamo) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE multa (
    id_multa INT AUTO_INCREMENT PRIMARY KEY,
    id_prestamo INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    motivo VARCHAR(255),
    fecha_generacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_pago TIMESTAMP NULL DEFAULT NULL,
    estado VARCHAR(50) DEFAULT 'Pendiente',
    CONSTRAINT fk_multa_prestamo FOREIGN KEY (id_prestamo) REFERENCES prestamo(id_prestamo) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;