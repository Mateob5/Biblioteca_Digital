-- Consulta 1: Top 5 de recursos más prestados
SELECT r.titulo,
       COUNT(p.id_prestamo) AS total_prestamos
FROM prestamo p
JOIN ejemplar e ON e.id_ejemplar = p.id_ejemplar
JOIN recurso r  ON r.id_recurso = e.id_recurso
GROUP BY r.titulo
ORDER BY total_prestamos DESC, r.titulo
LIMIT 5;

-- Consulta 2: Usuarios con multas pendientes y monto total adeudado
SELECT u.id_usuario,
       u.documento,
       CONCAT(u.nombres, ' ', u.apellidos) AS usuario,
       COUNT(m.id_multa)                   AS multas_pendientes,
       SUM(m.monto)                        AS monto_total_adeudado
FROM multa m
JOIN prestamo p ON p.id_prestamo = m.id_prestamo
JOIN usuario u  ON u.id_usuario = p.id_usuario
WHERE m.estado = 'PENDIENTE'
GROUP BY u.id_usuario, u.documento, u.nombres, u.apellidos
ORDER BY monto_total_adeudado DESC;

-- Consulta 3: Disponibilidad de ejemplares por biblioteca
SELECT un.nombre AS universidad,
       b.nombre  AS biblioteca,
       COUNT(e.id_ejemplar) AS total_ejemplares,
       SUM(CASE WHEN e.estado = 'DISPONIBLE' THEN 1 ELSE 0 END) AS ejemplares_disponibles,
       IFNULL(ROUND(100 * SUM(CASE WHEN e.estado = 'DISPONIBLE' THEN 1 ELSE 0 END)
                    / NULLIF(COUNT(e.id_ejemplar), 0), 1), 0) AS pct_disponible
FROM biblioteca b
JOIN universidad un  ON un.id_universidad = b.id_universidad
LEFT JOIN ejemplar e ON e.id_biblioteca = b.id_biblioteca
GROUP BY un.nombre, b.id_biblioteca, b.nombre
ORDER BY ejemplares_disponibles DESC, b.nombre;

-- Consulta 4: Préstamos activos que vencen en los próximos 3 días
SELECT p.id_prestamo,
       CONCAT(u.nombres, ' ', u.apellidos)           AS usuario,
       r.titulo,
       b.nombre                                      AS biblioteca,
       p.fecha_vencimiento,
       DATEDIFF(p.fecha_vencimiento, CURDATE())      AS dias_restantes
FROM prestamo p
JOIN usuario u    ON u.id_usuario = p.id_usuario
JOIN ejemplar e   ON e.id_ejemplar = p.id_ejemplar
JOIN recurso r    ON r.id_recurso = e.id_recurso
JOIN biblioteca b ON b.id_biblioteca = e.id_biblioteca
WHERE p.estado IN ('ACTIVO', 'RENOVADO')
  AND DATEDIFF(p.fecha_vencimiento, CURDATE()) BETWEEN 0 AND 3
  AND NOT EXISTS (SELECT 1 FROM devolucion d WHERE d.id_prestamo = p.id_prestamo)
ORDER BY p.fecha_vencimiento;

-- Consulta 5: Autores con mayor cantidad de libros en el catálogo
SELECT a.id_autor,
       CONCAT(a.nombres, ' ', a.apellidos)                    AS autor,
       COUNT(ra.id_recurso)                                   AS total_libros,
       GROUP_CONCAT(r.titulo ORDER BY r.titulo SEPARATOR '; ') AS titulos
FROM autor a
JOIN recurso_autor ra ON ra.id_autor = a.id_autor
JOIN recurso r        ON r.id_recurso = ra.id_recurso
GROUP BY a.id_autor, a.nombres, a.apellidos
ORDER BY total_libros DESC, autor
LIMIT 5;

-- Consulta 6: Historial completo de préstamos del usuario con documento '1098765432'
SELECT p.id_prestamo,
       r.titulo,
       e.codigo_barras,
       b.nombre                AS biblioteca,
       p.fecha_prestamo,
       p.fecha_vencimiento,
       d.fecha_devolucion,
       p.estado                AS estado_prestamo,
       d.estado_ejemplar,
       (SELECT COUNT(*) FROM renovacion rn WHERE rn.id_prestamo = p.id_prestamo) AS renovaciones,
       GREATEST(0, DATEDIFF(IFNULL(d.fecha_devolucion, NOW()), p.fecha_vencimiento)) AS dias_retraso,
       (SELECT IFNULL(SUM(m.monto), 0)
        FROM multa m
        WHERE m.id_prestamo = p.id_prestamo
          AND m.estado NOT IN ('ANULADA', 'CONDONADA')) AS multas_exigibles
FROM usuario u
JOIN prestamo p   ON p.id_usuario = u.id_usuario
JOIN ejemplar e   ON e.id_ejemplar = p.id_ejemplar
JOIN recurso r    ON r.id_recurso = e.id_recurso
JOIN biblioteca b ON b.id_biblioteca = e.id_biblioteca
LEFT JOIN devolucion d ON d.id_prestamo = p.id_prestamo
WHERE u.documento = '1098765432'
ORDER BY p.fecha_prestamo DESC;

-- Consulta 7: Total recaudado por multas pagadas agrupado por universidad
SELECT un.id_universidad,
       un.nombre                AS universidad,
       COUNT(m.id_multa)        AS multas_pagadas,
       IFNULL(SUM(m.monto), 0)  AS total_recaudado
FROM universidad un
LEFT JOIN usuario u  ON u.id_universidad = un.id_universidad
LEFT JOIN prestamo p ON p.id_usuario = u.id_usuario
LEFT JOIN multa m    ON m.id_prestamo = p.id_prestamo AND m.estado = 'PAGADA'
GROUP BY un.id_universidad, un.nombre
ORDER BY total_recaudado DESC, un.nombre;

-- Consulta 8: Recursos que nunca han sido prestados
SELECT r.id_recurso,
       r.titulo,
       r.tipo_recurso,
       un.nombre            AS universidad,
       COUNT(e.id_ejemplar) AS ejemplares_registrados
FROM recurso r
JOIN universidad un ON un.id_universidad = r.id_universidad
LEFT JOIN (SELECT DISTINCT id_ejemplar FROM prestamo) AS prestados_ej ON 1 = 0
LEFT JOIN ejemplar e ON e.id_recurso = r.id_recurso
WHERE r.id_recurso NOT IN (
    SELECT e2.id_recurso
    FROM ejemplar e2
    JOIN prestamo p ON p.id_ejemplar = e2.id_ejemplar
)
GROUP BY r.id_recurso, r.titulo, r.tipo_recurso, un.nombre
ORDER BY un.nombre, r.titulo;

-- Consulta 9: Promedio de días de préstamo por tipo de usuario
SELECT tu.nombre                                                       AS tipo_usuario,
       tu.dias_prestamo                                                AS dias_permitidos,
       COUNT(p.id_prestamo)                                            AS total_prestamos,
       IFNULL(ROUND(AVG(DATEDIFF(p.fecha_vencimiento, p.fecha_prestamo)), 1), 0) AS promedio_dias_prestamo
FROM tipo_usuario tu
LEFT JOIN usuario u  ON u.id_tipo_usuario = tu.id_tipo_usuario
LEFT JOIN prestamo p ON p.id_usuario = u.id_usuario
GROUP BY tu.id_tipo_usuario, tu.nombre, tu.dias_prestamo
ORDER BY promedio_dias_prestamo DESC;

-- Consulta 10: Reservas pendientes ordenadas por posición en la cola
SELECT rs.posicion_cola,
       CONCAT(u.nombres, ' ', u.apellidos) AS usuario,
       r.titulo,
       b.nombre                            AS biblioteca,
       rs.fecha_reserva,
       rs.fecha_expiracion
FROM reserva rs
JOIN usuario u    ON u.id_usuario = rs.id_usuario
JOIN recurso r    ON r.id_recurso = rs.id_recurso
JOIN biblioteca b ON b.id_biblioteca = rs.id_biblioteca
WHERE rs.estado = 'PENDIENTE'
ORDER BY rs.posicion_cola, rs.fecha_reserva;