# Diccionario de Datos – Modelo Relacional

## Integrantes
- Jeronimo Andres Mateo Bazan Rojas - 2243590
- Paula Lizeth Ardila Pinzon - 2243586
- Sebastian Andres Baldovino Suarez - 2243565
- Santiago Sepúlveda Blanco - 2243557

---

## Introducción

Este documento describe el **diccionario de datos** del modelo relacional del Sistema de Gestión de Bibliotecas Universitarias. Para cada tabla se especifican:

- Nombre de la columna.
- Tipo de dato.
- Restricciones (PK, FK, UNIQUE, CHECK, NOT NULL, DEFAULT).
- Descripción funcional.

### Convenciones

| Símbolo | Significado |
|---|---|
| **PK** | Clave primaria |
| **FK** | Clave foránea |
| **UNIQUE** | Valor único |
| **CHECK** | Restricción de dominio |
| **NOT NULL** | Campo obligatorio |
| **DEFAULT** | Valor por defecto |

---

## 1. Tabla: `universidad`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_universidad | INT | PK | Identificador único de la universidad |
| nombre | VARCHAR(150) | NOT NULL | Nombre de la universidad |
| nit | VARCHAR(30) | UNIQUE | NIT institucional |
| direccion | VARCHAR(200) | | Dirección física |
| ciudad | VARCHAR(100) | | Ciudad |
| pais | VARCHAR(100) | NOT NULL, DEFAULT 'Colombia' | País |
| estado | VARCHAR(20) | NOT NULL, DEFAULT 'ACTIVA', CHECK IN ('ACTIVA','INACTIVA') | Estado de la universidad |
| fecha_creacion | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de registro |

---

## 2. Tabla: `universidad_contacto`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_contacto | INT | PK | Identificador del contacto |
| id_universidad | INT | FK → universidad | Universidad asociada |
| tipo_contacto | VARCHAR(20) | NOT NULL, CHECK IN ('TELEFONO','CORREO','WEB') | Tipo de contacto |
| valor | VARCHAR(150) | NOT NULL | Valor del contacto |
| es_principal | BOOLEAN | NOT NULL, DEFAULT FALSE | Indica si es el contacto principal |

---

## 3. Tabla: `tipo_usuario`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_tipo_usuario | INT | PK | Identificador del tipo de usuario |
| nombre | VARCHAR(50) | NOT NULL, UNIQUE | Estudiante, docente, administrativo |
| max_prestamos | INT | NOT NULL, CHECK >= 0 | Máximo de préstamos simultáneos |
| dias_prestamo | INT | NOT NULL, CHECK > 0 | Días permitidos de préstamo |
| max_renovaciones | INT | NOT NULL, DEFAULT 0, CHECK >= 0 | Máximo de renovaciones |
| permite_reserva | BOOLEAN | NOT NULL, DEFAULT TRUE | Si puede reservar |

---

## 4. Tabla: `biblioteca`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_biblioteca | INT | PK | Identificador de la biblioteca |
| id_universidad | INT | FK → universidad | Universidad a la que pertenece |
| nombre | VARCHAR(120) | NOT NULL | Nombre de la biblioteca |
| direccion | VARCHAR(200) | | Dirección |
| horario | VARCHAR(120) | | Horario de atención |
| estado | VARCHAR(20) | NOT NULL, DEFAULT 'ACTIVA', CHECK IN ('ACTIVA','INACTIVA') | Estado |
| | | UNIQUE (id_universidad, nombre) | Nombre único por universidad |

---

## 5. Tabla: `biblioteca_contacto`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_contacto_bib | INT | PK | Identificador del contacto |
| id_biblioteca | INT | FK → biblioteca | Biblioteca asociada |
| tipo_contacto | VARCHAR(20) | NOT NULL, CHECK IN ('TELEFONO','CORREO') | Tipo de contacto |
| valor | VARCHAR(150) | NOT NULL | Valor del contacto |
| es_principal | BOOLEAN | NOT NULL, DEFAULT FALSE | Indica si es el contacto principal |

---

## 6. Tabla: `usuario`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_usuario | INT | PK | Identificador del usuario |
| id_universidad | INT | FK → universidad | Universidad |
| id_tipo_usuario | INT | FK → tipo_usuario | Tipo de usuario |
| documento | VARCHAR(30) | NOT NULL | Documento de identidad |
| nombres | VARCHAR(100) | NOT NULL | Nombres |
| apellidos | VARCHAR(100) | NOT NULL | Apellidos |
| direccion | VARCHAR(200) | | Dirección |
| estado | VARCHAR(20) | NOT NULL, DEFAULT 'ACTIVO', CHECK IN ('ACTIVO','INACTIVO','SUSPENDIDO') | Estado |
| fecha_registro | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de registro |
| | | UNIQUE (id_universidad, documento) | Documento único por universidad |

---

## 7. Tabla: `usuario_contacto`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_contacto_usr | INT | PK | Identificador del contacto |
| id_usuario | INT | FK → usuario | Usuario asociado |
| tipo_contacto | VARCHAR(20) | NOT NULL, CHECK IN ('TELEFONO','CORREO') | Tipo de contacto |
| valor | VARCHAR(150) | NOT NULL | Valor del contacto |
| es_principal | BOOLEAN | NOT NULL, DEFAULT FALSE | Indica si es el contacto principal |

---

## 8. Tabla: `categoria`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_categoria | INT | PK | Identificador de categoría |
| nombre | VARCHAR(100) | NOT NULL, UNIQUE | Nombre de la categoría |
| descripcion | TEXT | | Descripción |
| codigo_dewey | VARCHAR(20) | | Código Dewey |

---

## 9. Tabla: `editorial`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_editorial | INT | PK | Identificador de editorial |
| nombre | VARCHAR(150) | NOT NULL, UNIQUE | Nombre de la editorial |
| pais | VARCHAR(100) | | País |

---

## 10. Tabla: `editorial_contacto`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_contacto_ed | INT | PK | Identificador del contacto |
| id_editorial | INT | FK → editorial | Editorial asociada |
| tipo_contacto | VARCHAR(20) | NOT NULL, CHECK IN ('TELEFONO','CORREO','WEB') | Tipo de contacto |
| valor | VARCHAR(150) | NOT NULL | Valor del contacto |
| es_principal | BOOLEAN | NOT NULL, DEFAULT FALSE | Indica si es el contacto principal |

---

## 11. Tabla: `autor`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_autor | INT | PK | Identificador del autor |
| nombres | VARCHAR(100) | NOT NULL | Nombres |
| apellidos | VARCHAR(100) | NOT NULL | Apellidos |
| fecha_nacimiento | DATE | | Fecha de nacimiento |

---

## 12. Tabla: `autor_nacionalidad`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_autor_nac | INT | PK | Identificador |
| id_autor | INT | FK → autor | Autor asociado |
| nacionalidad | VARCHAR(80) | NOT NULL | Nacionalidad |
| es_principal | BOOLEAN | NOT NULL, DEFAULT FALSE | Indica si es la principal |

---

## 13. Tabla: `recurso`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_recurso | INT | PK | Identificador del recurso |
| id_universidad | INT | FK → universidad | Universidad |
| id_categoria | INT | FK → categoria | Categoría |
| id_editorial | INT | FK → editorial | Editorial |
| titulo | VARCHAR(250) | NOT NULL | Título |
| subtitulo | VARCHAR(250) | | Subtítulo |
| isbn | VARCHAR(20) | | ISBN |
| tipo_recurso | VARCHAR(30) | NOT NULL, CHECK IN ('LIBRO','REVISTA','PERIODICO','TESIS','AUDIOVISUAL','DIGITAL') | Tipo de recurso |
| anio_publicacion | INT | CHECK >= 1000 | Año de publicación |
| descripcion | TEXT | | Descripción |
| numero_paginas | INT | CHECK > 0 | Número de páginas |
| fecha_creacion | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de registro |
| | | UNIQUE (id_universidad, isbn) | ISBN único por universidad |

---

## 14. Tabla: `recurso_idioma`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_recurso_idioma | INT | PK | Identificador |
| id_recurso | INT | FK → recurso | Recurso asociado |
| idioma | VARCHAR(30) | NOT NULL | Idioma del recurso |
| es_principal | BOOLEAN | NOT NULL, DEFAULT FALSE | Indica si es el idioma principal |

---

## 15. Tabla: `recurso_formato_digital`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_formato | INT | PK | Identificador |
| id_recurso | INT | FK → recurso | Recurso asociado |
| formato | VARCHAR(20) | NOT NULL | PDF, EPUB, MOBI, etc. |
| url | TEXT | NOT NULL | URL del archivo digital |
| tamano_mb | FLOAT | CHECK >= 0 | Tamaño del archivo en MB |

---

## 16. Tabla: `recurso_autor`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_recurso | INT | PK, FK → recurso | Recurso |
| id_autor | INT | PK, FK → autor | Autor |
| orden | INT | NOT NULL, CHECK > 0 | Orden de autoría |
| | | UNIQUE (id_recurso, orden) | Orden único por recurso |

---

## 17. Tabla: `ejemplar`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_ejemplar | INT | PK | Identificador del ejemplar |
| id_recurso | INT | FK → recurso | Recurso |
| id_biblioteca | INT | FK → biblioteca | Biblioteca |
| codigo_barras | VARCHAR(50) | NOT NULL | Código de barras |
| ubicacion | VARCHAR(120) | | Ubicación física |
| tipo_ejemplar | VARCHAR(20) | NOT NULL, CHECK IN ('FISICO','DIGITAL') | Tipo |
| estado | VARCHAR(30) | NOT NULL, DEFAULT 'DISPONIBLE', CHECK IN ('DISPONIBLE','PRESTADO','RESERVADO','MANTENIMIENTO','BAJA') | Estado |
| fecha_adquisicion | DATE | | Fecha de adquisición |
| precio_reposicion | FLOAT | CHECK >= 0 | Precio de reposición |
| rfid | VARCHAR(50) | UNIQUE | Código RFID |
| | | UNIQUE (id_biblioteca, codigo_barras) | Código único por biblioteca |

---

## 18. Tabla: `prestamo`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_prestamo | INT | PK | Identificador del préstamo |
| id_usuario | INT | FK → usuario | Usuario |
| id_ejemplar | INT | FK → ejemplar | Ejemplar |
| fecha_prestamo | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de préstamo |
| fecha_vencimiento | TIMESTAMP | NOT NULL | Fecha límite |
| estado | VARCHAR(20) | NOT NULL, DEFAULT 'ACTIVO', CHECK IN ('ACTIVO','VENCIDO','DEVUELTO','RENOVADO','PERDIDO') | Estado |
| observaciones | TEXT | | Observaciones |
| | | CHECK (fecha_vencimiento > fecha_prestamo) | Validación de fechas |

---

## 19. Tabla: `renovacion`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_renovacion | INT | PK | Identificador |
| id_prestamo | INT | FK → prestamo, ON DELETE CASCADE | Préstamo |
| fecha_renovacion | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de renovación |
| fecha_vencimiento_anterior | TIMESTAMP | NOT NULL | Vencimiento anterior |
| fecha_vencimiento_nueva | TIMESTAMP | NOT NULL | Nuevo vencimiento |
| tipo | VARCHAR(20) | NOT NULL, CHECK IN ('MANUAL','AUTOMATICA') | Tipo |
| | | CHECK (fecha_vencimiento_nueva > fecha_vencimiento_anterior) | Validación |

---

## 20. Tabla: `devolucion`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_devolucion | INT | PK | Identificador |
| id_prestamo | INT | NOT NULL, UNIQUE, FK → prestamo | Préstamo |
| fecha_devolucion | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha |
| estado_ejemplar | VARCHAR(30) | NOT NULL, CHECK IN ('BUENO','DETERIORADO','PERDIDO') | Estado |
| id_biblioteca_recepcion | INT | FK → biblioteca | Biblioteca que recibe |
| observaciones | TEXT | | Observaciones |

---

## 21. Tabla: `reserva`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_reserva | INT | PK | Identificador |
| id_usuario | INT | FK → usuario | Usuario |
| id_recurso | INT | FK → recurso | Recurso |
| fecha_reserva | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha |
| fecha_expiracion | TIMESTAMP | | Expiración |
| estado | VARCHAR(20) | NOT NULL, DEFAULT 'PENDIENTE', CHECK IN ('PENDIENTE','DISPONIBLE','CUMPLIDA','CANCELADA','EXPIRADA') | Estado |
| posicion_cola | INT | CHECK > 0 | Posición en cola |

---

## 22. Tabla: `multa`

| Columna | Tipo | Restricción | Descripción |
|---|---|---|---|
| id_multa | INT | PK | Identificador |
| id_prestamo | INT | FK → prestamo | Préstamo |
| monto | FLOAT | NOT NULL, CHECK > 0 | Monto |
| motivo | VARCHAR(200) | NOT NULL | Motivo |
| fecha_generacion | TIMESTAMP | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha |
| fecha_pago | TIMESTAMP | | Fecha de pago |
| estado | VARCHAR(20) | NOT NULL, DEFAULT 'PENDIENTE', CHECK IN ('PENDIENTE','PAGADA','CONDONADA','ANULADA') | Estado |

---

## Resumen de tablas

| # | Tabla | Tipo | Registros esperados |
|---|---|---|---|
| 1 | universidad | Maestra | Bajo |
| 2 | universidad_contacto | Detalle | Bajo |
| 3 | tipo_usuario | Maestra | Muy bajo |
| 4 | biblioteca | Maestra | Bajo |
| 5 | biblioteca_contacto | Detalle | Bajo |
| 6 | usuario | Maestra | Alto |
| 7 | usuario_contacto | Detalle | Alto |
| 8 | categoria | Maestra | Medio |
| 9 | editorial | Maestra | Medio |
| 10 | editorial_contacto | Detalle | Medio |
| 11 | autor | Maestra | Alto |
| 12 | autor_nacionalidad | Detalle | Alto |
| 13 | recurso | Maestra | Alto |
| 14 | recurso_idioma | Detalle | Alto |
| 15 | recurso_formato_digital | Detalle | Medio |
| 16 | recurso_autor | Intermedia | Muy alto |
| 17 | ejemplar | Maestra | Muy alto |
| 18 | prestamo | Transaccional | Muy alto |
| 19 | renovacion | Transaccional | Alto |
| 20 | devolucion | Transaccional | Muy alto |
| 21 | reserva | Transaccional | Alto |
| 22 | multa | Transaccional | Medio |

---

## Relaciones principales

| Relación | Cardinalidad | Descripción |
|---|---|---|
| universidad → universidad_contacto | 1:N | Una universidad tiene varios contactos |
| universidad → biblioteca | 1:N | Una universidad tiene varias bibliotecas |
| universidad → usuario | 1:N | Una universidad registra varios usuarios |
| universidad → recurso | 1:N | Una universidad cataloga varios recursos |
| tipo_usuario → usuario | 1:N | Un tipo clasifica varios usuarios |
| biblioteca → biblioteca_contacto | 1:N | Una biblioteca tiene varios contactos |
| biblioteca → ejemplar | 1:N | Una biblioteca almacena varios ejemplares |
| biblioteca → devolucion | 1:N | Una biblioteca recibe varias devoluciones |
| usuario → usuario_contacto | 1:N | Un usuario tiene varios contactos |
| usuario → prestamo | 1:N | Un usuario solicita varios préstamos |
| usuario → reserva | 1:N | Un usuario realiza varias reservas |
| categoria → recurso | 1:N | Una categoría clasifica varios recursos |
| editorial → editorial_contacto | 1:N | Una editorial tiene varios contactos |
| editorial → recurso | 1:N | Una editorial publica varios recursos |
| autor → autor_nacionalidad | 1:N | Un autor tiene varias nacionalidades |
| autor → recurso_autor | 1:N | Un autor escribe varios recursos |
| recurso → recurso_idioma | 1:N | Un recurso está en varios idiomas |
| recurso → recurso_formato_digital | 1:N | Un recurso tiene varios formatos digitales |
| recurso → recurso_autor | 1:N | Un recurso tiene varios autores |
| recurso → ejemplar | 1:N | Un recurso tiene varios ejemplares |
| recurso → reserva | 1:N | Un recurso es reservado varias veces |
| ejemplar → prestamo | 1:N | Un ejemplar es prestado varias veces |
| prestamo → renovacion | 1:N | Un préstamo tiene varias renovaciones |
| prestamo → devolucion | 1:1 | Un préstamo tiene una devolución |
| prestamo → multa | 1:N | Un préstamo puede generar varias multas |

---

## Referencias

- Elmasri, R., & Navathe, S. (2016). *Fundamentals of Database Systems* (7th ed.). Pearson.
- Silberschatz, A., Korth, H., & Sudarshan, S. (2019). *Database System Concepts* (7th ed.). McGraw-Hill.
- Date, C. J. (2003). *An Introduction to Database Systems* (8th ed.). Addison-Wesley.