-- ============================================================
-- ASSETCONTROL | ESTUDIANTES - ESPACIOS PARA RESOLVER
-- Archivo 02/02 - 20 ejercicios DQL
-- Base de datos: assetcontrol
-- Instrucciones: ejecutar primero el archivo 01_base_datos.sql.
-- Consultas 18, 19 y 20: obligatoriamente con subconsultas.
-- No modificar los datos semilla durante esta evaluacion.
-- Alias y etiquetas visibles al cliente pueden estar en espanol.
-- ============================================================

USE assetcontrol;

-- EJEMPLO DE CLASE (no calificable)
SELECT
    a.id AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    a.status AS estado
FROM assets AS a;


-- ------------------------------------------------------------
-- 01. Mostrar el código, marca, modelo y estado de todos los activos, como se trabajó en clase.
-- Escribe tu SELECT aqui:
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    a.status AS estado
FROM assets AS a
    ORDER BY a.patrimonial_identifier;




-- ------------------------------------------------------------
-- 02. Mostrar cada equipo junto con el nombre de su tipo. Usar alias a y at y un JOIN.
-- Escribe tu SELECT aqui:
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    at.name AS tipo_equipo,
    a.status AS estado
FROM assets AS a
JOIN asset_types AS at ON a.asset_type_id = at.id
WHERE a.status = 'DISPONIBLE'
    AND (at.name = 'Portátil' OR at.name = 'Proyector')
ORDER BY a.patrimonial_identifier;

-- ------------------------------------------------------------
-- 03. Filtrar los equipos DISPONIBLES que sean de tipo Portátil o Proyector.
-- Escribe tu SELECT aqui:
SELECT
    e.employee_code AS codigo_empleado,
    e.name AS empleado,
    d.name AS departamento,
    e.status AS estado
FROM employees AS e
JOIN departments AS d ON e.department_id = d.id
WHERE e.status = 'ACTIVO'
    AND d.name = 'Tecnología'
ORDER BY e.employee_code;




-- 04. Los tres equipos adquiridos más recientemente
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    a.purchase_date AS fecha_compra
FROM assets AS a
ORDER BY a.purchase_date DESC, a.patrimonial_identifier
LIMIT 3;

-- 05. Equipos cuya marca comienza por D o L
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo
FROM assets AS a
WHERE a.brand LIKE 'D%' OR a.brand LIKE 'L%'
ORDER BY a.brand, a.patrimonial_identifier;

-- 06. Equipos con su sede administrativa y su tipo
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    s.name AS sede,
    at.name AS tipo_equipo
FROM assets AS a
JOIN sites AS s ON a.site_id = s.id
JOIN asset_types AS at ON a.asset_type_id = at.id
ORDER BY a.patrimonial_identifier;

-- 07. Custodias activas, empleado y equipo
SELECT
    asg.id AS codigo_asignacion,
    e.name AS empleado,
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    asg.started_at AS fecha_inicio
FROM assignments AS asg
JOIN employees AS e ON asg.employee_id = e.id
JOIN assets AS a ON asg.asset_id = a.id
WHERE asg.return_date IS NULL
ORDER BY asg.id;

-- 08. Todos los equipos con cantidad de asignaciones históricas
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    COUNT(asg.id) AS total_asignaciones
FROM assets AS a
LEFT JOIN assignments AS asg ON a.id = asg.asset_id
GROUP BY a.id, a.patrimonial_identifier, a.brand, a.model
ORDER BY total_asignaciones DESC, a.patrimonial_identifier;

-- 09. Cantidad de equipos por estado
SELECT
    a.status AS estado,
    COUNT(*) AS total_equipos
FROM assets AS a
GROUP BY a.status
ORDER BY total_equipos DESC, a.status;

-- 10. Sedes responsables de al menos dos equipos
SELECT
    s.name AS sede,
    COUNT(a.id) AS total_equipos
FROM sites AS s
JOIN assets AS a ON s.id = a.site_id
GROUP BY s.id, s.name
HAVING COUNT(a.id) >= 2
ORDER BY total_equipos DESC, s.name;

-- 11. Costo total de mantenimientos por tipo
SELECT
    m.type AS tipo_mantenimiento,
    SUM(m.cost) AS costo_total
FROM maintenance AS m
GROUP BY m.type
ORDER BY costo_total DESC, m.type;

-- 12. Equipos en mantenimiento y detalle de su mantenimiento abierto
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    m.type AS tipo_mantenimiento,
    m.started_at AS fecha_inicio,
    m.description AS descripcion,
    m.cost AS costo
FROM assets AS a
JOIN maintenance AS m ON a.id = m.asset_id
WHERE a.status = 'MANTENIMIENTO'
    AND m.ended_at IS NULL
ORDER BY a.patrimonial_identifier;

-- 13. Mantenimientos que costaron entre 80000 y 250000
SELECT
    m.id AS codigo_mantenimiento,
    m.asset_id AS codigo_equipo,
    m.description AS descripcion,
    m.cost AS costo
FROM maintenance AS m
WHERE m.cost BETWEEN 80000 AND 250000
ORDER BY m.cost, m.id;

-- 14. Empleados con custodia activa y su departamento
SELECT DISTINCT
    e.employee_code AS codigo_empleado,
    e.name AS empleado,
    d.name AS departamento
FROM employees AS e
JOIN departments AS d ON e.department_id = d.id
JOIN assignments AS asg ON e.id = asg.employee_id
WHERE asg.return_date IS NULL
ORDER BY e.employee_code;

-- 15. Departamentos y cantidad de empleados, incluso si son cero
SELECT
    d.id AS codigo_departamento,
    d.name AS departamento,
    COUNT(e.id) AS total_empleados
FROM departments AS d
LEFT JOIN employees AS e ON d.id = e.department_id
GROUP BY d.id, d.name
ORDER BY total_empleados DESC, d.id;

-- 16. Equipos con dos o más mantenimientos
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    COUNT(m.id) AS total_mantenimientos
FROM assets AS a
JOIN maintenance AS m ON a.id = m.asset_id
GROUP BY a.id, a.patrimonial_identifier, a.brand, a.model
HAVING COUNT(m.id) >= 2
ORDER BY total_mantenimientos DESC, a.patrimonial_identifier;

-- 17. Asignaciones devueltas y días enteros de custodia
SELECT
    asg.id AS codigo_asignacion,
    e.name AS empleado,
    a.patrimonial_identifier AS codigo_activo,
    asg.started_at AS fecha_inicio,
    asg.return_date AS fecha_devolucion,
    TIMESTAMPDIFF(DAY, asg.started_at, asg.return_date) AS dias_custodia
FROM assignments AS asg
JOIN employees AS e ON asg.employee_id = e.id
JOIN assets AS a ON asg.asset_id = a.id
WHERE asg.return_date IS NOT NULL
ORDER BY asg.id;

-- 18. SUBCONSULTA: equipos con costo acumulado de mantenimiento superior
--     al promedio del costo acumulado por equipo (solo equipos con mantenimiento)
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo,
    SUM(m.cost) AS costo_acumulado
FROM assets AS a
JOIN maintenance AS m ON a.id = m.asset_id
GROUP BY a.id, a.patrimonial_identifier, a.brand, a.model
HAVING SUM(m.cost) > (
    SELECT AVG(t.total_equipo)
    FROM (
        SELECT SUM(cost) AS total_equipo
        FROM maintenance
        GROUP BY asset_id
    ) AS t
)
ORDER BY costo_acumulado DESC, a.patrimonial_identifier;

-- 19. SUBCONSULTA: empleados sin ninguna asignación histórica
SELECT
    e.employee_code AS codigo_empleado,
    e.name AS empleado
FROM employees AS e
WHERE NOT EXISTS (
    SELECT 1
    FROM assignments AS asg
    WHERE asg.employee_id = e.id
)
ORDER BY e.employee_code;

-- 20. SUBCONSULTA: equipos con algún mantenimiento individual mayor al promedio
--     de todos los mantenimientos (sin duplicados)
SELECT
    a.patrimonial_identifier AS codigo_activo,
    a.brand AS marca,
    a.model AS modelo
FROM assets AS a
WHERE a.id IN (
    SELECT m.asset_id
    FROM maintenance AS m
    WHERE m.cost > (SELECT AVG(cost) FROM maintenance)
)
ORDER BY a.patrimonial_identifier;