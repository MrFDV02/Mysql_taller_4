-- ============================================================
-- TALENTTRACK | ESTUDIANTES - ESPACIOS PARA RESOLVER
-- Archivo 02/02 - 20 ejercicios DQL
-- Base de datos: talenttrack
-- Instrucciones: ejecutar primero el archivo 01_base_datos.sql.
-- Consultas 18, 19 y 20: obligatoriamente con subconsultas.
-- No modificar los datos semilla durante esta evaluacion.
-- Alias y etiquetas visibles al cliente pueden estar en espanol.
-- ============================================================

USE talenttrack;

-- EJEMPLO DE CLASE (no calificable)
SELECT
    c.id AS codigo_curso,
    c.name AS curso,
    c.duration_hours AS horas
FROM courses AS c;


-- ------------------------------------------------------------
-- 01. Mostrar código, nombre y duración en horas de todos los cursos.
-- Escribe tu SELECT aqui:
SELECT
    c.code AS codigo_curso,
    c.name AS curso,
    c.duration_hours AS horas
FROM courses AS c
ORDER BY c.code;


-- ------------------------------------------------------------
-- 02. Listar ediciones en estado ABIERTA o EN_CURSO cuya fecha de inicio sea desde septiembre de 2026.
-- Escribe tu SELECT aqui:
SELECT
    ed.code AS codigo_edicion,
    ed.start_date AS fecha_inicio,
    ed.status AS estado
FROM editions AS ed
WHERE (ed.status = 'ABIERTA' OR ed.status = 'EN_CURSO')
    AND ed.start_date >= '2026-09-01'
ORDER BY ed.start_date, ed.code;


-- ------------------------------------------------------------
-- 03. Mostrar colaboradores ACTIVO de empresas cuyo nombre contenga SAS. Usar JOIN y LIKE.
-- Escribe tu SELECT aqui:
SELECT
    co.name AS colaborador,
    cm.company_name AS empresa,
    co.status AS estado
FROM collaborators AS co
JOIN companies AS cm ON co.company_id = cm.id
WHERE co.status = 'ACTIVO'
    AND cm.company_name LIKE '%SAS%'
ORDER BY co.id;


-- ------------------------------------------------------------
-- 04. Mostrar las tres ediciones con fecha de inicio más reciente. Usar LIMIT.
-- Escribe tu SELECT aqui:
SELECT
    ed.code AS codigo_edicion,
    ed.start_date AS fecha_inicio,
    ed.status AS estado
FROM editions AS ed
ORDER BY ed.start_date DESC, ed.code
LIMIT 3;


-- ------------------------------------------------------------
-- 05. Buscar cursos cuyo nombre incluya IA o datos. Usar LIKE y OR.
-- Escribe tu SELECT aqui:
SELECT
    c.code AS codigo_curso,
    c.name AS curso
FROM courses AS c
WHERE c.name LIKE '%IA%' OR c.name LIKE '%datos%'
ORDER BY c.code;


-- ------------------------------------------------------------
-- 06. Mostrar cada edición junto con el nombre del curso y el instructor que la imparte.
-- Escribe tu SELECT aqui:
SELECT
    ed.code AS codigo_edicion,
    c.name AS curso,
    i.name AS instructor
FROM editions AS ed
JOIN courses AS c ON ed.course_id = c.id
JOIN instructors AS i ON ed.instructor_id = i.id
ORDER BY ed.code;


-- ------------------------------------------------------------
-- 07. Relacionar cada matrícula con colaborador, empresa y edición.
-- Escribe tu SELECT aqui:
SELECT
    en.id AS codigo_matricula,
    co.name AS colaborador,
    cm.company_name AS empresa,
    ed.code AS edicion
FROM enrollments AS en
JOIN collaborators AS co ON en.collaborator_id = co.id
JOIN companies AS cm ON co.company_id = cm.id
JOIN editions AS ed ON en.edition_id = ed.id
ORDER BY en.id;


-- ------------------------------------------------------------
-- 08. Contar los matriculados por edición, incluyendo ediciones sin inscritos. Usar LEFT JOIN.
-- Escribe tu SELECT aqui:
SELECT
    ed.code AS codigo_edicion,
    COUNT(en.id) AS total_matriculados
FROM editions AS ed
LEFT JOIN enrollments AS en ON ed.id = en.edition_id
GROUP BY ed.id, ed.code
ORDER BY total_matriculados DESC, ed.code;


-- ------------------------------------------------------------
-- 09. Contar matrículas agrupadas por su estado.
-- Escribe tu SELECT aqui:
SELECT
    en.status AS estado,
    COUNT(*) AS total_matriculas
FROM enrollments AS en
GROUP BY en.status
ORDER BY total_matriculas DESC, en.status;


-- ------------------------------------------------------------
-- 10. Encontrar los cursos que se han ofrecido en dos o más ediciones. Usar HAVING.
-- Escribe tu SELECT aqui:
SELECT
    c.name AS curso,
    COUNT(ed.id) AS total_ediciones
FROM courses AS c
JOIN editions AS ed ON c.id = ed.course_id
GROUP BY c.id, c.name
HAVING COUNT(ed.id) >= 2
ORDER BY total_ediciones DESC, c.name;


-- ------------------------------------------------------------
-- 11. Contar las sesiones programadas en cada edición.
-- Escribe tu SELECT aqui:
SELECT
    ed.code AS codigo_edicion,
    COUNT(se.id) AS total_sesiones
FROM editions AS ed
LEFT JOIN sessions AS se ON ed.id = se.edition_id
GROUP BY ed.id, ed.code
ORDER BY total_sesiones DESC, ed.code;


-- ------------------------------------------------------------
-- 12. Mostrar los certificados emitidos junto al nombre del colaborador y el curso.
-- Escribe tu SELECT aqui:
SELECT
    ce.code AS codigo_certificado,
    co.name AS colaborador,
    c.name AS curso,
    ce.issued_at AS fecha_emision
FROM certificates AS ce
JOIN enrollments AS en ON ce.enrollment_id = en.id
JOIN collaborators AS co ON en.collaborator_id = co.id
JOIN editions AS ed ON en.edition_id = ed.id
JOIN courses AS c ON ed.course_id = c.id
ORDER BY ce.id;


-- ------------------------------------------------------------
-- 13. Mostrar las sesiones realizadas durante septiembre de 2026, junto a su edición.
-- Escribe tu SELECT aqui:
SELECT
    se.id AS codigo_sesion,
    ed.code AS edicion,
    se.topic AS tema,
    se.started_at AS inicio
FROM sessions AS se
JOIN editions AS ed ON se.edition_id = ed.id
WHERE se.started_at >= '2026-09-01 00:00:00'
    AND se.started_at < '2026-10-01 00:00:00'
ORDER BY se.started_at, se.id;


-- ------------------------------------------------------------
-- 14. Mostrar todas las asistencias registradas con el colaborador, tema de la sesión y estado.
-- Escribe tu SELECT aqui:
SELECT
    att.id AS codigo_asistencia,
    co.name AS colaborador,
    se.topic AS tema_sesion,
    att.status AS estado
FROM attendance AS att
JOIN enrollments AS en ON att.enrollment_id = en.id
JOIN collaborators AS co ON en.collaborator_id = co.id
JOIN sessions AS se ON att.session_id = se.id
ORDER BY att.id;


-- ------------------------------------------------------------
-- 15. Contar cuántas asistencias PRESENTE registra cada matrícula con registros de asistencia.
-- Escribe tu SELECT aqui:
SELECT
    att.enrollment_id AS codigo_matricula,
    SUM(CASE WHEN att.status = 'PRESENTE' THEN 1 ELSE 0 END) AS asistencias_presente
FROM attendance AS att
GROUP BY att.enrollment_id
ORDER BY att.enrollment_id;


-- ------------------------------------------------------------
-- 16. Mostrar ediciones con al menos dos matriculados e indicar su capacidad. Usar HAVING.
-- Escribe tu SELECT aqui:
SELECT
    ed.code AS codigo_edicion,
    ed.capacity AS capacidad,
    COUNT(en.id) AS total_matriculados
FROM editions AS ed
JOIN enrollments AS en ON ed.id = en.edition_id
GROUP BY ed.id, ed.code, ed.capacity
HAVING COUNT(en.id) >= 2
ORDER BY total_matriculados DESC, ed.code;


-- ------------------------------------------------------------
-- 17. Mostrar matrículas cuya asistencia registrada tenga al menos 80% PRESENTE. Usar GROUP BY y HAVING.
-- Escribe tu SELECT aqui:
SELECT
    att.enrollment_id AS codigo_matricula,
    COUNT(*) AS total_registros,
    SUM(CASE WHEN att.status = 'PRESENTE' THEN 1 ELSE 0 END) AS presentes,
    ROUND(100 * SUM(CASE WHEN att.status = 'PRESENTE' THEN 1 ELSE 0 END) / COUNT(*), 1) AS porcentaje_presente
FROM attendance AS att
GROUP BY att.enrollment_id
HAVING SUM(CASE WHEN att.status = 'PRESENTE' THEN 1 ELSE 0 END) / COUNT(*) >= 0.8
ORDER BY att.enrollment_id;


-- ------------------------------------------------------------
-- 18 | SUBCONSULTA. SUBCONSULTA: encontrar colaboradores que todavía no se han matriculado en ninguna edición. Usar NOT EXISTS.
-- Escribe tu SELECT aqui:
SELECT
    co.id AS codigo_colaborador,
    co.name AS colaborador
FROM collaborators AS co
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments AS en
    WHERE en.collaborator_id = co.id
)
ORDER BY co.id;


-- ------------------------------------------------------------
-- 19 | SUBCONSULTA. SUBCONSULTA: mostrar ediciones cuya capacidad sea mayor al promedio de capacidades de las ediciones.
-- Escribe tu SELECT aqui:
SELECT
    ed.code AS codigo_edicion,
    ed.capacity AS capacidad
FROM editions AS ed
WHERE ed.capacity > (SELECT AVG(capacity) FROM editions)
ORDER BY ed.capacity DESC, ed.code;


-- ------------------------------------------------------------
-- 20 | SUBCONSULTA. SUBCONSULTA: mostrar colaboradores que estén matriculados en alguna edición del curso con código CUR-IA. Usar IN.
-- Escribe tu SELECT aqui:
SELECT
    co.id AS codigo_colaborador,
    co.name AS colaborador
FROM collaborators AS co
WHERE co.id IN (
    SELECT en.collaborator_id
    FROM enrollments AS en
    JOIN editions AS ed ON en.edition_id = ed.id
    JOIN courses AS c ON ed.course_id = c.id
    WHERE c.code = 'CUR-IA'
)
ORDER BY co.id;