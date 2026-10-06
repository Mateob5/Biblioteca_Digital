# Informe de Normalización – Modelo Relacional

## Integrantes
- Jeronimo Andres Mateo Bazan Rojas - 2243590
- Paula Lizeth Ardila Pinzon - 2243586
- Sebastian Andres Baldovino Suarez - 2243565
- Santiago Sepúlveda Blanco - 2243557

---

## Introducción

El presente informe documenta el proceso de normalización aplicado al modelo relacional del **Sistema de Gestión de Bibliotecas Universitarias**. Se partió del modelo E-R de la primera entrega y se aplicaron las formas normales **1FN, 2FN, 3FN, BCNF, 4FN y 5FN**, con el fin de:

- Eliminar redundancias.
- Evitar anomalías de inserción, actualización y eliminación.
- Garantizar la integridad de los datos.
- Facilitar el mantenimiento y la escalabilidad del sistema.

El modelo final está compuesto por **22 tablas** y soporta un entorno **multi-tenant** (varias universidades en una misma plataforma).

---

## Convenciones

| Símbolo | Significado |
|---|---|
| **PK** | Clave primaria |
| **FK** | Clave foránea |
| **UNIQUE** | Valor único |
| **CHECK** | Restricción de dominio |
| **NOT NULL** | Campo obligatorio |
| **DEFAULT** | Valor por defecto |
| **→** | Dependencia funcional |
| **→→** | Dependencia multivaluada |

---

## Primera Forma Normal (1FN)

### Definición
Una tabla está en **1FN** si:
- Todos sus atributos son atómicos.
- No hay grupos repetidos ni campos multivaluados.
- Cada tabla tiene una clave primaria definida.

### Ejemplo antes de 1FN

Se tenía la tabla `recurso` con un campo `autores` que almacenaba varios autores separados por comas:

```sql
recurso(id_recurso, titulo, autores)
```

| id_recurso | titulo | autores |
|---|---|---|
| 1 | Cien años de soledad | García Márquez, Vargas Llosa |
| 2 | La ciudad y los perros | Vargas Llosa |
| 3 | Rayuela | Cortázar, Borges, Sábato |

**Problema:** el campo `autores` es multivaluado, no es atómico y dificulta búsquedas, actualizaciones e integridad.

### Aplicación de 1FN

Se separa el campo multivaluado en una tabla intermedia `recurso_autor` y se crea la tabla `autor`:

```sql
recurso(id_recurso, titulo, ...)
autor(id_autor, nombres, apellidos, ...)
recurso_autor(id_recurso, id_autor, orden)
```

### Ejemplo después de 1FN

**Tabla `recurso`:**

| id_recurso | titulo |
|---|---|
| 1 | Cien años de soledad |
| 2 | La ciudad y los perros |
| 3 | Rayuela |

**Tabla `autor`:**

| id_autor | nombres | apellidos |
|---|---|---|
| 10 | Gabriel | García Márquez |
| 11 | Mario | Vargas Llosa |
| 12 | Julio | Cortázar |
| 13 | Jorge Luis | Borges |
| 14 | Ernesto | Sábato |

**Tabla `recurso_autor`:**

| id_recurso | id_autor | orden |
|---|---|---|
| 1 | 10 | 1 |
| 1 | 11 | 2 |
| 2 | 11 | 1 |
| 3 | 12 | 1 |
| 3 | 13 | 2 |
| 3 | 14 | 3 |

### Conclusión parcial
Todas las tablas del modelo cumplen 1FN.

---

## Segunda Forma Normal (2FN)

### Definición
Una tabla está en **2FN** si:
- Está en 1FN.
- Todos los atributos no clave dependen funcionalmente de la **clave primaria completa**, no de una parte de ella.

### Ejemplo antes de 2FN

Se tenía la tabla `recurso_autor` con un atributo `titulo_recurso` que depende solo de `id_recurso`, no de la clave completa `(id_recurso, id_autor)`:

```sql
recurso_autor(id_recurso, id_autor, titulo_recurso, orden)
```

| id_recurso | id_autor | titulo_recurso | orden |
|---|---|---|---|
| 1 | 10 | Cien años de soledad | 1 |
| 1 | 11 | Cien años de soledad | 2 |
| 3 | 12 | Rayuela | 1 |
| 3 | 13 | Rayuela | 2 |
| 3 | 14 | Rayuela | 3 |

**Problema:** `titulo_recurso` depende solo de `id_recurso`, que es parte de la clave. Hay dependencia parcial.

### Aplicación de 2FN

Se elimina `titulo_recurso` de `recurso_autor` y se deja en `recurso`:

```sql
recurso(id_recurso, titulo, ...)
recurso_autor(id_recurso, id_autor, orden)
```

### Ejemplo después de 2FN

**Tabla `recurso`:**

| id_recurso | titulo |
|---|---|
| 1 | Cien años de soledad |
| 2 | La ciudad y los perros |
| 3 | Rayuela |

**Tabla `recurso_autor`:**

| id_recurso | id_autor | orden |
|---|---|---|
| 1 | 10 | 1 |
| 1 | 11 | 2 |
| 2 | 11 | 1 |
| 3 | 12 | 1 |
| 3 | 13 | 2 |
| 3 | 14 | 3 |

**Ahora `orden` depende de la clave completa `(id_recurso, id_autor)`. No hay dependencias parciales.**

### Conclusión parcial
Todas las tablas del modelo cumplen 2FN.

---

## Tercera Forma Normal (3FN)

### Definición
Una tabla está en **3FN** si:
- Está en 2FN.
- No existen dependencias transitivas, es decir, ningún atributo no clave depende de otro atributo no clave.

### Ejemplo 1 antes de 3FN: `usuario` y `tipo_usuario`

```sql
usuario(id_usuario, nombres, id_tipo_usuario, max_prestamos, dias_prestamo)
```

| id_usuario | nombres | id_tipo_usuario | max_prestamos | dias_prestamo |
|---|---|---|---|---|
| 1 | Ana Gómez | 1 | 3 | 15 |
| 2 | Luis Pérez | 1 | 3 | 15 |
| 3 | Marta Ruiz | 2 | 5 | 30 |
| 4 | Pedro López | 2 | 5 | 30 |

**Problema:** `max_prestamos` y `dias_prestamo` dependen de `id_tipo_usuario`, no directamente de `id_usuario`. Hay dependencia transitiva:
`id_usuario → id_tipo_usuario → max_prestamos, dias_prestamo`.

### Aplicación de 3FN

Se separa `tipo_usuario`:

```sql
usuario(id_usuario, nombres, id_tipo_usuario)
tipo_usuario(id_tipo_usuario, nombre, max_prestamos, dias_prestamo)
```

### Ejemplo después de 3FN

**Tabla `usuario`:**

| id_usuario | nombres | id_tipo_usuario |
|---|---|---|
| 1 | Ana Gómez | 1 |
| 2 | Luis Pérez | 1 |
| 3 | Marta Ruiz | 2 |
| 4 | Pedro López | 2 |

**Tabla `tipo_usuario`:**

| id_tipo_usuario | nombre | max_prestamos | dias_prestamo |
|---|---|---|---|
| 1 | Estudiante | 3 | 15 |
| 2 | Docente | 5 | 30 |

---

### Ejemplo 2 antes de 3FN: `multa`

```sql
multa(id_multa, id_prestamo, id_usuario, monto, motivo)
```

| id_multa | id_prestamo | id_usuario | monto | motivo |
|---|---|---|---|---|
| 1 | 100 | 1 | 5000 | Retraso |
| 2 | 101 | 1 | 3000 | Retraso |
| 3 | 102 | 2 | 7000 | Daño |

**Problema:** `id_usuario` depende de `id_prestamo`, no directamente de `id_multa`. Dependencia transitiva:
`id_multa → id_prestamo → id_usuario`.

### Aplicación de 3FN

Se elimina `id_usuario` de `multa`:

```sql
multa(id_multa, id_prestamo, monto, motivo)
```

### Ejemplo después de 3FN

**Tabla `multa`:**

| id_multa | id_prestamo | monto | motivo |
|---|---|---|---|
| 1 | 100 | 5000 | Retraso |
| 2 | 101 | 3000 | Retraso |
| 3 | 102 | 7000 | Daño |

El usuario se obtiene mediante `prestamo → usuario`.

---

### Ejemplo 3 antes de 3FN: `prestamo`

```sql
prestamo(id_prestamo, id_usuario, id_ejemplar, id_biblioteca, fecha_prestamo)
```

| id_prestamo | id_usuario | id_ejemplar | id_biblioteca | fecha_prestamo |
|---|---|---|---|---|
| 1 | 1 | 500 | 10 | 2025-03-01 |
| 2 | 2 | 501 | 10 | 2025-03-02 |
| 3 | 1 | 500 | 10 | 2025-03-10 |

**Problema:** `id_biblioteca` depende de `id_ejemplar`, no directamente de `id_prestamo`. Dependencia transitiva:
`id_prestamo → id_ejemplar → id_biblioteca`.

### Aplicación de 3FN

Se elimina `id_biblioteca` de `prestamo`. La biblioteca se obtiene vía `ejemplar`:

```sql
prestamo(id_prestamo, id_usuario, id_ejemplar, fecha_prestamo)
ejemplar(id_ejemplar, id_recurso, id_biblioteca, ...)
```

### Ejemplo después de 3FN

**Tabla `prestamo`:**

| id_prestamo | id_usuario | id_ejemplar | fecha_prestamo |
|---|---|---|---|
| 1 | 1 | 500 | 2025-03-01 |
| 2 | 2 | 501 | 2025-03-02 |
| 3 | 1 | 500 | 2025-03-10 |

**Tabla `ejemplar`:**

| id_ejemplar | id_recurso | id_biblioteca |
|---|---|---|
| 500 | 1 | 10 |
| 501 | 2 | 10 |

### Conclusión parcial
Todas las tablas del modelo cumplen 3FN.

---

## Forma Normal de Boyce-Codd (BCNF)

### Definición
Una tabla está en **BCNF** si:
- Está en 3FN.
- Todo determinante es una clave candidata.

### Ejemplo antes de BCNF: `prestamo`

Retomando el caso anterior:

```sql
prestamo(id_prestamo, id_usuario, id_ejemplar, id_biblioteca, fecha_prestamo)
```

| id_prestamo | id_usuario | id_ejemplar | id_biblioteca | fecha_prestamo |
|---|---|---|---|---|
| 1 | 1 | 500 | 10 | 2025-03-01 |
| 2 | 2 | 501 | 10 | 2025-03-02 |
| 3 | 1 | 500 | 10 | 2025-03-10 |

**Problema:** `id_ejemplar → id_biblioteca`, pero `id_ejemplar` **no es clave candidata** de `prestamo`, porque un mismo ejemplar puede tener muchos préstamos a lo largo del tiempo. Por lo tanto, viola BCNF.

### Aplicación de BCNF

Se mueve `id_biblioteca` a `ejemplar`:

```sql
prestamo(id_prestamo, id_usuario, id_ejemplar, fecha_prestamo)
ejemplar(id_ejemplar, id_recurso, id_biblioteca, ...)
```

### Ejemplo después de BCNF

**Tabla `prestamo`:**

| id_prestamo | id_usuario | id_ejemplar | fecha_prestamo |
|---|---|---|---|
| 1 | 1 | 500 | 2025-03-01 |
| 2 | 2 | 501 | 2025-03-02 |
| 3 | 1 | 500 | 2025-03-10 |

**Tabla `ejemplar`:**

| id_ejemplar | id_recurso | id_biblioteca |
|---|---|---|
| 500 | 1 | 10 |
| 501 | 2 | 10 |

**Ahora `id_ejemplar` es clave candidata en `ejemplar` y no hay determinantes que no sean clave candidata en `prestamo`.**

### Conclusión parcial
Todas las tablas del modelo cumplen BCNF.

---

## Cuarta Forma Normal (4FN)

### Definición
Una tabla está en **4FN** si:
- Está en BCNF.
- No tiene dependencias multivaluadas no triviales.

Una **dependencia multivaluada (MVD)** ocurre cuando un atributo determina de forma independiente a dos conjuntos de atributos, generando combinaciones cruzadas innecesarias.

### Ejemplo antes de 4FN: `usuario` con teléfonos y correos

```sql
usuario(id_usuario, nombres, telefono, correo)
```

Supongamos un usuario con:
- 2 teléfonos: `3001234567`, `3109876543`
- 3 correos: `personal@mail.com`, `institucional@uni.edu.co`, `trabajo@empresa.com`

Al almacenar todo en una sola tabla, se generan **6 filas** (2 × 3) por combinación:

| id_usuario | nombres | telefono | correo |
|---|---|---|---|
| 1 | Ana Gómez | 3001234567 | personal@mail.com |
| 1 | Ana Gómez | 3001234567 | institucional@uni.edu.co |
| 1 | Ana Gómez | 3001234567 | trabajo@empresa.com |
| 1 | Ana Gómez | 3109876543 | personal@mail.com |
| 1 | Ana Gómez | 3109876543 | institucional@uni.edu.co |
| 1 | Ana Gómez | 3109876543 | trabajo@empresa.com |

**Problema:** hay redundancia de `nombres` y combinaciones cruzadas entre teléfonos y correos. Existen dos MVD independientes:
- `id_usuario →→ telefono`
- `id_usuario →→ correo`

### Aplicación de 4FN

Se separan los contactos en una tabla `usuario_contacto`:

```sql
usuario(id_usuario, nombres, ...)
usuario_contacto(id_contacto_usr, id_usuario, tipo_contacto, valor, es_principal)
```

### Ejemplo después de 4FN

**Tabla `usuario`:**

| id_usuario | nombres |
|---|---|
| 1 | Ana Gómez |

**Tabla `usuario_contacto`:**

| id_contacto_usr | id_usuario | tipo_contacto | valor | es_principal |
|---|---|---|---|---|
| 1 | 1 | TELEFONO | 3001234567 | TRUE |
| 2 | 1 | TELEFONO | 3109876543 | FALSE |
| 3 | 1 | CORREO | personal@mail.com | TRUE |
| 4 | 1 | CORREO | institucional@uni.edu.co | FALSE |
| 5 | 1 | CORREO | trabajo@empresa.com | FALSE |

**Ahora se almacenan 2 filas para teléfonos y 3 filas para correos, sin combinaciones cruzadas ni redundancia de `nombres`.**

### Otras tablas que aplicaron 4FN

| Tabla original | MVD detectada | Solución aplicada |
|---|---|---|
| `usuario` | `id_usuario →→ telefono`, `id_usuario →→ correo` | `usuario_contacto` |
| `universidad` | `id_universidad →→ telefono`, `id_universidad →→ correo` | `universidad_contacto` |
| `biblioteca` | `id_biblioteca →→ telefono`, `id_biblioteca →→ correo` | `biblioteca_contacto` |
| `editorial` | `id_editorial →→ telefono`, `id_editorial →→ correo` | `editorial_contacto` |
| `autor` | `id_autor →→ nacionalidad` | `autor_nacionalidad` |
| `recurso` | `id_recurso →→ idioma` | `recurso_idioma` |
| `recurso` | `id_recurso →→ (formato, url)` | `recurso_formato_digital` |

### Conclusión parcial
Todas las tablas del modelo cumplen 4FN.

---

## Quinta Forma Normal (5FN)

### Definición
Una tabla está en **5FN** si:
- Está en 4FN.
- No tiene dependencias de reunión (join dependencies) no triviales.

Una **dependencia de reunión** ocurre cuando una tabla puede descomponerse en tres o más tablas que, al reunirse, reproducen exactamente la tabla original, sin que exista una dependencia funcional o multivaluada que lo justifique.

### Ejemplo hipotético antes de 5FN: `proveedor_recurso_biblioteca`

Para ilustrar 5FN, usamos una tabla que mezcla tres relaciones binarias independientes:

```sql
proveedor_recurso_biblioteca(id_proveedor, id_recurso, id_biblioteca)
```

Regla de negocio:
- Un proveedor suministra un recurso.
- Un recurso está disponible en una biblioteca.
- Un proveedor suministra a una biblioteca.
- Si las tres condiciones se cumplen, entonces el proveedor suministra ese recurso a esa biblioteca.

Datos de ejemplo:

| id_proveedor | id_recurso | id_biblioteca |
|---|---|---|
| P1 | R1 | B1 |
| P1 | R1 | B2 |
| P1 | R2 | B1 |
| P2 | R1 | B1 |

Esta tabla tiene una dependencia de reunión:

```text
*{(id_proveedor, id_recurso), (id_recurso, id_biblioteca), (id_proveedor, id_biblioteca)}
```

Es decir, se puede descomponer en tres tablas binarias sin pérdida de información.

### Aplicación de 5FN

Se descompone en tres tablas:

```sql
proveedor_recurso(id_proveedor, id_recurso)
recurso_biblioteca(id_recurso, id_biblioteca)
proveedor_biblioteca(id_proveedor, id_biblioteca)
```

### Ejemplo después de 5FN

**Tabla `proveedor_recurso`:**

| id_proveedor | id_recurso |
|---|---|
| P1 | R1 |
| P1 | R2 |
| P2 | R1 |

**Tabla `recurso_biblioteca`:**

| id_recurso | id_biblioteca |
|---|---|
| R1 | B1 |
| R1 | B2 |
| R2 | B1 |

**Tabla `proveedor_biblioteca`:**

| id_proveedor | id_biblioteca |
|---|---|
| P1 | B1 |
| P1 | B2 |
| P2 | B1 |

Al reunir estas tres tablas se reproduce exactamente la tabla original `proveedor_recurso_biblioteca`, pero ahora sin dependencias de reunión no triviales.

### Aplicación al modelo final

En el modelo del Sistema de Gestión de Bibliotecas Universitarias **no se creó ninguna tabla que mezcle tres relaciones independientes**. Por el contrario, se separaron:

- `recurso_autor(id_recurso, id_autor, orden)`
- `recurso_idioma(id_recurso_idioma, id_recurso, idioma, es_principal)`
- `recurso_formato_digital(id_formato, id_recurso, formato, url, tamano_mb)`
- `usuario_contacto`, `universidad_contacto`, `biblioteca_contacto`, `editorial_contacto`
- `autor_nacionalidad`

Ninguna de estas tablas presenta dependencias de reunión no triviales. Por lo tanto, **todas cumplen 5FN**.

### Conclusión parcial
Todas las tablas del modelo cumplen 5FN.

---

## Resumen de cambios respecto al modelo E-R inicial

| Cambio | Justificación | Forma normal |
|---|---|---|
| Se agregó `tipo_usuario` | Parametrizar préstamos, renovaciones y reservas según el tipo de usuario | 3FN |
| Se separó `devolucion` de `prestamo` | Registrar datos propios de la devolución (estado del ejemplar, biblioteca que recibe) | 3FN |
| Se creó `recurso_autor` | Normalizar la relación muchos-a-muchos entre recurso y autor | 1FN y 2FN |
| Se eliminó `id_usuario` en `multa` | Evitar dependencia transitiva; se obtiene vía `prestamo` | 3FN |
| Se eliminó `id_biblioteca` en `prestamo` | Evitar dependencia transitiva; se obtiene vía `ejemplar` | 3FN y BCNF |
| Se agregó `id_universidad` en `recurso` | Soportar el enfoque multi-tenant | Diseño |
| Se agregó `rfid` en `ejemplar` | Permitir autopréstamo y autorenovación | Diseño |
| Se agregó `posicion_cola` en `reserva` | Gestionar colas de reserva | Diseño |
| Se agregó `fecha_expiracion` en `reserva` | Controlar expiración automática de reservas | Diseño |
| Se crearon tablas `*_contacto` | Resolver dependencias multivaluadas | 4FN |
| Se creó `autor_nacionalidad` | Permitir múltiples nacionalidades por autor | 4FN |
| Se creó `recurso_idioma` | Permitir múltiples idiomas por recurso | 4FN |
| Se creó `recurso_formato_digital` | Permitir múltiples formatos digitales por recurso | 4FN |
| Se evitó crear tablas ternarias con relaciones independientes | Prevenir dependencias de reunión | 5FN |

---

## Conclusión

El modelo relacional del **Sistema de Gestión de Bibliotecas Universitarias** cumple con las formas normales **1FN, 2FN, 3FN, BCNF, 4FN y 5FN**. Se eliminaron redundancias, dependencias parciales, dependencias transitivas, dependencias multivaluadas y dependencias de reunión. Se garantizó la integridad referencial mediante claves primarias y foráneas.

El modelo está preparado para soportar un entorno **multi-tenant**, con gestión de múltiples universidades, bibliotecas, usuarios, recursos, ejemplares, préstamos, renovaciones, reservas, devoluciones y multas.

---

## Referencias

- Elmasri, R., & Navathe, S. (2016). *Fundamentals of Database Systems* (7th ed.). Pearson.
- Silberschatz, A., Korth, H., & Sudarshan, S. (2019). *Database System Concepts* (7th ed.). McGraw-Hill.
- Date, C. J. (2003). *An Introduction to Database Systems* (8th ed.). Addison-Wesley.
- Fagin, R. (1977). *Multivalued Dependencies and a New Normal Form for Relational Databases*. ACM Transactions on Database Systems.