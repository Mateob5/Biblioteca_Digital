# Modelo Relacional – Sistema de Gestión de Bibliotecas Universitarias

## Integrantes
- Jeronimo Andres Mateo Bazan Rojas - 2243590
- Paula Lizeth Ardila Pinzon - 2243586
- Sebastian Andres Baldovino Suarez - 2243565
- Santiago Sepúlveda Blanco - 2243557

---

## Descripción de la carpeta

Esta carpeta contiene la **Segunda Entrega Parcial** del proyecto: el **modelo relacional normalizado** del Sistema de Gestión de Bibliotecas Universitarias, elaborado a partir del modelo E-R de la primera entrega.

El modelo fue diseñado para soportar un entorno **multi-tenant** (varias universidades en una misma plataforma), con gestión de bibliotecas, usuarios, recursos bibliográficos, ejemplares, préstamos, renovaciones, reservas, devoluciones y multas.

La normalización se llevó hasta **Quinta Forma Normal (5FN)**, garantizando que no existan dependencias funcionales indebidas, dependencias multivaluadas ni dependencias de reunión.

---

## Contenido de la carpeta

| Archivo | Descripción |
|---|---|
| [`ModeloRelacionalBibliotecaDigital.png`](./ModeloRelacionalBibliotecaDigital.png) | Diagrama visual del modelo relacional. Exportado desde Mermaid, dbdiagram.io o draw.io. Muestra las tablas, claves primarias, claves foráneas y relaciones. |
| [`informe_normalizacion.md`](./informe_normalizacion.md) | Informe detallado del proceso de normalización: 1FN, 2FN, 3FN, BCNF, 4FN y 5FN. Explica los cambios realizados respecto al modelo E-R inicial y justifica cada decisión. |
| [`diccionario_datos.md`](./diccionario_datos.md) | Diccionario de datos con el dominio o tipo de dato permitido en cada columna de cada tabla. Incluye restricciones y descripción de cada campo. |

---

## Enlaces directos

- [Ver diagrama relacional](./ModeloRelacionalBibliotecaDigital.png)
- [Ver informe de normalización](./informe_normalizacion.md)
- [Ver diccionario de datos](./diccionario_datos.md)

---

## Estructura del modelo relacional

El modelo está compuesto por **22 tablas** organizadas en cinco grandes bloques:

### 1. Bloque institucional (multi-tenant)
- `universidad`: institución dueña de una o más bibliotecas.
- `universidad_contacto`: contactos múltiples (teléfono, correo, web) de la universidad.
- `biblioteca`: sede física donde se almacenan ejemplares.
- `biblioteca_contacto`: contactos múltiples de la biblioteca.
- `tipo_usuario`: parametriza reglas de préstamo, renovación y reserva.

### 2. Bloque de usuarios
- `usuario`: estudiantes, docentes y personal administrativo.
- `usuario_contacto`: contactos múltiples del usuario.

### 3. Bloque de recursos bibliográficos
- `recurso`: libro, revista, tesis, audiovisual o digital.
- `categoria`: clasificación temática.
- `editorial`: empresa publicadora.
- `editorial_contacto`: contactos múltiples de la editorial.
- `autor`: persona que escribe un recurso.
- `autor_nacionalidad`: nacionalidades múltiples del autor.
- `recurso_autor`: tabla intermedia muchos-a-muchos entre recurso y autor.
- `recurso_idioma`: idiomas múltiples en que está disponible un recurso.
- `recurso_formato_digital`: formatos digitales múltiples con su URL.
- `ejemplar`: copia física o digital de un recurso.

### 4. Bloque transaccional
- `prestamo`: retiro de un ejemplar por un usuario.
- `renovacion`: extensión del préstamo.
- `devolucion`: entrega del ejemplar.
- `reserva`: apartado de un recurso no disponible.
- `multa`: cargo por retraso o daño.

---

## Decisiones de diseño clave

1. **Multi-tenant:** `id_universidad` aparece en `universidad`, `biblioteca`, `usuario` y `recurso`. Esto permite que varias universidades usen la misma plataforma con datos aislados.
2. **Normalización hasta 5FN:** Se eliminaron dependencias transitivas, multivaluadas y de reunión. Por ejemplo:
   - `multa` no guarda `id_usuario`; se obtiene vía `prestamo`.
   - `prestamo` no guarda `id_biblioteca`; se obtiene vía `ejemplar`.
   - Los contactos múltiples se separaron en tablas `*_contacto`.
   - Los idiomas y formatos digitales se separaron en `recurso_idioma` y `recurso_formato_digital`.
3. **Tabla intermedia `recurso_autor`:** Resuelve la relación muchos-a-muchos entre recursos y autores, con atributo `orden`.
4. **Separación de `tipo_usuario`:** Evita repetir reglas de préstamo en cada usuario.
5. **`rfid` en `ejemplar`:** Habilita autopréstamo y autorenovación.
6. **`posicion_cola` en `reserva`:** Gestiona colas de reserva.
7. **`devolucion` separada de `prestamo`:** Registra estado del ejemplar y biblioteca que recibe.

---

## Referencias

- Elmasri, R., & Navathe, S. (2016). *Fundamentals of Database Systems* (7th ed.). Pearson.
- Silberschatz, A., Korth, H., & Sudarshan, S. (2019). *Database System Concepts* (7th ed.). McGraw-Hill.
- Date, C. J. (2003). *An Introduction to Database Systems* (8th ed.). Addison-Wesley.
- Documentación de Mermaid: https://mermaid.js.org/
- Documentación de draw.io: https://www.diagrams.net/
