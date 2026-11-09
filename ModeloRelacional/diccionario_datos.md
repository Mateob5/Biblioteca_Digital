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


| Símbolo     | Significado             |
|--------------|-------------------------|
| **PK**       | Clave primaria          |
| **FK**       | Clave foránea          |
| **UNIQUE**   | Valor único            |
| **CHECK**    | Restricción de dominio |
| **NOT NULL** | Campo obligatorio       |
| **DEFAULT**  | Valor por defecto       |


---

## 1. Tabla: `pais`


| Columna | Tipo         | Restricción       | Descripción                   |
|---------|--------------|--------------------|--------------------------------|
| id_pais | INT          | PK, AUTO_INCREMENT | Identificador único del país |
| nombre  | VARCHAR(100) | NOT NULL           | Nombre oficial del país       |


---

## 2. Tabla: `idioma`


| Columna   | Tipo        | Restricción       | Descripción                    |
|-----------|-------------|--------------------|---------------------------------|
| id_idioma | INT         | PK, AUTO_INCREMENT | Identificador único del idioma |
| nombre    | VARCHAR(50) | NOT NULL           | Nombre del idioma               |


---

## 3. Tabla: `universidad`


| Columna        | Tipo         | Restricción                        | Descripción                           |
|----------------|--------------|-------------------------------------|----------------------------------------|
| id_universidad | INT          | PK, AUTO_INCREMENT                  | Identificador único de la universidad |
| nombre         | VARCHAR(150) | NOT NULL                            | Nombre de la universidad               |
| nit            | VARCHAR(50)  | UNIQUE                              | NIT institucional                      |
| direccion      | VARCHAR(200) |                                | Dirección física                     |
| ciudad         | VARCHAR(100) |                                | Ciudad                                 |
| id_pais        | INT          | FK → pais                         | País de ubicación                    |
| estado         | VARCHAR(50)  | NOT NULL, DEFAULT 'Activa'          | Estado de la universidad               |
| fecha_creacion | DATETIME     | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de registro                      |


---

## 4. Tabla: `universidad_contacto`


| Columna        | Tipo         | Restricción            | Descripción                              |
|----------------|--------------|-------------------------|-------------------------------------------|
| id_contacto    | INT          | PK, AUTO_INCREMENT      | Identificador del contacto                |
| id_universidad | INT          | FK → universidad      | Universidad asociada                      |
| tipo_contacto  | VARCHAR(50)  | NOT NULL                | Tipo de contacto (Teléfono, Correo, Web) |
| valor          | VARCHAR(150) | NOT NULL                | Valor del contacto                        |
| es_principal   | BOOLEAN      | NOT NULL, DEFAULT FALSE | Indica si es el contacto principal        |


---

## 5. Tabla: `tipo_usuario`


| Columna          | Tipo         | Restricción           | Descripción                                |
|------------------|--------------|------------------------|---------------------------------------------|
| id_tipo_usuario  | INT          | PK, AUTO_INCREMENT     | Identificador del tipo de usuario           |
| nombre           | VARCHAR(100) | NOT NULL               | Estudiante, docente, administrativo, etc.   |
| max_prestamos    | INT          | NOT NULL, DEFAULT 0    | Máximo de préstamos simultáneos          |
| dias_prestamo    | INT          | NOT NULL, DEFAULT 0    | Días permitidos de préstamo               |
| max_renovaciones | INT          | NOT NULL, DEFAULT 0    | Máximo de renovaciones permitidas          |
| permite_reserva  | BOOLEAN      | NOT NULL, DEFAULT TRUE | Indica si el tipo de usuario puede reservar |


---

## 6. Tabla: `biblioteca`


| Columna        | Tipo         | Restricción               | Descripción                   |
|----------------|--------------|----------------------------|--------------------------------|
| id_biblioteca  | INT          | PK, AUTO_INCREMENT         | Identificador de la biblioteca |
| id_universidad | INT          | FK → universidad         | Universidad a la que pertenece |
| nombre         | VARCHAR(150) | NOT NULL                   | Nombre de la biblioteca        |
| direccion      | VARCHAR(200) |                       | Dirección física             |
| horario        | VARCHAR(100) |                       | Horario de atención           |
| estado         | VARCHAR(50)  | NOT NULL, DEFAULT 'Activa' | Estado de la biblioteca        |


---

## 7. Tabla: `biblioteca_contacto`


| Columna         | Tipo         | Restricción            | Descripción                       |
|-----------------|--------------|-------------------------|------------------------------------|
| id_contacto_bib | INT          | PK, AUTO_INCREMENT      | Identificador del contacto         |
| id_biblioteca   | INT          | FK → biblioteca       | Biblioteca asociada                |
| tipo_contacto   | VARCHAR(50)  | NOT NULL                | Tipo de contacto                   |
| valor           | VARCHAR(150) | NOT NULL                | Valor del contacto                 |
| es_principal    | BOOLEAN      | NOT NULL, DEFAULT FALSE | Indica si es el contacto principal |


---

## 8. Tabla: `usuario`


| Columna         | Tipo         | Restricción                        | Descripción                   |
|-----------------|--------------|-------------------------------------|--------------------------------|
| id_usuario      | INT          | PK, AUTO_INCREMENT                  | Identificador del usuario      |
| id_universidad  | INT          | FK → universidad                  | Universidad a la que pertenece |
| id_tipo_usuario | INT          | FK → tipo_usuario                 | Tipo de usuario                |
| documento       | VARCHAR(50)  | NOT NULL, UNIQUE                    | Documento de identidad         |
| nombres         | VARCHAR(150) | NOT NULL                            | Nombres                        |
| apellidos       | VARCHAR(150) | NOT NULL                            | Apellidos                      |
| direccion       | VARCHAR(200) |                                | Dirección                     |
| estado          | VARCHAR(50)  | NOT NULL, DEFAULT 'Activo'          | Estado del usuario             |
| fecha_registro  | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de registro              |


---

## 9. Tabla: `usuario_contacto`


| Columna         | Tipo         | Restricción            | Descripción                       |
|-----------------|--------------|-------------------------|------------------------------------|
| id_contacto_usr | INT          | PK, AUTO_INCREMENT      | Identificador del contacto         |
| id_usuario      | INT          | FK → usuario          | Usuario asociado                   |
| tipo_contacto   | VARCHAR(50)  | NOT NULL                | Tipo de contacto                   |
| valor           | VARCHAR(150) | NOT NULL                | Valor del contacto                 |
| es_principal    | BOOLEAN      | NOT NULL, DEFAULT FALSE | Indica si es el contacto principal |


---

## 10. Tabla: `categoria`


| Columna      | Tipo         | Restricción       | Descripción                |
|--------------|--------------|--------------------|-----------------------------|
| id_categoria | INT          | PK, AUTO_INCREMENT | Identificador de categoría |
| nombre       | VARCHAR(150) | NOT NULL           | Nombre de la categoría     |
| descripcion  | TEXT         |               | Descripción                |
| codigo_dewey | VARCHAR(50)  |               | Código Dewey               |


---

## 11. Tabla: `editorial`


| Columna      | Tipo         | Restricción       | Descripción               |
|--------------|--------------|--------------------|----------------------------|
| id_editorial | INT          | PK, AUTO_INCREMENT | Identificador de editorial |
| nombre       | VARCHAR(150) | NOT NULL           | Nombre de la editorial     |
| id_pais      | INT          | FK → pais        | País de origen            |


---

## 12. Tabla: `editorial_contacto`


| Columna        | Tipo         | Restricción            | Descripción                       |
|----------------|--------------|-------------------------|------------------------------------|
| id_contacto_ed | INT          | PK, AUTO_INCREMENT      | Identificador del contacto         |
| id_editorial   | INT          | FK → editorial        | Editorial asociada                 |
| tipo_contacto  | VARCHAR(50)  | NOT NULL                | Tipo de contacto                   |
| valor          | VARCHAR(150) | NOT NULL                | Valor del contacto                 |
| es_principal   | BOOLEAN      | NOT NULL, DEFAULT FALSE | Indica si es el contacto principal |


---

## 13. Tabla: `autor`


| Columna          | Tipo         | Restricción       | Descripción            |
|------------------|--------------|--------------------|-------------------------|
| id_autor         | INT          | PK, AUTO_INCREMENT | Identificador del autor |
| nombres          | VARCHAR(150) | NOT NULL           | Nombres                 |
| apellidos        | VARCHAR(150) | NOT NULL           | Apellidos               |
| fecha_nacimiento | DATE         |               | Fecha de nacimiento     |


---

## 14. Tabla: `autor_nacionalidad`


| Columna      | Tipo    | Restricción            | Descripción                           |
|--------------|---------|-------------------------|----------------------------------------|
| id_autor_nac | INT     | PK, AUTO_INCREMENT      | Identificador                          |
| id_autor     | INT     | FK → autor            | Autor asociado                         |
| id_pais      | INT     | FK → pais             | Nacionalidad del autor                 |
| es_principal | BOOLEAN | NOT NULL, DEFAULT FALSE | Indica si es la nacionalidad principal |


---

## 15. Tabla: `recurso`


| Columna          | Tipo         | Restricción                        | Descripción                                 |
|------------------|--------------|-------------------------------------|----------------------------------------------|
| id_recurso       | INT          | PK, AUTO_INCREMENT                  | Identificador del recurso                    |
| id_universidad   | INT          | FK → universidad                  | Universidad dueña del catálogo             |
| id_categoria     | INT          | FK → categoria                    | Categoría temática                         |
| id_editorial     | INT          | FK → editorial                    | Editorial                                    |
| titulo           | VARCHAR(255) | NOT NULL                            | Título                                      |
| subtitulo        | VARCHAR(255) |                                | Subtítulo                                   |
| isbn             | VARCHAR(50)  |                                | ISBN                                         |
| tipo_recurso     | VARCHAR(50)  | NOT NULL                            | Libro, Revista, Periódico, Tesis, etc.      |
| anio_publicacion | INT          |                                | Año de publicación                         |
| descripcion      | TEXT         |                                | Descripción                                 |
| numero_paginas   | INT          |                                | Número de páginas                          |
| es_prestable     | BOOLEAN      | NOT NULL, DEFAULT TRUE              | FALSE si es material de consulta (solo sala) |
| fecha_creacion   | TIMESTAMP    | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de registro en el sistema              |


---

## 16. Tabla: `recurso_idioma`


| Columna           | Tipo    | Restricción            | Descripción                     |
|-------------------|---------|-------------------------|----------------------------------|
| id_recurso_idioma | INT     | PK, AUTO_INCREMENT      | Identificador                    |
| id_recurso        | INT     | FK → recurso          | Recurso asociado                 |
| id_idioma         | INT     | FK → idioma           | Idioma del recurso               |
| es_principal      | BOOLEAN | NOT NULL, DEFAULT FALSE | Indica si es el idioma principal |


---

## 17. Tabla: `recurso_formato_digital`


| Columna    | Tipo          | Restricción       | Descripción               |
|------------|---------------|--------------------|----------------------------|
| id_formato | INT           | PK, AUTO_INCREMENT | Identificador              |
| id_recurso | INT           | FK → recurso     | Recurso asociado           |
| formato    | VARCHAR(50)   | NOT NULL           | PDF, EPUB, MOBI, MP4, etc. |
| url        | TEXT          | NOT NULL           | URL del archivo digital    |
| tamano_mb  | DECIMAL(10,2) |               | Tamaño del archivo en MB  |


---

## 18. Tabla: `recurso_autor`


| Columna    | Tipo | Restricción        | Descripción                    |
|------------|------|---------------------|---------------------------------|
| id_recurso | INT  | PK, FK → recurso  | Recurso                         |
| id_autor   | INT  | PK, FK → autor    | Autor                           |
| orden      | INT  | NOT NULL, DEFAULT 1 | Orden de autoría (1=Principal) |


---

## 19. Tabla: `ejemplar`


| Columna           | Tipo          | Restricción                   | Descripción                              |
|-------------------|---------------|--------------------------------|-------------------------------------------|
| id_ejemplar       | INT           | PK, AUTO_INCREMENT             | Identificador del ejemplar                |
| id_recurso        | INT           | FK → recurso                 | Recurso asociado                          |
| id_biblioteca     | INT           | FK → biblioteca              | Biblioteca donde se encuentra             |
| codigo_barras     | VARCHAR(100)  | NOT NULL, UNIQUE               | Código de barras                         |
| ubicacion         | VARCHAR(100)  |                           | Ubicación física en estantería         |
| tipo_ejemplar     | VARCHAR(50)   |                           | Físico, Digital, Referencia              |
| estado            | VARCHAR(50)   | NOT NULL, DEFAULT 'Disponible' | Disponible, Prestado, Reservado, etc.     |
| fecha_adquisicion | DATE          |                           | Fecha de compra/ingreso                   |
| precio_reposicion | DECIMAL(10,2) |                           | Precio de reposición                     |
| rfid              | VARCHAR(100)  |                           | Código del chip RFID                     |
| volumen           | VARCHAR(50)   |                           | Volumen (para revistas o colecciones)     |
| numero_edicion    | VARCHAR(50)   |                           | Número de edición o fecha (periódicos) |


---

## 20. Tabla: `prestamo`


| Columna           | Tipo        | Restricción                        | Descripción                    |
|-------------------|-------------|-------------------------------------|---------------------------------|
| id_prestamo       | INT         | PK, AUTO_INCREMENT                  | Identificador del préstamo     |
| id_usuario        | INT         | FK → usuario                      | Usuario que solicita            |
| id_ejemplar       | INT         | FK → ejemplar                     | Ejemplar prestado               |
| fecha_prestamo    | TIMESTAMP   | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de préstamo              |
| fecha_vencimiento | TIMESTAMP   | NOT NULL                            | Fecha límite de devolución    |
| estado            | VARCHAR(50) | NOT NULL, DEFAULT 'Activo'          | Activo, Vencido, Devuelto, etc. |
| observaciones     | TEXT        |                                | Observaciones adicionales       |


---

## 21. Tabla: `renovacion`


| Columna                    | Tipo        | Restricción                        | Descripción                                   |
|----------------------------|-------------|-------------------------------------|------------------------------------------------|
| id_renovacion              | INT         | PK, AUTO_INCREMENT                  | Identificador                                  |
| id_prestamo                | INT         | FK → prestamo, ON DELETE CASCADE  | Préstamo asociado                             |
| fecha_renovacion           | TIMESTAMP   | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de renovación                           |
| fecha_vencimiento_anterior | TIMESTAMP   | NOT NULL                            | Vencimiento antes de renovar                   |
| fecha_vencimiento_nueva    | TIMESTAMP   | NOT NULL                            | Nuevo vencimiento                              |
| tipo                       | VARCHAR(50) |                                | MANUAL o AUTOMATICA                            |
| es_automatica              | BOOLEAN     | NOT NULL, DEFAULT FALSE             | TRUE si el sistema la generó automáticamente |


---

## 22. Tabla: `devolucion`


| Columna                 | Tipo        | Restricción                        | Descripción                      |
|-------------------------|-------------|-------------------------------------|-----------------------------------|
| id_devolucion           | INT         | PK, AUTO_INCREMENT                  | Identificador                     |
| id_prestamo             | INT         | NOT NULL, UNIQUE, FK → prestamo   | Préstamo asociado (1 a 1)        |
| fecha_devolucion        | TIMESTAMP   | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de entrega                  |
| estado_ejemplar         | VARCHAR(50) |                                | BUENO, DETERIORADO, PERDIDO       |
| id_biblioteca_recepcion | INT         | FK → biblioteca                   | Biblioteca que recibe el ejemplar |
| observaciones           | TEXT        |                                | Observaciones adicionales         |


---

## 23. Tabla: `reserva`


| Columna          | Tipo        | Restricción                        | Descripción                         |
|------------------|-------------|-------------------------------------|--------------------------------------|
| id_reserva       | INT         | PK, AUTO_INCREMENT                  | Identificador                        |
| id_usuario       | INT         | FK → usuario                      | Usuario que reserva                  |
| id_recurso       | INT         | FK → recurso                      | Recurso reservado                    |
| id_biblioteca    | INT         | FK → biblioteca                   | Sede donde se recogerá el recurso   |
| fecha_reserva    | TIMESTAMP   | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de la reserva                  |
| fecha_expiracion | TIMESTAMP   |                                | Fecha límite para reclamar          |
| estado           | VARCHAR(50) | NOT NULL, DEFAULT 'Activa'          | Pendiente, Cumplida, Cancelada, etc. |
| posicion_cola    | INT         |                                | Posición en la cola de espera       |


---

## 24. Tabla: `multa`


| Columna          | Tipo          | Restricción                        | Descripción                                    |
|------------------|---------------|-------------------------------------|-------------------------------------------------|
| id_multa         | INT           | PK, AUTO_INCREMENT                  | Identificador                                   |
| id_prestamo      | INT           | FK → prestamo                     | Préstamo que originó la multa                 |
| monto            | DECIMAL(10,2) | NOT NULL                            | Valor de la multa                               |
| motivo           | VARCHAR(255)  |                                | Motivo                                          |
| fecha_generacion | TIMESTAMP     | NOT NULL, DEFAULT CURRENT_TIMESTAMP | Fecha de creación                              |
| fecha_pago       | TIMESTAMP     | NULL                                | Fecha en que se pagó (nulo si no se ha pagado) |
| estado           | VARCHAR(50)   | NOT NULL, DEFAULT 'Pendiente'       | Pendiente, Pagada, Condonada                    |


---

## Resumen de tablas


| #  | Tabla                   | Tipo          |
|----|-------------------------|---------------|
| 1  | pais                    | Catálogo     |
| 2  | idioma                  | Catálogo     |
| 3  | universidad             | Maestra       |
| 4  | universidad_contacto    | Detalle       |
| 5  | tipo_usuario            | Maestra       |
| 6  | biblioteca              | Maestra       |
| 7  | biblioteca_contacto     | Detalle       |
| 8  | usuario                 | Maestra       |
| 9  | usuario_contacto        | Detalle       |
| 10 | categoria               | Maestra       |
| 11 | editorial               | Maestra       |
| 12 | editorial_contacto      | Detalle       |
| 13 | autor                   | Maestra       |
| 14 | autor_nacionalidad      | Detalle       |
| 15 | recurso                 | Maestra       |
| 16 | recurso_idioma          | Detalle       |
| 17 | recurso_formato_digital | Detalle       |
| 18 | recurso_autor           | Intermedia    |
| 19 | ejemplar                | Maestra       |
| 20 | prestamo                | Transaccional |
| 21 | renovacion              | Transaccional |
| 22 | devolucion              | Transaccional |
| 23 | reserva                 | Transaccional |
| 24 | multa                   | Transaccional |


---

## Relaciones principales


| Relación                            | Cardinalidad | Descripción                                          |
|--------------------------------------|--------------|-------------------------------------------------------|
| pais → universidad                 | 1:N          | Un país tiene varias universidades                   |
| pais → editorial                   | 1:N          | Un país tiene varias editoriales                     |
| pais → autor_nacionalidad          | 1:N          | Un país se asocia a varias nacionalidades de autores |
| idioma → recurso_idioma            | 1:N          | Un idioma se asocia a varios recursos                 |
| universidad → universidad_contacto | 1:N          | Una universidad tiene varios contactos                |
| universidad → biblioteca           | 1:N          | Una universidad tiene varias bibliotecas              |
| universidad → usuario              | 1:N          | Una universidad registra varios usuarios              |
| universidad → recurso              | 1:N          | Una universidad cataloga varios recursos              |
| tipo_usuario → usuario             | 1:N          | Un tipo clasifica varios usuarios                     |
| biblioteca → biblioteca_contacto   | 1:N          | Una biblioteca tiene varios contactos                 |
| biblioteca → ejemplar              | 1:N          | Una biblioteca almacena varios ejemplares             |
| biblioteca → reserva               | 1:N          | Una biblioteca recibe varias reservas                 |
| biblioteca → devolucion            | 1:N          | Una biblioteca recibe varias devoluciones             |
| usuario → usuario_contacto         | 1:N          | Un usuario tiene varios contactos                     |
| usuario → prestamo                 | 1:N          | Un usuario solicita varios préstamos                 |
| usuario → reserva                  | 1:N          | Un usuario realiza varias reservas                    |
| categoria → recurso                | 1:N          | Una categoría clasifica varios recursos              |
| editorial → editorial_contacto     | 1:N          | Una editorial tiene varios contactos                  |
| editorial → recurso                | 1:N          | Una editorial publica varios recursos                 |
| autor → autor_nacionalidad         | 1:N          | Un autor tiene varias nacionalidades                  |
| autor → recurso_autor              | 1:N          | Un autor escribe varios recursos                      |
| recurso → recurso_idioma           | 1:N          | Un recurso está en varios idiomas                    |
| recurso → recurso_formato_digital  | 1:N          | Un recurso tiene varios formatos digitales            |
| recurso → recurso_autor            | 1:N          | Un recurso tiene varios autores                       |
| recurso → ejemplar                 | 1:N          | Un recurso tiene varios ejemplares                    |
| recurso → reserva                  | 1:N          | Un recurso es reservado varias veces                  |
| ejemplar → prestamo                | 1:N          | Un ejemplar es prestado varias veces                  |
| prestamo → renovacion              | 1:N          | Un préstamo tiene varias renovaciones                |
| prestamo → devolucion              | 1:1          | Un préstamo tiene una sola devolución               |
| prestamo → multa                   | 1:N          | Un préstamo puede generar varias multas              |


---

## Referencias

- DataSunrise. (s.f.). Diccionario de base de datos. DataSunrise. Recuperado el 6 de octubre de 2026, de [https://www.datasunrise.com/es/centro-de-conocimiento/diccionario-de-base-de-datos/](https://www.datasunrise.com/es/centro-de-conocimiento/diccionario-de-base-de-datos/)
- Harvard University. (s.f.). Data dictionary. Harvard Medical School, Data Management. Recuperado el 6 de octubre de 2026, de [https://datamanagement.hms.harvard.edu/collect-analyze/documentation-metadata/data-dictionary](https://datamanagement.hms.harvard.edu/collect-analyze/documentation-metadata/data-dictionary)
- Olaya, V. (2014). Bases de datos. En Sistemas de información geográfica (cap. 3). Recuperado el 6 de octubre de 2026, de [https://volaya.github.io/libro-sig/chapters/Bases_datos.html](https://volaya.github.io/libro-sig/chapters/Bases_datos.html)

 
