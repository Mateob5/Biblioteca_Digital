# Entrega Final – Implementación de Base de Datos SQL
## Sistema de Gestión de Bibliotecas Universitarias

## Integrantes
- Jeronimo Andres Mateo Bazan Rojas - 2243590
- Paula Lizeth Ardila Pinzon - 2243586
- Sebastian Andres Baldovino Suarez - 2243565
- Santiago Sepúlveda Blanco - 2243557

---

## Descripción de la carpeta

Esta carpeta contiene la **Entrega Final** del proyecto: la implementación física de la base de datos en un motor relacional (MySQL). A partir del modelo relacional normalizado hasta 5FN elaborado en la entrega anterior, se han desarrollado los scripts necesarios para crear la estructura, poblarla con datos de prueba y ejecutar consultas avanzadas que demuestran la lógica de negocio del sistema.

El sistema soporta una arquitectura **multi-tenant** (múltiples universidades) y gestiona de forma integral bibliotecas, usuarios, recursos bibliográficos, ejemplares, préstamos, renovaciones, reservas, devoluciones y multas.

---

## Contenido de la carpeta

| Archivo | Descripción |
|---|---|
| `01_esquema.sql` | Script DDL con la creación de las 24 tablas, claves primarias, foráneas y restricciones de integridad. |
| `02_datos.sql` | Script DML con la inserción de 5 registros de prueba por cada tabla (datos coherentes y contextualizados). |
| `03_consultas.sql` | Script DQL con 10 consultas avanzadas que resuelven necesidades operativas y estratégicas del negocio. |
| `README.md` | Documento actual con la guía de despliegue y el catálogo de consultas. |

---

## Instrucciones de Despliegue

1. Abrir el gestor de base de datos (MySQL Workbench, DBeaver, phpMyAdmin, etc.).
2. Crear una base de datos (ej. `biblioteca_digital_db`) y seleccionarla.
3. Ejecutar el archivo `01_esquema.sql` para crear la estructura de tablas.
4. Ejecutar el archivo `02_datos.sql` para poblar las tablas (respetando el orden de dependencias).
5. Ejecutar el archivo `03_consultas.sql` para validar el funcionamiento de las consultas.

---

## Decisiones Técnicas de Implementación

1. **Motor MySQL / InnoDB:** Se eligió MySQL por su robustez y uso extendido. El motor `InnoDB` garantiza transacciones ACID y soporte para integridad referencial estricta.
2. **Uso de `AUTO_INCREMENT`:** Todos los IDs son autoincrementables para facilitar la inserción de nuevos registros y evitar colisiones.
3. **Normalización de Catálogos:** Se añadieron tablas maestras (`pais`, `idioma`) para evitar redundancia y garantizar la integridad de los datos (cumpliendo 3FN/4FN).
4. **Integridad Referencial:** Se aplicaron restricciones `ON DELETE RESTRICT` para proteger la información transaccional (ej. no borrar un usuario con préstamos activos) y `ON DELETE CASCADE` en tablas dependientes (ej. contactos).
5. **Trazabilidad y Flexibilidad:** El esquema permite rastrear el ciclo de vida completo de un ejemplar (adquisición, préstamo, renovación, devolución, multa) y distingue entre recursos físicos y digitales.

---

## Catálogo de Consultas (Guion para la Presentación)

Este apartado explica el valor de negocio de las 10 consultas implementadas en el archivo `03_consultas.sql`.

| # | Consulta SQL | Objetivo de Negocio | Técnica SQL Destacada |
|---|---|---|---|
| **1** | Top 5 recursos más prestados | Identificar los libros de mayor demanda para optimizar compras y presupuestos. | `GROUP BY`, `ORDER BY`, `LIMIT`. |
| **2** | Usuarios con multas pendientes | Listar morosos y sus deudas totales para gestionar cobros y bloqueos de cuenta. | `JOIN`, `SUM`, `WHERE` por estado. |
| **3** | Disponibilidad por biblioteca | Conocer qué porcentaje del inventario está disponible en cada sede física. | `LEFT JOIN`, `CASE`, `ROUND`, `NULLIF`. |
| **4** | Préstamos que vencen en 3 días | Permite al sistema enviar correos automáticos de recordatorio a los usuarios. | `DATEDIFF`, `CURDATE()`, `NOT EXISTS`. |
| **5** | Autores con más libros en catálogo | Análisis de la colección para crear vitrinas o eventos literarios. | `GROUP_CONCAT`, `JOIN` múltiple. |
| **6** | Historial de usuario específico | Trazabilidad completa de un usuario (préstamos, renovaciones, retrasos y multas). | Subconsultas, `GREATEST`, `IFNULL`. |
| **7** | Recaudación por multas (por Universidad) | Reporte financiero multi-tenant para las directivas de cada universidad. | `LEFT JOIN`, `SUM`, `GROUP BY`. |
| **8** | Recursos nunca prestados | Identificar libros "invisibles" para crear campañas de fomento de lectura. | `NOT IN` / Subconsulta de exclusión. |
| **9** | Promedio de días de préstamo por tipo | Evaluar si las políticas de días de préstamo (ej. estudiantes vs docentes) son óptimas. | `AVG`, `DATEDIFF`, `LEFT JOIN`. |
| **10** | Reservas pendientes (Cola) | Ver el orden de espera de los recursos que actualmente están prestados. | Filtro por estado y `ORDER BY` jerárquico. |

---

## Referencias
- Elmasri, R., & Navathe, S. (2016). *Fundamentals of Database Systems* (7th ed.). Pearson.
- Silberschatz, A., Korth, H., & Sudarshan, S. (2019). *Database System Concepts* (7th ed.). McGraw-Hill.
- Documentación Oficial de MySQL 8.0: https://dev.mysql.com/doc/