# Sistema de Gestión de Bibliotecas Universitarias
## Integrantes: Jeronimo Andres Mateo Bazan Rojas - 2243590, Paula Lizeth Ardila Pinzon - 2243586, Sebastian Andres Baldovino Suarez - 2243565, Santiago Sepúlveda Blanco - 2243557.
## 1. Definiciones relevantes
### Biblioteca
Es la unidad donde se administran y prestan los recursos bibliográficos. Una universidad puede tener una o varias bibliotecas.
### Universidad
Institución educativa a la que pertenece una o más bibliotecas dentro de la plataforma.
### Usuario
Persona registrada en el sistema que puede consultar, reservar y solicitar préstamos de los recursos. Puede ser estudiante, docente o personal administrativo.
### Recurso bibliográfico
Cualquier material disponible para consulta o préstamo, como libros, revistas, periódicos, tesis o material audiovisual.
### Ejemplar
Es una copia física o digital de un recurso bibliográfico. Un mismo libro puede tener varios ejemplares disponibles.
### Catálogo
Conjunto organizado de todos los recursos registrados en la biblioteca, con información como título, autor, editorial, categoría e ISBN.
### Préstamo
Proceso mediante el cual un usuario retira un ejemplar por un tiempo determinado.
### Renovación
Extensión del período de préstamo de un recurso, siempre que no existan restricciones como reservas pendientes.
### Auto renovación
Proceso automático que renueva un préstamo cuando se cumplen las condiciones establecidas por la biblioteca.
### Reserva
Solicitud realizada por un usuario para apartar un recurso que no se encuentra disponible en ese momento.
### Devolución
Proceso mediante el cual el usuario entrega nuevamente el ejemplar prestado a la biblioteca.
### Multa
Cargo aplicado cuando un recurso es devuelto después de la fecha límite de préstamo.
---
## 2. Tendencias actuales en dichos conceptos
### Bibliotecas digitales
Las universidades están ampliando el acceso a libros electrónicos, revistas científicas y otros recursos digitales, permitiendo que los usuarios consulten el material desde cualquier lugar y dispositivo.
### Automatización de préstamos y renovaciones
Los sistemas modernos automatizan procesos como préstamos, devoluciones, renovaciones y reservas, reduciendo el trabajo manual del personal y mejorando la experiencia de los usuarios.
### Integración con sistemas académicos
Los sistemas de bibliotecas se conectan con plataformas institucionales, como sistemas de matrícula o gestión académica, para sincronizar usuarios, permisos y servicios de manera automática.
### Inteligencia Artificial y recomendaciones
La IA se utiliza para recomendar libros y recursos según el historial de préstamos, intereses o programas académicos de cada usuario, facilitando el descubrimiento de contenido relevante.
### Identificación mediante RFID y códigos QR
Muchas bibliotecas implementan tecnologías como RFID o códigos QR para agilizar el préstamo, devolución e inventario de los ejemplares, mejorando la eficiencia en la gestión de los recursos.
---
## 3. Herramientas existentes en el mercado
### Koha
Koha es un sistema de gestión bibliotecaria de código abierto utilizado por universidades, colegios y bibliotecas de todo el mundo. Permite administrar el catálogo de libros y otros recursos, controlar préstamos, devoluciones, reservas y renovaciones, además de gestionar usuarios y generar reportes. Al ser un software libre, puede adaptarse a las necesidades de cada institución y cuenta con una amplia comunidad que contribuye a su desarrollo.
### Alma
Alma es una plataforma comercial de gestión bibliotecaria desarrollada por Ex Libris, diseñada principalmente para bibliotecas universitarias y de investigación. Centraliza la administración de recursos físicos y digitales, automatiza procesos como préstamos, reservas y renovaciones, y facilita la integración con otros sistemas académicos. Su enfoque en la nube y sus herramientas de análisis la convierten en una solución robusta para instituciones con grandes volúmenes de información.


# Primera Entrega Bases de Datos Relacionales

## 1. Contexto del problema trabajado en la actividad de exploración

Las bibliotecas universitarias hoy en día se enfrentan al reto de administrar una enorme cantidad de recursos: libros, revistas, tesis y material digital para miles de usuarios distintos, como: estudiantes, profesores y personal administrativo, todo mientras intentan que los procesos de préstamo, devolución, reserva y renovación no se vuelvan un caos burocrático. El problema radica en que muchas instituciones siguen dependiendo de sistemas desactualizados o procesos manuales que no solo generan retrasos y errores, sino que tampoco se integran bien con las plataformas académicas ni aprovechan tecnologías modernas como la inteligencia artificial, los códigos QR o el acceso remoto. Por eso, la actividad de exploración consiste en analizar a fondo estas necesidades reales, entender qué funciona y qué falla en las herramientas actuales del mercado, y definir desde cero los requisitos de un sistema de gestión que realmente facilite la vida de quienes usan y administran la biblioteca universitaria.


## 2. Consulta de tendencias actuales en el área del proyecto

### 1. Automatización de procesos
La tecnología RFID permite el autopréstamo y la autorenovación de materiales, eliminando la intervención del personal bibliotecario. Este modelo ha alcanzado tasas de uso superiores al 80% en sistemas ya implementados.

### 2. Migración a la nube
Los sistemas tradicionales (ILS) están siendo reemplazados por Plataformas de Servicios Bibliotecarios (LSP) basadas en la nube. **FOLIO**, de código abierto y arquitectura modular, permite personalizar funcionalidades sin depender de un único proveedor.

### 3. Gestión de recursos diversos
La plataforma debe administrar libros, revistas, periódicos, materiales audiovisuales y contenido en streaming. Cada tipo de recurso requiere reglas de préstamo, acceso y renovación diferenciadas.

### 4. Integración de inteligencia artificial
Los asistentes de investigación con IA mejoran la experiencia de búsqueda y descubrimiento. El personal bibliotecario debe desarrollar competencias técnicas, como el manejo de Python, para interactuar con estas herramientas.


## 3. Consulta de herramientas o sistemas similares con su análisis de funcionalidades
### Sistemas Similares y sus Funcionalidades

| Sistema               | Tipo             | Funcionalidades Clave                                                                                           |
| --------------------- | ---------------- | --------------------------------------------------------------------------------------------------------------- |
| **Alma (Ex Libris)**  | Comercial / Nube | Gestión académica completa, reservas, auto-renovación, IA para metadatos, integración con LMS universitario.    |
| **Koha**              | Código abierto   | Préstamo, catálogo, reservas, renovaciones, soporte MARC, multi-sede, usado por universidades de todo el mundo. |
| **Evergreen**         | Código abierto   | Diseñado para consorcios multi-universidad, catálogo compartido, colas de reserva centralizadas.                |
| **FOLIO (EBSCO)**     | Código abierto   | Arquitectura moderna, microservicios, gestión de préstamos, reservas, integración con ERP universitario.        |
| **WorldShare (OCLC)** | Comercial / Nube | Basado en WorldCat, análisis con IA, gestión de recursos electrónicos y físicos.                                |

### Tecnologías de Base de Datos Recomendadas

| Tecnología        | Uso                                                                                       |
| ----------------- | ----------------------------------------------------------------------------------------- |
| **PostgreSQL**    | Base relacional principal (transacciones ACID, búsqueda full-text, soporte multi-tenant). |
| **Redis**         | Caché para disponibilidad en tiempo real y colas de reservas.                             |
| **Elasticsearch** | Motor de búsqueda para el catálogo en línea (OPAC).                                       |

### Patrón de Diseño Clave

Para **varias universidades** en una sola plataforma: arquitectura **multi-tenant** (base de datos compartida con separación por `university_id` o esquemas separados), permitiendo que cada universidad gestione sus propios recursos, préstamos, reservas y auto-renovaciones de forma aislada pero centralizada.         
